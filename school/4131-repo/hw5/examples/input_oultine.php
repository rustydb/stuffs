
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Calendar Input</title>
    <link rel="stylesheet" type="text/css" href="../style.css">
  </head>
  <body>
  <h1>Calendar Input</h1>
  <nav id="navmenu">
    <ul>
    <li><a href="../calendar.php">Calendar</a></li>
    <li><a href="../input.php">Input</a></li>
    </ul>
  </nav>
  
  <div style="color:red"><?php echo $error_message;?></div>
  
  <form method="post">
    <p>
    <label for="event_start">Event Name:</label>
    <input type="text" name="event_name">
    </p>
    <p>
    <label for="event_day">Event Day:</label>
    <select name="event_day">
      <option value="Mon">Mon</option>
      <option value="Tue">Tue</option>
      <option value="Wed">Wed</option>
      <option value="Thu">Thu</option>
      <option value="Fri">Fri</option>
    </select>
    </p>
    <p>
    <label for="event_start">Start Time:</label>
    <input type="time" name="event_start">
    </p>
    <p>
    <label for="event_end">End Time:</label>
    <input type="time" name="event_end">
    </p>
    <p>
    <label for="event_loc">Location:</label>
    <input type="text" name="event_loc">
    </p>
    <p>
    <button type="submit">Submit</button> &nbsp;
    <button type="submit" name="clear">Clear Calendar</button>
    </p>
  </form>
  </body>
</html>

