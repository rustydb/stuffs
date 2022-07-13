/**
 * Created by rusty on 11/22/14.
 */
// Javascript for our slideing quiz

var toggle = document.getElementById('kirby');
var slider = document.querySelector('.slider');

toggle.addEventListener('click', toggleSlider, false);

function toggleSlider() {
    if (slider.classList.contains('opened')) {
        slider.classList.remove('opened');
        slider.classList.add('closed');
    } else {
        slider.classList.remove('closed');
        slider.classList.add('opened');
    }
}
