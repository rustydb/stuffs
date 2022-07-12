<?php
// Get that swanky session
session_start();
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
