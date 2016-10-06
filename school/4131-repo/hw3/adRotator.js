/**
 * Created by rusty on 9/25/14.
 */
var index = 0;
var timeout;
var interval = 5000;
var re_arrow = /next/;
// Array for the photos
var slides = [
    "images/dragon.jpg",
    "images/transformers.jpg",
    "images/planes.jpg"
];
var refs = [
    'http://sua.umn.edu/events/calendar/event/14015/',
    'http://sua.umn.edu/events/calendar/event/14017/',
    'http://sua.umn.edu/events/calendar/event/14023/'
];
var titles = [
    "Sat, Sep 27 7:00pm",
    "Thu, Oct 2 7:00pm",
    "Thu, Oct 9 7:00pm"
];
var alts = [
    "dragon",
    "transformers",
    "planes"
];

var $ = function(id) {
    return document.getElementById(id);
}

// Selects corresponding duration for the index
function select(slideNum) {
    switch (slideNum) {
        case 0:
            interval = 5000;
            break;
        case 1:
            interval = 10000;
            break;
        case 2:
            interval = 3000;
            break;
    }
}

// Arrows
function arrowHoverOn() {
    if (re_arrow.test(this.src)) {
        this.setAttribute("src", "images/next_orange.png");
    } else {
        this.setAttribute("src", "images/prev_orange.png");
    }
}

function arrowHoverOff() {
    if (re_arrow.test(this.src)) {
        this.setAttribute("src", "images/next_blue.png");
    } else {
        this.setAttribute("src", "images/prev_blue.png");
    }
}

// Bullets
function bulletHoverOn() {
    if (index == this.id) {
        return;
    }
    this.setAttribute("src", "images/bullet_orange.png");
}

function bulletHoverOff() {
    if (index == this.id) {
        return;
    }
    this.setAttribute("src", "images/bullet_gray.png");
}

// Manual selection of ads
function manual() {
    // Checks if dot is active and return if true
    if (index == this.id) {
        return;
    }
    // Deactivate previous button
    clearTimeout(timeout);
    $(index).src = "images/bullet_gray.png";
    index = this.id;
    // Set new picture, ref, and make active
    $("adBanner").src    = slides[index];
    $("adBanner").title  = titles[index];
    $("adBanner").alt    = alts[index];
    $("adRef").href      = refs[index];
    this.setAttribute("src", "images/bullet_blue.png");
    select(index);
    timeout = setTimeout(auto, interval);
}

// Allows user to iterate through the auto() function
function iter() {
    // Deactivate active button
    clearTimeout(timeout);
    $(index).src = "images/bullet_gray.png";
    if(re_arrow.test(this.src)) {
        index++;
        if (index >= slides.length) {
            index = 0;
        }
        select(index);
        $("adBanner").src    = slides[index];
        $("adBanner").title  = titles[index];
        $("adBanner").alt    = alts[index];
        $("adRef").href      = refs[index];
        $(index).src = "images/bullet_blue.png";
    } else {
        index--;
        if (index < 0) {
            index = 2;
        }
        select(index);
        $("adBanner").src    = slides[index];
        $("adBanner").title  = titles[index];
        $("adBanner").alt    = alts[index];
        $("adRef").href      = refs[index];
        $(index).src = "images/bullet_blue.png";
    }
    timeout = setTimeout(auto, interval);
}

// Rotates banner
function auto() {
    $(index).src        = "images/bullet_gray.png";
    index++;
    if (index >= slides.length) {
        index = 0;
    }
    $("adBanner").src    = slides[index];
    $("adBanner").title  = titles[index];
    $("adBanner").alt    = alts[index];
    $("adRef").href      = refs[index];
    select(index);
    $(index).src        = "images/bullet_blue.png";
    timeout = setTimeout(auto, interval);
}



window.onload =function() {
    timeout = setTimeout(auto, interval);
} // Start after page load
