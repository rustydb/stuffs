<?php
// Start that session!
session_start();
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
<!--User Welcome & Logout-->
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
<!--User Listing and Modification-->
<div class="displayWindow">
    <h1>
        List of Users
    </h1>
    <span id="errorWindow">
        <span class="error"> <?php echo $update_msg; ?> </span>
        <span class="error"> <?php echo $added_msg; ?> </span>
        <span class="error"> <?php echo $deleted_msg; ?> </span>
        <span class="error"> <?php echo $exists_msg; ?> </span>
    </span>
    <table>
        <!--Create first row with headers-->
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Login</th>
            <th>New Password</th>
            <th>Action</th>
        </tr>
        <?php
        $results = $_SESSION['results'];
        foreach ($results as $tuple) {
            if ($_POST['edit'] && ($_POST['edit'] == $tuple[0])) {
                ?>
                <tr>
                    <td>
                        <?php echo $tuple[0]; ?>
                    </td>
                    <form style="display: hidden" method="post"
                          action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                        <td>
                            <!--Name-->
                            <input id="name" type="text" name="new_name">
                        </td>
                        <td>
                            <!--Login-->
                            <input id="login" type="text" name="new_login">
                        </td>
                        <td>
                            <!--New Password-->
                            <input id="pass" type="password" name="new_pass">
                        </td>
                        <td>
                            <!--Buttons-->
                            <button name="update" value="<?php echo $tuple[0] ?>" type="submit">Update</button>
                            <button name="cancel" value="<?php echo $tuple[0] ?>" type="submit">Cancel</button>

                        </td>
                    </form>
                </tr>
                <?php
            } else {
                ?>
                <tr>
                    <td>
                        <?php echo $tuple[0]; ?>
                    </td>
                    <form style="display: hidden" method="post"
                          action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                        <td>
                            <!--Name-->
                            <?php echo $tuple[1]; ?>
                        </td>
                        <td>
                            <!--Login-->
                            <?php echo $tuple[2]; ?>
                        </td>
                        <td>
                            <!--New Password-->
                        </td>
                        <td>
                            <!--Buttons-->
                            <button name="edit" value="<?php echo $tuple[0] ?>" type="submit">Edit</button>
                            <button name="delete" value="<?php echo $tuple[0] ?>" type="submit">Delete</button>

                        </td>
                    </form>
                </tr>
            <?php
            }
        }
        ?>
    </table>
</div>
<!--Add User-->
<div class="displayWindow">
    <h1>
        Add New User
    </h1>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <label>Name: </label>
        <input id="name" type="text" name="name">
        <br><br>
        <label>Login: </label>
        <input id="login" type="text" name="login">
        <br><br>
        <label>Password: </label>
        <input id="pass" type="password" name="pass">

        <p><input type="submit" name="adduser" value="Add User"></p>
    </form>
</div>
</body>
</html>
