<?php
require_once $_SERVER['DOCUMENT_ROOT'] . "/web-service/functions.php";

$response = array();

if(!empty($_POST['unique_id'])) {
    $unique_id = $_POST['unique_id'];

    $name = get_user($unique_id);

    if ($name) {
        $response['error']=false;
        $response['name'] = $name;
    } else {
        $response['error']=true;
        $response['message']='User not found';
    }
} else {
    $response['error'] = true;
    $response['message'] = 'No authorization';
}

echo json_encode($response);
