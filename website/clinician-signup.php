<?php
    require_once 'functions.php';
    require_once $_SERVER['DOCUMENT_ROOT'] . "/db/connect.php";

    /* IF ALL FIELDS NOT FILLED OUT */
    if (!empty($_POST)) {
        if(empty($_POST['username']))
        {
            echo("Please enter username.<br />");
        }

        if(empty($_POST['password']))
        {
            echo("Please enter password.<br />");
        }

        if(empty($_POST['email']))
        {
            echo("Please enter email.<br />");
        }

        if(empty($_POST['secret_code']))
        {
            echo("Please enter secret code.<br />");
        }
    }

    /* IF ALL FIELDS FILLED OUT */
    if(!empty($_POST['username']) && !empty($_POST['password']) && !empty($_POST['email']) && !empty($_POST['secret_code']))
    {
        $db_name = "secure_login";
        $db = connect($db_name);
        $username = $_POST['username'];
        $password = $_POST['password'];
        $email = $_POST['email'];
        $secret_code = $_POST['secret_code'];


        /* IF SECRET CODE INCORRECT */
        if ($secret_code != SECRET_CODE) {
            echo "secret code incorrect";
        /* IF SECRET CODE CORRECT, FIND USER */
        } else {
            $query = "SELECT * FROM users WHERE username=:username OR email=:email";
            $query_params = array(':username'=>$username, ':email'=>$email);

            try {
                $stmt = $db->prepare($query);
                $stmt->execute($query_params);
            } catch (PDOException $e) {
                die($e->getMessage()); //DELETE!
            }

            $result = $stmt->fetch(PDO::FETCH_ASSOC);

            /* IF USER EXISTS */
            if($result) {
                echo "user already exists";
            /* IF USER DOESN'T EXIST, ADD USER TO DB AND REDIRECT TO LOGIN */
            } else {
                $hashed_password = password_hash($password, PASSWORD_DEFAULT);
                register($username, $hashed_password, $email, $db);

                header("Location: index.php");
                exit;
            }
        }
    }
?>

<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Clinical Health Tracker</title>
<style type="text/css">
    *, :before, :after {
        margin: 0;
        padding: 0;
    }

    @media (min-width : 320px) {
    }

    @media (min-width : 768px) and (max-width : 1024px) {

    }
</style>
</head>
<body>
<form method="post" action="clinician-signup.php">
clinician signup<br>
<input type="text" placeholder="username" name="username" required><br>
<input type"password" placeholder="password" name="password" required><br>
<input type="text" placeholder="email" name="email" required><br>
<input type="text" placeholder="secret code" name="secret_code" required><br>
<button type="submit">sign up</button>
</form>
</body>
</html>