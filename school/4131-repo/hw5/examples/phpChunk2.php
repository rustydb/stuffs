  </head>
  <body>
  <h1>My Calendar</h1>
  <nav id="navmenu">
    <ul>
    <li><a href="../calendar.php">Calendar</a></li>
    <li><a href="../input.php">Input</a></li>
    </ul>
  </nav>
  <div id="calendar">
  <?php
  
    if ($locations_count>0) {
      echo '<table>';
      
      /* go through every day we have */
      foreach ($_SESSION['locations'] as $key=>$value) {
        if (is_array($value)) {
      ?>
        <tr>
          <td><?php echo $key;?></td>
      <?php
            /* go through every event of every day */
            foreach ($value as $key2=>$value2) {
            ?>
            <td>
              <p><i><?php echo $value2['event_start'], ' - ', $value2['event_end'];?></i><p>
              <?php echo $value2['event_name'];?> - <span class="loc"><?php echo $value2['event_loc'];?></span>
            </td>
            <?php
            }
          }
          echo '</tr>';
        }
      echo '</table>';
    } else {
      echo '<div style="color:red">Calendar has no events. Please use the input page to enter some events.</div>';
    }
    ?>
  </div>
  <form id="loc_form" onSubmit="event.preventDefault(); return mark('')">
    <input type="text" id="location_box">
    <button id="load_marks" onclick=mark()>Search</button>
  </form>
  <div id="map-canvas"></div>
  <i>This page has been tested in Firefox.</i>
  </body>
</html>
