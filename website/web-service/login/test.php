<?php
$path = $_SERVER['DOCUMENT_ROOT'] . "/webservice/connect/connecttodb.php";
require_once $path;

$connecttodb = new connecttodb();
$conn = $connecttodb->connect();

$id = 1;

try {
    $stmt = $conn->prepare('SELECT name FROM users WHERE id = :id');
    $result = $stmt->execute(['id' => $id]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
//REMOVE!
} catch (PDOException $e) {
    echo $e->getMessage();
}

if ($row) {
    echo $row['name'];
} else {
    echo "no user found";
}
