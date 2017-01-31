<?php

class connecttodb
{
    private $conn;

    function __construct()
    {
    }

    function connect()
    {
        require_once 'config.php';

        try {
            $this->conn = new PDO($dsn, $user, $pass, $opt);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            return $this->conn;
        } catch (PDOException $e) {
            echo 'Connection failed: ' . $e->getMessage();
        }
    }
}
