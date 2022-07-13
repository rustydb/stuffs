<!--Start the PHP session-->
<?php session_start(); ?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css"
          href="style.css">
    <title>Russell's Page</title>
    <!--Google Maps-->
    <script type="text/javascript"
    src="https://maps.googleapis.com/maps/api/js?libraries=places&amp;&amp;key=AIzaSyCn0rSmQ6etYZx_amGyeiSEYi1zzo4DTMU">
    </script>
    <script type="text/javascript" src="ggl_maps.js"></script>
</head>
<body>
<h1 class="title">Russell's Calendar</h1>
<!--Nav Bar-->
<div>
    <nav>
        <a href="calendar.php">Calendar</a>
        <a href="input.php"> Input</a>
    </nav>
</div>
<!--Calendar-->
<div id="emptycal"><br><a class="error"><?php if (!isset($_SESSION['locations'])) {
            echo "The calendar is currently empty";
            $empty = TRUE;
        } ?></a></div>
<div id="cal">
    <table>
        <caption style="color: black"><strong>September Weekly Schedule</strong></caption>
        <?php
        // If our $_SESSION variable has stuff, start reading it
        if (!$empty) {
            // Read $_SESSION['location'] array into calendar
            $dow = $_SESSION['locations'];
            foreach ($dow as $day => $events) {
                if (is_array($events)) {
                    ?>
                    <tr>
                        <td style="color: yellow;)">
                            <?php echo $day; ?>
                        </td>
                        <?php
                        foreach ($events as $event => $details) {
                            if (is_array($details)) {
                                ?>
                        <td>
                            <p>
                                <i><?php echo  "<span class='time'>" . $details['event_start'] . "-" . $details['event_end'] . "</span>";  ?></i>
                            </p>
                            <?php echo $details['event_name'] . " - <span class='location'>" . $details['event_loc'] . "</span>"; ?>
                        </td>
                            <?php
                            }
                        }
                        ?>
                    </tr>
                <?php
                }
            }
        }
        ?>
    </table>
</div>
<!--Google Maps Stuff-->
<form id="ggl_maps_frm" onsubmit="event.preventDefault(); return marker_manager('')">
    <input id="searchField" type="text"/>
    <button onclick=marker_manager()>Search & Mark on Map</button>
</form>
<div id="ggl_maps"></div>
<!--Gif and Footer-->
<div class="disclaimer">
    <span> --Tested in Firefox and Chrome-- </span> <br>
</div>
</body>
</html>
