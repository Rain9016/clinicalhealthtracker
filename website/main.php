<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . "/db/connect.php";
    require_once 'functions.php';

    /* START SECURE SESSION */
    sec_session_start();

    /* CONNECT TO DB */
    $db_name = "secure_login";
    $db = connect($db_name);

    if(!logged_in($db)) {
        header('Location: index.php');
        die();
    }
?>

HELLO!
