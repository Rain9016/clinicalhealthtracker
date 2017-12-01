<?php

//database
DEFINE('HOST', 'localhost');
DEFINE('USER', 'root');
DEFINE('PASS', 'root');

function dsn($db_name) {
    return "mysql:host=".HOST.";dbname=$db_name;charset=utf8";
}

//clinician register
DEFINE('SECRET_CODE', 'adelaide.edu.au');