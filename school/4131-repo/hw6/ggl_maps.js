/*
 * Created by rusty on 10/9/14.
 * Updated with in-class code on 10/16/14
 */
var map         = null;
var service     = null;
var locations   = [];
var times       = [];
var center      = new google.maps.LatLng(mapCenter['center']['lat'],mapCenter['center']['long']);
var zoom        = parseInt(mapCenter['zoom']);
var mapOptions  = {
    center: center,
    zoom: zoom
};
// Colors for polyline
var polyColors = [
    '#FF0000',
    '#0000FF',
    '#008000',
    '#FF00FF'
];

var $ = function(cl) {
    return document.getElementsByClassName(cl);
};

var $id = function(id) {
    return document.getElementById(id);
};

function initializeMap() {
    map = new google.maps.Map(document.getElementById('ggl_maps'), mapOptions);
    service = new google.maps.places.PlacesService(map);
    // Make markers from JSON (map was not transferring correctly as a global :\
    //alert(matchedPoints.length);
    for (var $i = 0; $i <= (matchedPoints.length - 1); $i += 2) {
        createMarkerJSON(matchedPoints[$i]);
        createMarkerJSON(matchedPoints[$i + 1]);
        var polylineCoordinates = [
            new google.maps.LatLng(matchedPoints[$i].lat, matchedPoints[$i].long),
            new google.maps.LatLng(matchedPoints[$i + 1].lat, matchedPoints[$i + 1].long),
        ];
        var polylinePath = new google.maps.Polyline({
            path: polylineCoordinates,
            geodesic: true,
            strokeColor: polyColors.pop(),
            strokeOpacity: 1.0,
            strokeWeight: 2
        });
        polylinePath.setMap(map);
    }
}

function marker_manager(loc, txt) {
    if (loc.length == 0) {
        loc = $id("searchField").value;
        txt = loc;
    }
    if (loc.length > 0) {
        var request = {
            location: mapOptions.center,
            radius: '500',
            query: loc
        };
        service.textSearch(request, getCallback(txt));
        $id("searchField").value = '';
    }
    return false;
}

function getCallback(txt) {
    function callback(results, status) {
        if (status == google.maps.places.PlacesServiceStatus.OK) {
            var place = results[0];
            createMarker(results[0], txt);
        }
    }
    return callback;
}

function createMarker(place, txt) {
    var marker = new google.maps.Marker({
        map: map,
        position: place.geometry.location,
        title: place.name
    });
    if (txt.textContent != null) {
        var infoWindow = new google.maps.InfoWindow({
            content: txt.textContent
        });
    } else {
        var infoWindow = new google.maps.InfoWindow({
            content: txt
        });
    }
    google.maps.event.addListener(marker, 'click', function () {
        infoWindow.open(map, marker);
    });
}

function createMarkerJSON(place) {
    var latLng = new google.maps.LatLng(place.lat,place.long);
    var marker = new google.maps.Marker({
        position: latLng,
        map: map,
        title: place.name
    });
    var infoWindow = new google.maps.InfoWindow({
        content: place.name
    });
    google.maps.event.addListener(marker, 'click', function () {
        infoWindow.open(map, marker);
    });
}

// Start things
    google.maps.event.addDomListener(window, 'load', initializeMap); // locParser will call initializeMap

