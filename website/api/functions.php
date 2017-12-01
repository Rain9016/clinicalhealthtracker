<?php
require_once $_SERVER['DOCUMENT_ROOT'] . "/db/connect.php";

function getUser($unique_id) {
    $db_name = "trial_data";
    $db = connect($db_name);

    $query = "SELECT first_name FROM patients WHERE unique_id=:unique_id";
    $stmt = $db->prepare($query);

    $query_params = array(':unique_id'=>$unique_id);

    try {
        $stmt->execute($query_params);
    } catch (PDOException $e) {
        //die($e->getMessage()); //DELETE!
        return false;
    }

    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($result) {
        return true;
    } else {
        return false;
    }
}

function insertHealthData($data) {
    $db_name = "patient_data";
    $db = connect($db_name);

    $query = "INSERT INTO health_data (unique_id, start_time, end_time, steps, distance) VALUES (:unique_id, :start_time, :end_time, :steps, :distance)";
    $stmt = $db->prepare($query);

    foreach ($data as $entry) {
        $query_params = array(':unique_id'=>$entry["uniqueId"], ':start_time'=>$entry["startTime"], ':end_time'=>$entry["endTime"], ':steps'=>$entry["steps"], ':distance'=>$entry["distance"]);

        try {
            $result = $stmt->execute($query_params);
        } catch (PDOException $e) {
            //die($e->getMessage()); //DELETE!
            return false;
        }

        if (!$result) {
            return false;
        }
    }

    return true;
}

function insertLocationData($data) {
    $db_name = "patient_data";
    $conn = connect($db_name);

    $query = "INSERT INTO location_data (unique_id, time, latitude, longitude) VALUES (:unique_id, :time, :latitude, :longitude)";
    $stmt = $conn->prepare($query);

    foreach ($data as $entry) {
        $query_params = array(':unique_id'=>$entry["uniqueId"], ':time'=>$entry["time"], ':latitude'=>$entry["latitude"], ':longitude'=>$entry["longitude"]);

        try {
            $result = $stmt->execute($query_params);
        } catch (PDOException $e) {
            //die($e->getMessage()); //DELETE!
            return false;
        }

        if (!$result) {
            return false;
        }
    }

    return true;
}

function insertSurveyData($data) {
    $db_name = "patient_data";
    $db = connect($db_name);

    $query = "INSERT INTO survey_data (unique_id, title, time, question, answer) VALUES (:unique_id, :title, :time, :question, :answer)";
    $stmt = $db->prepare($query);

    foreach ($data as $entry) {
        $query_params = array(':unique_id'=>$entry["uniqueId"], ':title'=>$entry["title"], ':time'=>$entry["time"], ':question'=>$entry["question"], ':answer'=>$entry["answer"]);

        try {
            $result = $stmt->execute($query_params);
        } catch (PDOException $e) {
            //die($e->getMessage()); //DELETE!
            return false;
        }

        if (!$result) {
            return false;
        }
    }

    return true;
}

function insertWalkTestData($data) {
    $db_name = "patient_data";
    $db = connect($db_name);

    $query = "INSERT INTO walk_test_data (unique_id, time, steps, distance, laps) VALUES (:unique_id, :time, :steps, :distance, :laps)";
    $stmt = $db->prepare($query);

    foreach ($data as $entry) {
        $query_params = array(':unique_id'=>$entry["uniqueId"], ':time'=>$entry["time"], ':steps'=>$entry["steps"], ':distance'=>$entry["distance"], ':laps'=>$entry["laps"]);

        try {
            $result = $stmt->execute($query_params);
        } catch (PDOException $e) {
            //die($e->getMessage()); //DELETE!
            return false;
        }

        if (!$result) {
            return false;
        }
    }

    return true;
}

function insertHeightWeightData($data) {
    $db_name = "patient_data";
    $db = connect($db_name);

    $query = "INSERT INTO height_weight_data (unique_id, time, height, weight) VALUES (:unique_id, :time, :height, :weight)";
    $stmt = $db->prepare($query);

    foreach ($data as $entry) {
        $query_params = array(':unique_id'=>$entry["uniqueId"], ':time'=>$entry["time"], ':height'=>$entry["height"], ':weight'=>$entry["weight"]);

        try {
            $result = $stmt->execute($query_params);
        } catch (PDOException $e) {
            //die($e->getMessage()); //DELETE!
            return false;
        }

        if (!$result) {
            return false;
        }
    }

    return true;
}
