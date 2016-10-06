// Javascript for our slideing quiz

var toggle = document.getElementById('kirby');
var slider = document.querySelector('.slider');
var kirbys = [
    "<(^.^)>*",
    "<(^.o<)",
    "<(o.o<)",
    "<(-.-<)",
    "(>-.-)>",
    "(>o.o)>",
    "(>o.0)>",
    "(>0.0)>",
    "^(*.*)>",
    "^(*.*)^",
    "<(*.*)^"
];
var i = 0;
var timer;


toggle.addEventListener('click', toggleSlider, false);

function toggleSlider() {
    if (timer) {
        clearInterval(timer);
        toggle.innerHTML = "<(-.-)>zZZzzZZ";
    }
    if (slider.classList.contains('opened')) {
        slider.classList.remove('opened');
        slider.classList.add('closed');
        toggle.innerHTML = "^(0.0)^!!!";
        timer = setInterval('runKirby();', 666);
    } else {
        slider.classList.remove('closed');
        slider.classList.add('opened');
    }
}

function runKirby() {
    if (i >= kirbys.length) {
        i = 0;
    }
    toggle.innerHTML = kirbys[i];
    i++;
}