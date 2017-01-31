<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){
    //getting values
    $id = $_POST['id'];

    $path = $_SERVER['DOCUMENT_ROOT'] . "/webservice/api/dbfunctions.php";
    require_once $path;

    $dbfunctions = new dbfunctions();

    //get user
    $name = $dbfunctions->getUser($id);

    if (!$name) {
        $response['error']=true;
        $response['message']='user not found';
    } else {
        $response['error']=false;
        $response['name'] = $name;
    }
} else {
    $response['error']=true;
    $response['message']='You are not authorized';
}

echo json_encode($response);
