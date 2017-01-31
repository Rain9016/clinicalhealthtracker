<?php

class dbfunctions {
    private $conn;

    function __construct() {
        $path = $_SERVER['DOCUMENT_ROOT'] . "/webservice/connect/connecttodb.php";
        require_once $path;
        $connecttodb = new connecttodb();
        $this->conn = $connecttodb->connect();
    }

    //retrieves a user given their id
    function getUser($id) {
        try {
            $stmt = $this->conn->prepare('SELECT name FROM users WHERE id = :id');
            $result = $stmt->execute(['id' => $id]);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
        //REMOVE!
        } catch (PDOException $e) {
            echo $e->getMessage();
        }

        if ($row) {
            return $row['name'];
        } else {
            return false;
        }
    }

    //creates a new user
    /*
    function createUser($name) {
        try {
            $stmt = $this->conn->prepare('INSERT INTO users(name) VALUES (:name)');
            $result = $stmt->execute(['name' => $name]);
        //REMOVE!
        } catch (PDOException $e) {
            echo $e->getMessage();
        }

        if ($result) {
            return true;
        } else {
            return false;
        }
    }
    */
}
