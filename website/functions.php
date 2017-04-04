<?php
/* from http://forums.devshed.com/php-faqs-stickies-167/program-basic-secure-login-system-using-php-mysql-891201.html and http://www.wikihow.com/Create-a-Secure-Login-Script-in-PHP-and-MySQL */
function sec_session_start() {
    $session_name = 'secure_session';
    session_name($session_name);

    $secure = true;
    $httponly = true;

    //forces sessions to only use cookies
    $use_only_cookies = ini_set('session.use_only_cookies', 1);
    if ($use_only_cookies === FALSE) {
        header("Location: index.php");
        die();
    }

    $cookieParams = session_get_cookie_params();
    session_set_cookie_params($cookieParams["lifetime"], $cookieParams["path"], $cookieParams["domain"], $secure, $httponly);

    session_start();
    session_regenerate_id(true);
}

function logged_in($db) {
    /* IF SESSION VARIABLES ARE SET, FIND USER */
    if (isset($_SESSION['user_id'], $_SESSION['username'], $_SESSION['user_browser'])) {
        $user_id = $_SESSION['user_id'];
        $username = $_SESSION['username'];

        $query = "SELECT 1 FROM users WHERE id=:user_id AND username=:username";
        $query_params = array(':user_id'=>$user_id, ':username'=>$username);

        try {
            $stmt = $db->prepare($query);
            $stmt->execute($query_params);
        } catch (PDOException $e) {
            die($e->getMessage()); //DELETE!
        }

        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        /* IF USER FOUND, SEE IF USER'S BROWSER MATCHES BROWSER STORED IN SESSION VARIABLE */
        if ($result) {
            $user_browser = SERVER['HTTP_USER_AGENT'];

            /* IF USER'S BROWSER MATCHES BROWSER STORED IN SESSION VARIABLE */
            if ($user_browser = $_SESSION['user_browser']) {
                return true;
            /* IF USER'S BROWSER DOES NOT MATCH BROWSER STORED IN SESSION VARIABLE */
            } else {
                return false;
            }
        /* IF USER NOT FOUND */
        } else {
            return false;
        }
    /* IF SESSION VARIABLES NOT SET */
    } else {
        return false;
    }
}

////////////////////////////
//                        //
//  clinician-signup.php  //
//                        //
////////////////////////////
function register($username, $hashed_password, $email, $db) {
    $query = "INSERT INTO users (username, password, email) VALUES (:username, :password, :email)";
    $query_params = array(':username'=>$username, ':password'=>$hashed_password, ':email'=>$email);

    try {
        $stmt = $db->prepare($query);
        $stmt->execute($query_params);
    } catch (PDOException $e) {
        die($e->getMessage()); //DELETE!
    }
}

/////////////////
//             //
//  index.php  //
//             //
/////////////////
function login_success($username, $password, $db) {
    $query = "SELECT id, username, password FROM users WHERE username=:username LIMIT 1";
    $query_params = array(':username'=>$username);

    try {
        $stmt = $db->prepare($query);
        $stmt->execute($query_params);
    } catch (PDOException $e) {
        die($e->getMessage()); //DELETE!
    }

    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    /* IF USERNAME EXISTS, VERIFY PASSWORD */
    if ($result) {
        $user_id = $result["id"];
        $hashed_password = $result["password"];

        /* IF PASSWORD IS CORRECT */
        if (password_verify($password, $hashed_password)) {
            $_SESSION['user_id'] = $user_id;
            $_SESSION['username'] = $username;

            $user_browser = $_SERVER['HTTP_USER_AGENT'];
            $_SESSION['user_browser'] = $user_browser;

            return true;
        /* IF PASSWORD IS INCORRECT, ADD FAILED ATTEMPT TO DB */
        } else {
            $currentTime = time();

            $query = "INSERT INTO login_attempts (user_id, time) VALUES (:user_id, :time)";
            $query_params = array('user_id'=>$user_id, 'time'=>$currentTime);

            try {
                $stmt = $db->prepare($query);
                $stmt->execute($query_params);
            } catch (PDOException $e) {
                die($e->getMessage()); //DELETE!
            }

            return false;
        }
    /* IF USERNAME DOES NOT EXIST */
    } else {
        return false;
    }
}

function using_brute_force($username, $db) {
    $query = "SELECT id FROM users WHERE username=:username LIMIT 1";
    $query_params = array(':username'=>$username);

    try {
        $stmt = $db->prepare($query);
        $stmt->execute($query_params);
    } catch (PDOException $e) {
        die($e->getMessage()); //DELETE!
    }

    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    /* IF USERNAME EXISTS, FIND FAILED LOGIN ATTEMPTS */
    if ($result) {
        $user_id = $result["id"];

        $currentTime = time();
        $timeWindow = $currentTime - (60 * 60 * 2);

        $query = "SELECT time FROM login_attempts WHERE user_id=:user_id AND time > " . $timeWindow;
        $query_params = array(':user_id'=>$user_id);

        try {
            $stmt = $db->prepare($query);
            $stmt->execute($query_params);
        } catch (PDOException $e) {
            die($e->getMessage()); //DELETE!
        }

        $results = $stmt->fetchAll();

        /* IF USER HAS FAILED LOGIN ATTEMPTS */
        if ($results) {
            /* IF USER HAS HAD 2 OR MORE FAILED LOGIN ATTEMPTS */
            if (count($results) >= 2) {
                return true;
            /* IF USER HAS NOT HAD 2 OR MORE FAILED LOGIN ATTEMPTS */
            }  else {
                return false;
            }
        /* IF USER DOES NOT HAVE FAILED LOGIN ATTEMPTS */
        } else {
            return false;
        }
    /* IF USERNAME DOES NOT EXIST */
    } else {
        return false;
    }
}