<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . "/db/connect.php";
    require_once 'functions.php';

    /* START SECURE SESSION */
    sec_session_start();

    /* CONNECT TO DB */
    $db_name = "secure_login";
    $db = connect($db_name);

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
    }

    /* IF ALL FIELDS FILLED OUT */
    if(!empty($_POST['username']) && !empty($_POST['password'])) {
        $username = $_POST['username'];
        $password = $_POST['password'];

        if (using_brute_force($username, $db)) {
            echo "account locked";
        } else if (login_success($username, $password, $db)) {
            header('Location: main.php');
            die();
        } else {
            echo("Username or password incorrect.<br />");
        }
    }
?>

<!doctype html>
<html>
<head>
<title>Clinical Health Tracker</title>
</head>
<body>
<form method="post" action="index.php">
welcome to health tracker<br>
<input type="text" placeholder="username" name="username" required><br>
<input type="password" placeholder="password" name="password" required><br>
<button type="submit">log in</button> or <a href="sign-up.php">sign up a patient</a>
</form>
</body>
</html>
