<?php

//http://stackoverflow.com/questions/7047870/issue-reading-http-request-body-from-a-json-post-in-php
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE); //convert JSON into array

$data = $input["data"];

foreach ($data as $entry) {
    echo $entry["start_date"];
}
