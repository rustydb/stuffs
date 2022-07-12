<?php
// Start the session!
session_start();

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
        $_SESSION['uname'] = $_POST["uname"];
        $_SESSION['pass'] = sha1($_POST["pass"]);
        include_once 'models/account.php';
    }
}

// Swooping over to the fun view page
include_once 'views/login_view.php';
?>
