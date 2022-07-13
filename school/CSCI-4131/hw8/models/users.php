<?php
// Start that session
session_start();
/*
 * Since we can't store the connection to our MySQL database
 * in our $_SESSION var. We will run a query now to avoid making
 * another connection in users.php.
 */

// Set our errors and messages
$update_msg = $added_msg = $deleted_msg = $exists_msg = "";

// Let's connect to our MySQL DB!
include_once 'database.php';
$conn = new mysqli($db_servername, $db_username, $db_password, $db_name, $db_port);
if ($conn->connect_error) {
    die("<html><body>ERROR: Could not connect to $db_servername : $conn->connect_error</html></body>");
}

// Check if our session vars have new stuffs
if (isset($_POST['adduser'])) {
    // The id auto increments
    $name   = $_POST['name'];
    $login  = $_POST['login'];
    $pass   = sha1($_POST['pass']);
    $query  = "INSERT INTO tbl_accounts (acc_name, acc_login, acc_password) VALUES ('$name','$login','$pass')";
    if ($result = $conn->query($query)) {
        // Success
        $added_msg = "Account successfully added!";
    } else {
        // Failure
        $exists_msg = "User is already in the table";
    }
    unset($_POST['adduser']);
}

// Check if user is updating a row and if so... alter that row
if (isset($_POST['update'])) {
    var_dump($_POST);
    // Our VALUE placeholders
    $values = array();
    if (! $new_name == $_POST['new_name']) {
        $new_name = "acc_name='" . $_POST['new_name'] . "'";
        $values[] = $new_name;
    }
    if (! $new_login == $_POST['new_login']) {
        $new_login = "acc_login='" . $_POST['new_login'] . "'";
        $values[] = $new_login;
    }
    if (! $new_pass == $_POST['new_pass']) {
        $new_pass = "acc_password='" . sha1($_POST['new_pass']) . "'";
        $values[] = $new_pass;
    }
    $values = implode(', ', $values);
    $id = $_POST['update'];
    $query = "UPDATE tbl_accounts SET $values WHERE acc_id=$id";
    if ($result = $conn->query($query)) {
        // Success
        $update_msg = "Account $id was updated";
    } else {
        // Failure
        var_dump($query);
        $exists_msg = "Username chosen already exists";
    }
    unset($_POST['delete']);
}

// Check if user is deleting a row
if (isset($_POST['delete'])) {
    $id = $_POST['delete'];
    $query = "DELETE FROM tbl_accounts WHERE acc_id=$id";
    if ($result = $conn->query($query)) {
        // Success
        $deleted_msg = "Account $id was deleted";
    } else {
        // Failure
        $deleted_msg = "Could not delete $id from table";
    }
    unset($_POST['delete']);
}

// Fetches all the rows for our table
$query = "SELECT acc_id, acc_name, acc_login FROM tbl_accounts;";
if ($result = $conn->query($query)) {
    if (! $result->num_rows == 0) {
        $_SESSION['results'] = $result->fetch_all();
    } else {
        // Query had 0 results
    }
} else {
    // Ops, we weren't able to make the DB talk... must take stricter measures
    // Probably should throw some error here
}