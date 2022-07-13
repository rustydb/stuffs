<?php
/**
 * Created by PhpStorm.
 * User: rbunch
 * Date: 09.11.2014
 * Time: 22:19
 */
// Get that session again!
session_start();

// Empty our session vars
session_unset();

// Redirect to the login page
header("Location: login.php");