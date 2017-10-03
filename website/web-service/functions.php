<?php
require_once $_SERVER['DOCUMENT_ROOT'] . "/db/connect.php";

function get_user($unique_id) {
    $db_name = "trial_data";
    $db = connect($db_name);

    $query = "SELECT first_name FROM patients WHERE unique_id=:unique_id";
    $query_params = array(':unique_id'=>$unique_id);

    try {
        $stmt = $db->prepare($query);
        $stmt->execute($query_params);
    } catch (PDOException $e) {
        //die($e->getMessage()); //DELETE!
        return false;
    }

    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($result) {
        return $result['first_name'];
    } else {
        return false;
    }
}

function insert_hk_data($data) {
    $db_name = "patient_data";
    $db = connect($db_name);

    $query = "INSERT INTO hk_data (unique_id, start_time, end_time, steps, distance) VALUES (:unique_id, :start_time, :end_time, :steps, :distance)";

    foreach ($data as $entry) {
        $query_params = array(':unique_id'=>$entry["unique_id"], ':start_time'=>$entry["start_time"], ':end_time'=>$entry["end_time"], ':steps'=>$entry["steps"], ':distance'=>$entry["distance"]);

        try {
            $stmt = $db->prepare($query);
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

function insert_location_data($data) {
    $db_name = "patient_data";
    $db = connect($db_name);

    $query = "INSERT INTO location_data (unique_id, time, latitude, longitude) VALUES (:unique_id, :time, :latitude, :longitude)";

    foreach ($data as $entry) {
        $query_params = array(':unique_id'=>$entry["unique_id"], ':time'=>$entry["time"], ':latitude'=>$entry["latitude"], ':longitude'=>$entry["longitude"]);

        try {
            $stmt = $db->prepare($query);
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

function insert_survey_data($data) {
    $db_name = "patient_data";
    $db = connect($db_name);

    $query = "INSERT INTO survey_data (unique_id, title, time, question, answer) VALUES (:unique_id, :title, :time, :question, :answer)";

    foreach ($data as $entry) {
        $sanitizedAnswer = htmlspecialchars($entry["answer"]);
        $query_params = array(':unique_id'=>$entry["unique_id"], ':title'=>$entry["title"], ':time'=>$entry["time"], ':question'=>$entry["question"], ':answer'=>$sanitizedAnswer);

        try {
            $stmt = $db->prepare($query);
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

function insert_walk_test_data($data) {
    $db_name = "patient_data";
    $db = connect($db_name);

    $query = "INSERT INTO walk_test_data (unique_id, time, steps, distance, laps) VALUES (:unique_id, :time, :steps, :distance, :laps)";

    foreach ($data as $entry) {
        $query_params = array(':unique_id'=>$entry["unique_id"], ':time'=>$entry["time"], ':steps'=>$entry["steps"], ':distance'=>$entry["distance"], ':laps'=>$entry["laps"]);

        try {
            $stmt = $db->prepare($query);
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

function insert_height_weight_data($data) {
    $db_name = "patient_data";
    $db = connect($db_name);

    $query = "INSERT INTO height_weight_data (unique_id, time, height, weight) VALUES (:unique_id, :time, :height, :weight)";

    foreach ($data as $entry) {
        $query_params = array(':unique_id'=>$entry["unique_id"], ':time'=>$entry["time"], ':height'=>$entry["height"], ':weight'=>$entry["weight"]);

        try {
            $stmt = $db->prepare($query);
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
