<?php
/**
 * Created by PhpStorm.
 * User: rbunch
 * Date: 09.11.2014
 * Time: 22:19
 */
// Grab our existing session
session_start();

// Check if this person is really logged in or not
if ((!(isset($_SESSION['client']))) || (!(isset($_SESSION['results'])))) {
    header("Location: login.php");
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rusty's User list</title>
    <link rel="stylesheet" type="text/css"
          href="style.css">
</head>
<body>
<div class="displayWindow">
    <h2>
        Welcome, <?php echo $_SESSION['client'][1]; ?>
    </h2>
    <a id="logout" href="logout.php">
        Logout
    </a>

    <p>
        This page is protected from the public, and you can see a list of all useres
        defined in the database.
    </p>
</div>
<div class="displayWindow">
    <h1>
        List of Users
    </h1>
    <table>
        <!--Create first row with headers-->
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Login</th>
        </tr>
        <!--Populate our table with users in the database-->
        <?php
        // Get our connection from login.php
        $results = $_SESSION['results'];
        foreach ($results as $tuple) {
            ?>
            <tr>
                <td>
                    <?php echo $tuple[0]; ?>
                </td>
                <td>
                    <?php echo $tuple[1]; ?>
                </td>
                <td>
                    <?php echo $tuple[2]; ?>
                </td>
            </tr>
        <?php
        }
        ?>
    </table>
</div>
</body>
</html>
