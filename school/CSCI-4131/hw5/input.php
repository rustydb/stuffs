<?php
    // Start or grab session
    session_start();
    $name_err = $dow_err = $start_err = $end_err = $loc_err = "";
    // See if we are clearing the cal
    if (isset($_POST['clear'])) {
        // Clear session (clear events)
        unset($_SESSION['locations']);
        // Done, go to cal and exit
        header('Location: calendar.php');
        exit();
    }
    // Validate fields
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        if (empty($_POST["event_name"])) {
            $name_err = "Event Name required";
            $problem = TRUE;
        }
        if (empty($_POST["event_dow"])) {
            $dow_err = "Day of the Week required";
            $problem = TRUE;
        }
        if (empty($_POST["event_start"])) {
            $start_err = "Start Time required";
            $problem = TRUE;
        }
        if (empty($_POST["event_end"])) {
            $end_err = "End Time required";
            $problem = TRUE;
        }
        if (empty($_POST["event_loc"])) {
            $loc_err = "Location required";
            $problem = TRUE;
        }
    }
    if(! $problem) {
        if (! empty($_POST)) {
            // Initialize array if not set
            if (! isset($_SESSION['locations'])) {
                $_SESSION['locations']['Mon']='';
                $_SESSION['locations']['Tue']='';
                $_SESSION['locations']['Wed']='';
                $_SESSION['locations']['Thu']='';
                $_SESSION['locations']['Fri']='';
            }
            // Populate array otherwise
            $_SESSION ['locations'] [$_POST['event_dow']] [] = array(
                'event_name'    =>  $_POST['event_name'],
                'event_start'   =>  $_POST['event_start'],
                'event_end'     =>  $_POST['event_end'],
                'event_loc'     =>  $_POST['event_loc']
                );
            // Done, go to cal and exit
            header('Location: calendar.php');
            exit();
        }
    }
?>

<!DOCTYPE html>
<html>
    <head lang="en">
        <meta charset="UTF-8">
        <link rel = "stylesheet" type = "text/css"
        href = "style.css">
        <title>Calendar Input</title>
    </head>
    <body>
        <h1 class = "title"><strong>Calendar Input</strong></h1>
        <!--Nav Bar-->
        <nav>
        <a href="calendar.php">Calendar</a>
        <a href="input.php">Input</a>
        </nav>
        <!--Form-->
        <form class = "calin" method = "post"
            action = "<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
            <div><label>Event Name:</label>
                <input name="event_name" type="text" maxlength="64">
                <span class="error">* <?php echo $name_err;?></span>
                <br>
                <label>Event Day:</label>
                <select name = "event_dow">
                    <option value = "Mon">Monday</option>
                    <option value = "Tue">Tuesday</option>
                    <option value = "Wed">Wednesday</option>
                    <option value = "Thu">Thursday</option>
                    <option value = "Fri">Friday</option>
                </select>
                <span class="error">* <?php echo $dow_err;?></span>
                <br>
                <label>Start Time:</label>
                <input name="event_start" type="text"/>
                <span class="error">* <?php echo $start_err;?></span>
                <br>
                <label>End Time:</label>
                <input name="event_end" type="text"/>
                <span class="error">* <?php echo $end_err;?></span>
                <br>
                <label>Location:</label>
                <input name="event_loc" type="text"/>
                <span class="error">* <?php echo $loc_err;?></span>
            </div>
            <br>
            <div class = "buttons">
                <input type="submit" value="Submit">
                <input type="submit" name="clear" value="Clear All Events">
            </div>
        </form>
    </body>
</html>
