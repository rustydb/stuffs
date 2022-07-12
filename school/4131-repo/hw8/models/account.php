<?php
// Start that session!
session_start();
// Let's connect to our MySQL DB!
include_once 'database.php';
$conn = new mysqli($db_servername, $db_username, $db_password, $db_name, $db_port);
if ($conn->connect_error) {
    die("<html><body>ERROR: Could not connect to $db_servername : $conn->connect_error</html></body>");
} else {
    // Make our query
    $uname = $_SESSION['uname'];
    $query = "SELECT * FROM tbl_accounts T WHERE T.acc_login = '$uname';";
    if ($result = $conn->query($query)) {
        // Query was a success! Check if we got results. Else the username provided was not found
        if (! $result->num_rows == 0) {
            // Check the password
            $row = $result->fetch_row();
            $pass = $_SESSION['pass'];
            if ($row[3] == $pass) {
                // Login successful, redirect to users.php and exit (also update session variable)
                $_SESSION['client'] = $row;
                header('Location: users.php');
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