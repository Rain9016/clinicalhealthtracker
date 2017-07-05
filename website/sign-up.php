<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . "/db/connect.php";
    require_once 'functions.php';

    /* CONNECT TO DB */
    $db_name = "trial_data";
    $db = connect($db_name);

    /* IF ALL FIELDS NOT FILLED OUT */
    if (!empty($_POST)) {
        if(empty($_POST['first_name']))
        {
            echo("Please enter first name.<br />");
        }

        if(empty($_POST['last_name']))
        {
            echo("Please enter last name.<br />");
        }

        if(empty($_POST['email']))
        {
            echo("Please enter e-mail.<br />");
        }
    }

    if(!empty($_POST['first_name']) && !empty($_POST['last_name']) && !empty($_POST['email'])) {
        $first_name = $_POST['first_name'];
        $last_name = $_POST['last_name'];
        $email = $_POST['email'];
        $trial_id = $_POST['trial_id'];

        $query = "SELECT extra_info FROM trials WHERE id=:trial_id";
        $query_params = array(':trial_id'=>$trial_id);

        try {
            $stmt = $db->prepare($query);
            $stmt->execute($query_params);
        } catch (PDOException $e) {
            die($e->getMessage()); //DELETE!
        }

        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($result) {
            $unique_id = uniqid();

            $query = "INSERT INTO patients (unique_id, first_name, last_name, email, trial_id) VALUES (:unique_id, :first_name, :last_name, :email, :trial_id)";
            $query_params = array(':unique_id'=>$unique_id, ':first_name'=>$first_name, ':last_name'=>$last_name, ':email'=>$email, ':trial_id'=>$trial_id);

            try {
                $stmt = $db->prepare($query);
                $stmt->execute($query_params);
            } catch (PDOException $e) {
                die($e->getMessage()); //DELETE!
            }

            if ($result["extra_info"] == 0) {
                $location = "confirmation.php?unique_id=" . $unique_id;
                header("Location: " . $location);
            } else {
                $location = "extra-info.php?unique_id=" . $unique_id;
                header("Location: " . $location);
            }
        } else {
            echo "error";
        }
    }
?>

<!doctype html>
<html>
<head>
<title>Clinical Health Tracker</title>
</head>
<body>
<form method="post" action="sign-up.php">
sign up<br />
<input type="text" placeholder="first name" name="first_name" required><br>
<input type="text" placeholder="last name" name="last_name" required><br>
<input type="text" placeholder="email" name="email" required><br>
<?php
    $query = "SELECT * FROM trials";

    try {
        $stmt = $db->prepare($query);
        $stmt->execute($query_params);
    } catch (PDOException $e) {
        die($e->getMessage()); //DELETE!
    }

    $results = $stmt->fetchAll();

    if ($results) {
        echo "<select name=\"trial_id\">";
        foreach ($results as $row) {
            echo "<option value=" . $row["id"] . ">" . $row["name"] . "</option>";
        }
        echo "</select>";
    } else {
        echo "There are no trials to display";
    }

    echo "<br />";
?>
<button type="submit">sign up</button>
</form>
</body>
</html>
