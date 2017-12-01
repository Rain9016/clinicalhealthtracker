<?php
require_once $_SERVER['DOCUMENT_ROOT'] . "/api/functions.php";

$response = array();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $json = file_get_contents('php://input');
    $data = json_decode($json, TRUE); //convert JSON into array

    $uniqueId = getUser($data["uniqueId"]);

    if ($uniqueId) {
        $response['error'] = false;
        $response['message'] = "User found.";
    } else {
        $response['error'] = true;
        $response['message']="User not found.";
    }
} else {
    $response['error'] = true;
    $response['message'] = "You are not authorized to view this page.";
}

echo json_encode($response);