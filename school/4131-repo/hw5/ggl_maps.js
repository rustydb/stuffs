/*
 * Created by rusty on 10/9/14.
 * Updated with in-class code on 10/16/14
 */
var map         = null;
var service     = null;
var locations   = [];
var times       = [];
var UMN         = new google.maps.LatLng(44.974, -93.234);
var mapOptions  = {
    center: UMN,
    zoom: 15
};

var $ = function(cl) {
    return document.getElementsByClassName(cl);
};

var $id = function(id) {
    return document.getElementById(id);
};

function locParser() {
    initializeMap();
    locations = $('location');
    times = $('time');
    for (var i = 0; i < locations.length; i++) {
        marker_manager(locations[i].innerHTML, times[i]);
    }
}

function initializeMap() {
    map = new google.maps.Map(document.getElementById('ggl_maps'), mapOptions);
    service = new google.maps.places.PlacesService(map)
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
    google.maps.event.addListener(marker, 'click', function() {
        infoWindow.open(map,marker);
    });
}


// Start things
google.maps.event.addDomListener(window, 'load', locParser); // locParser will call initializeMap
