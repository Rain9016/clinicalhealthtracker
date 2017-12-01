<?php
//useful links; //http://stackoverflow.com/questions/7047870/issue-reading-http-request-body-from-a-json-post-in-php
require_once $_SERVER['DOCUMENT_ROOT'] . "/api/functions.php";

$response = array();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $json = file_get_contents('php://input');
    $data = json_decode($json, TRUE); //convert JSON into array

    $result = insertHeightWeightData($data);

    if ($result) {
        $response['error'] = false;
        $response['message'] = 'Your height and weight data was successfully submitted to the database.';
    } else {
        $response['error'] = true;
        $response['message'] = 'There was an error submitting your height and weight data to the database.';
    }
} else {
    $response['error'] = true;
    $response['message'] = 'You are not authorized to view this page.';
}

echo json_encode($response);
