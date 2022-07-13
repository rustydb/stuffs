/**
 * Created by rusty on 10/9/14.
 */
var map;
var locations = [];
var times = [];
var infowindow;
var geocoder;
var address;

var $ = function(cl) {
    return document.getElementsByClassName(cl);
}

function loc_parser() {
    initialize_map();
    locations = $('location');
    times = $('time');
    for (var i = 0; i < locations.length; i++) {
        gecode_add(locations[i], times[i]);
    }
}

function gecode_add(loc, time) {
    if (loc.textContent == null) {
        address = loc;
    } else {
        address = loc.textContent;
    }
    geocoder.geocode( { 'address': address }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            createMarker(results[0].geometry.location, time);
        } else if (status === google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
            setTimeout(function () {gecode_add(loc, time);}, 250);
        } else {
                alert('Geocode was not successful for ' + address + ' the following reason: ' + status);
        }
    });
}

function initialize_map() {
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(44.974, -93.234);
    var mapOptions = {
        center: latlng,
        zoom: 15
    };
    map = new google.maps.Map(document.getElementById('ggl_maps'), mapOptions);
    infowindow = new google.maps.InfoWindow();
}

function createMarker(place, time) {
//    var placeLoc = place.geometry.location;
    var marker = new google.maps.Marker({
        map: map,
        position: place
    });
    if (time.textContent != null) {
        google.maps.event.addListener(marker, 'click', function () {
            infowindow.setContent(time.textContent);
            infowindow.open(map, this);
        });
    } else {
        google.maps.event.addListener(marker, 'click', function () {
            infowindow.setContent(time);
            infowindow.open(map, this);
        });
    }
}

function searchAndAdd() {
    var field = document.getElementById("searchfield");
    gecode_add(field.value, field.value);
    field.value = ""; // Clear form field
}

function killForm() {
    return false;
}

// Start things
google.maps.event.addDomListener(window, 'load', loc_parser); // loc_parser will call initialize_map
