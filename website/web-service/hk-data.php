<?php
//useful links; http://thisinterestsme.com/sending-json-via-post-php/

$url = 'http://cht.dev/web-service/insert-hk-data.php';
$ch = curl_init($url);

$array = array(array("user_id"=>"1234", "start_time"=>"2017-02-08 23:40:00", "end_time"=>"2017-02-08 02:02:02", "steps"=>"27", "distance"=>"104"), array("user_id"=>"123", "start_time"=>"2017-02-08 03:03:03", "end_time"=>"2017-02-08 04:04:04", "steps"=>"43", "distance"=>"44"));

$data = array(
    "data"=>$array
);

$jsonDataEncoded = json_encode($data);

//Tell cURL that we want to send a POST request.
curl_setopt($ch, CURLOPT_POST, 1);

//Attach our encoded JSON string to the POST fields.
curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonDataEncoded);

//Set the content type to application/json
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));

//Execute the request
$result = curl_exec($ch);
