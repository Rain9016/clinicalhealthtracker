<?php

function connect($db_name) {
    require_once $_SERVER['DOCUMENT_ROOT'] . "/db/config.php";

    try {
        $conn = new PDO(dsn($db_name), USER, PASS);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        return $conn;
    } catch (PDOException $e) {
        echo "Error: Could not connect to db."; //DELETE
        die();
    }
}