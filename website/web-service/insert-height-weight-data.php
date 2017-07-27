<?php
//useful links; //http://stackoverflow.com/questions/7047870/issue-reading-http-request-body-from-a-json-post-in-php
require_once $_SERVER['DOCUMENT_ROOT'] . "/web-service/functions.php";

$response = array();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $inputJSON = file_get_contents('php://input');
    $input = json_decode($inputJSON, TRUE); //convert JSON into array

    $data = $input["height_weight_data"];

    $result = insert_height_weight_data($data);

    if ($result) {
        $response['error'] = false;
        $response['message'] = 'Height and weight data successfully submitted to the database';
    } else {
        $response['error'] = true;
        $response['message'] = 'There was an error submitting your height and weight data to the database';
    }
} else {
    $response['error'] = true;
    $response['message'] = 'You are not authorized to carry out this operation';
}

echo json_encode($response);
