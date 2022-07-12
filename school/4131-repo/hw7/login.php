<?php
/**
 * Created by PhpStorm.
 * User: rbunch
 * Date: 09.11.2014
 * Time: 22:18
 */
// Start the session!
session_start();
// Get that awesome database info from that moodle file!
include_once 'database.php';

// Define those errors!
$uname_err = $pass_err = $uname_sql_err = $sql_err = "";

// Validate fields first, don't wanna give SQL weird thangs
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (empty($_POST["uname"])) {
        $uname_err = "Please enter a valid value for Login Name field.";
        $problem = TRUE;
    }
    if (empty($_POST["pass"])) {
        $pass_err = "Please enter a valid value for Password field.";
        $problem = TRUE;
    }
}

// Do we have a problem?
if (!$problem) {
    if (!empty($_POST)) {
        // Fetch stuffs and encode the clients pass with sha1
        $uname = $_POST["uname"];
        $pass = sha1($_POST["pass"]);
        // Let's connect to our MySQL DB!
        $conn = new mysqli($db_servername, $db_username, $db_password, $db_name, $db_port);
        if ($conn->connect_error) {
            die("<html><body>ERROR: Could not connect to $db_servername : $conn->connect_error</html></body>");
        } else {
            // Make our query
            $query = "SELECT * FROM tbl_accounts T WHERE T.acc_login = '$uname';";
            if ($result = $conn->query($query)) {
                // Query was a success! Check if we got results. Else the username provided was not found
                if (! $result->num_rows == 0) {
                    // Check the password
                    $row = $result->fetch_row();
                    if ($row[3] == $pass) {
                        // Login successful, redirect to users.php and exit (also update session variable)
                        $_SESSION['client'] = $row;
                        /*
                         * Since we can't store the connection to our MySQL database
                         * in our $_SESSION var. We will run a query now to avoid making
                         * another connection in users.php.
                         */
                        $query = "SELECT * FROM tbl_accounts;";
                        if ($result = $conn->query($query)) {
                            if (! $result->num_rows == 0) {
                                $_SESSION['results'] = $result->fetch_all();
                                header('Location: users.php');
                                exit();
                            } else {
                                // Query had 0 results
                                header('Location: users.php');
                                exit();
                            }
                        } else {
                            // Ops, we weren't able to make the DB talk... must take stricter measures
                        }
                    } else {
                        // Password was unsuccessful :(
                        $sql_err = "Password is incorrect. Please check the password and try again";
                    }
                } else {
                    // Login was unsuccessful :'(
                    $uname_sql_err = "Login is incorrect. Please check the login and try again.";
                }
            } else {
                // Nope, query was bad
                die("<html><body>ERROR: Could not connect to $db_servername : $conn->connect_error</html></body>");
            }
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rusty's Login Page of Doom</title>
    <link rel="stylesheet" type="text/css"
          href="style.css">
</head>
<body>
<div class="displayWindow">
    <h2>
        Login Page for the World!
    </h2>

        <span id="errorWindow">
            <span class="error"> <?php echo $uname_err ?></span>
            <span class="error"> <?php echo $pass_err ?></span>
            <span class="error"> <?php echo $uname_sql_err ?></span>
            <span class="error"> <?php echo $sql_err ?></span>
        </span>

    <p>
        Please enter your user's login name and password.
        Both values are case sensitive!
    </p>

    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <label>Login: </label>
        <input id="login" type="text" name="uname">
        <br><br>
        <label>Password: </label>
        <input id="pass" type="password" name="pass">

        <p><input type="submit" value="Login"></p>
    </form>
</div>
</body>
</html>