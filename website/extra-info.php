<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . "/db/connect.php";

    /* CONNECT TO DB */
    $db_name = "trial_data";
    $db = connect($db_name);

    /* IF NO UNIQUE ID WAS PASSED VIA GET PARAM, PRINT ERROR */
    if (empty($_GET['unique_id'])) {
        echo "Error: You do not have permission to view this page.";
        exit;
    /* IF UNIQUE ID WAS PASSED VIA GET PARAM, STORE UNIQUE ID IN VARIABLE */
    } else {
        $unique_id = $_GET['unique_id'];
    }

    /* CHECK IF UNIQUE ID EXISTS */
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
        echo "Error: Patient not found.";
    /* IF UNIQUE ID EXISTS, GET TRIAL QUESTIONS */
    } else {
        $first_name = $result['first_name'];
        $patient_id = $result["id"];
        $trial_id = $result["trial_id"];
        
        $query = "SELECT * FROM questions WHERE trial_id=:trial_id";
        $query_params = array(':trial_id'=>$trial_id);

        try {
            $stmt = $db->prepare($query);
            $stmt->execute($query_params);
        } catch (PDOException $e) {
            die($e->getMessage()); //DELETE!
        }
        
        $results = $stmt->fetchAll();
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST' && $_GET['form_submitted'] == true) {
        $isEmptyFields = false;
    
        if ($results) {
            foreach ($results as $row) {
                if (empty($_POST[$row['id']])) {
                    $isEmptyFields = true;
                }
            }
        }
        
        if ($isEmptyFields) {
            echo "<font color=red>Error: Please complete all fields.</font>";
        } else {
            $isError = false;

            foreach ($results as $row) {
                $answer = $_POST[$row['id']];
                $question_id = $row['id'];

                $query = "INSERT INTO answers (answer, patient_unique_id, patient_id, question_id) VALUES (:answer, :patient_unique_id, :patient_id, :question_id)";
                $query_params = array(':answer'=>$answer, ':patient_unique_id'=>$unique_id, ':patient_id'=>$patient_id, ':question_id'=>$question_id);

                try {
                    $stmt = $db->prepare($query);
                    $stmt->execute($query_params);
                } catch (PDOException $e) {
                    die($e->getMessage()); //DELETE!
                }

                $errorCode = $stmt->errorCode();

                if ($errorCode != 0) {
                    $isError = true;
                }
            }

            if ($isError) {
                echo "Error: An error occured while inserting ".$first_name."'s answers into the database";
                exit;
            } else {
                header('Location: /register-success.php/?unique_id='.$unique_id);
                exit;
            }
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
<?php
        if ($results) {
            echo '<form action="extra-info.php/?unique_id='.$_GET['unique_id'].'&form_submitted=true" method="post">';
            
			foreach ($results as $row) {
                echo $row['question'];
				echo '<br />';
                
				if ($row['type'] == 'text_field') {
					echo '<input name="'.$row['id'].'" type="text" placeholder="answer">';
					echo '<br /><br />';
				} else if ($row['type'] == 'multiple_choice') {
                    $query = "SELECT * FROM choices WHERE question_id=:question_id";
                    $query_params = array(':question_id'=>$row['id']);

                    try {
                        $stmt = $db->prepare($query);
                        $stmt->execute($query_params);
                    } catch (PDOException $e) {
                        die($e->getMessage()); //DELETE!
                    }
                    
                    $choices = $stmt->fetchAll();

					if (count($choices) > 0) {
						foreach($choices as $choice) {
                            echo '<input name ="'.$row['id'].'" type="radio" value="'.$choice['choice'].'">';
                            echo $choice['choice'];
							echo ' ';
                        }
						echo '<br /><br />';
					} else {
						echo 'Could not find choices associated with this question';
                        echo '<br /><br />';
					}
				} else if ($row['type'] == 'boolean') {
                    echo '<input name ="'.$row['id'].'" type="radio" value="yes">'.'yes';
                    echo ' ';
                    echo '<input name ="'.$row['id'].'" type="radio" value="no">'.'no';
                    echo '<br /><br />';
                }
            }
            
            echo '<button type="submit">register patient</button>';
			echo '</form>';
			echo '<br /><br />';
        } else {
            echo "Error: Could not find questions associated with this trial.";
        }
?>
</body>
</html>