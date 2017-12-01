<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . "/db/connect.php";

    /* CONNECT TO DB */
    $db_name = "trial_data";
    $db = connect($db_name);

    /* CHECK IF UNIQUE ID PASSED VIA GET PARAM */
    if (empty($_GET['unique_id'])) {
        echo "Error: You do not have permission to view this page.";
        exit;
    } else {
        $unique_id = $_GET['unique_id'];
    }

    /* CHECK IF UNIQUE ID PASSED VIA GET PARAM EXISTS */
	$query = "SELECT * FROM patients WHERE unique_id=:unique_id";
    $query_params = array(':unique_id'=>$unique_id);

    try {
        $stmt = $db->prepare($query);
        $stmt->execute($query_params);
    } catch (PDOException $e) {
        die($e->getMessage()); //DELETE!
    }

    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    /* IF UNIQUE ID DOES NOT EXIST, PRINT ERROR */
    if (!$result) {
        echo "Error: User not found.";
        exit;
    /* IF UNIQUE ID EXISTS, GET TRIAL QUESTIONS */
    } else {
        $unique_id = $result["unique_id"];
        $first_name = $result["first_name"];
        $last_name = $result["last_name"];
        $trial_id = $result["trial_id"];
        
        $query = "SELECT * FROM trials WHERE id=:trial_id";
        $query_params = array(':trial_id'=>$trial_id);

        try {
            $stmt = $db->prepare($query);
            $stmt->execute($query_params);
        } catch (PDOException $e) {
            die($e->getMessage()); //DELETE!
        }
        
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$result) {
            echo "Error: Could not find trial associated with this user";
        } else {
            $trial_name = $result['name'];
        }
    } 
?>

<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Clinical Health Tracker</title>
<style type="text/css">
    *, :before, :after {
        margin: 0;
        padding: 0;
    }

    @media (min-width : 320px) {
    }

    @media (min-width : 768px) and (max-width : 1024px) {

    }
</style>
</head>
<body>
<strong>Congratulations.</strong>
<br /><br />
<?php echo $first_name." ".$last_name." has successfully registered for the ".$trial_name." trial." ?>
<br /><br />
Their unique identifier is <strong><?php echo $unique_id ?></strong>
</body>
</html>