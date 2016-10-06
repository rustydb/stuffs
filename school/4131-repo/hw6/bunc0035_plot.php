<!--Start the PHP session-->
<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL | E_STRICT);

// Read pointsA.json, pointsB.json, & center.json
$pointsA    = json_decode(utf8_encode(file_get_contents('pointsA.json')), true);
$pointsB    = json_decode(utf8_encode(file_get_contents('pointsB.json')), true);

// Init our $minDistSoFar to the highest INT so it fails the first try
$minDistSoFar = PHP_INT_MAX;
// Init our $checkedPoints to keep checked $B
$checkedPoints = array();
$matchedPoints = array();
/*
 * For each location in A, find the closest non-already-selected point in B.
 * NOTE: Could not do a nested statement, needs PHP 5.5 (which CSE should have, php -v reports 5.5.3 :\
 * Meaning this didn't load in the browser, but it did load with invoking php at shell:
 * while (!empty($A = array_shift($pointsA['locations']))) {
 */
while (!empty($pointsA['locations'])) {
    $A = array_shift($pointsA['locations']);
    // Get lat and long from A
    $ALat = $A['lat'];
    $ALon = $A['long'];
    while (!empty($pointsB['locations'])) {
        $B = array_shift($pointsB['locations']);
        // Get lat and long from B
        $BLat = $B['lat'];
        $BLon = $B['long'];
        // Calculate the distance between and check if less than our last minimum
        $dist = sqrt(pow($ALat - $BLat, 2) + pow($ALat - $BLat, 2));
//        echo "Distance: $dist for $BLat \n";
        if ($dist < $minDistSoFar) {
            // Put old min back in Front of array (so we don't scan it again during this pass) if we have had a minB
            if(isset($minB)) {
                array_push($checkedPoints, $minB);
            }
            // Shift new minimum off
            $minB = $B;
            $minDistSoFar = $dist;
        } else {
            // $dist was not less than the current minimum, add it to our $checkedPoints
            array_push($checkedPoints, $B);
        }
    }
    /*
     * For loop is finished, return our $checkedPoints to $pointsB for the next run through A.
     * Store A & B as a key value
     */
//    echo "minDistSoFar: $minDistSoFar \n";
    while (!empty($checkedPoints)) {
        $B = array_pop($checkedPoints);
        array_unshift($pointsB['locations'], $B);
    }
    // Array is match with (0, 1), (2, 3), etc etc
//    $pair = array_merge($A, $minB);
    array_push($matchedPoints, $A, $minB);
}
//$matchedPoints = json_encode($matchedPoints);
//var_dump($matchedPoints);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css"
          href="style.css">
    <title>Russell's Page</title>
    <!-- Google Maps -->
    <!-- Pass the center data to JavaScript -->
    <script type="text/javascript">
        var mapCenter       = <?php echo utf8_encode(file_get_contents('center.json')); ?>;
        var matchedPoints   = <?php echo json_encode($matchedPoints); ?>;
    </script>
    <script type="text/javascript"
    src="https://maps.googleapis.com/maps/api/js?libraries=places&amp;&amp;key=AIzaSyCn0rSmQ6etYZx_amGyeiSEYi1zzo4DTMU">
    </script>
    <script type="text/javascript" src="ggl_maps.js"></script>
</head>
<body>

<!-- More Google Maps Stuff-->
<form id="ggl_maps_frm" onsubmit="event.preventDefault(); return marker_manager('')">
    <input id="searchField" type="text"/>
    <button onclick=marker_manager()>Search & Mark on Map</button>
</form>
<div id="ggl_maps"></div>

<!-- Begin reading points into map from earlier PHP session and draw lines-->
<script type="text/javascript">
//    for ($i = 0; $i < matchedPoints.length; $i++) {
//        createMarkerJSON(matchedPoints[0]);
//alert(matchedPoints[0]['long'])
//    }
</script>

<!-- Footer -->
<div class="disclaimer">
    <span> --Tested in Firefox and Chrome-- </span> <br>
</div>
</body>
</html>
