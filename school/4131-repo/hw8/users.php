<?php
// Grab our existing session
session_start();

// Check if this person is really logged in or not
if (!(isset($_SESSION['client']))) {
    header("Location: login.php");
}
?>
<!--Populate our table with users in the database-->
<?php
// Get all the results for our table

// Check if we are posting
include_once 'models/users.php';
include_once 'views/users_view.php';
?>

