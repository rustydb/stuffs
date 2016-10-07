/**
 * Created by rusty on 11/23/14.
 */

var $ = function(id) {
    return document.getElementById(id);
};

/* Question legend
 a1 = troll
 a2 = moderator
 a3 = lurker
 a4 = feed fiend
 a5 = activist
 */

var question1 = [
    "img/social-networks-V2.jpg",
    "What is your opinion of social media?",
    "They are good for a laugh!",
    "I don't post on social media often but I enjoy keeping my online community on task",
    "Good for the waiting room or passing time but I tend to be pretty quite online",
    "Such a good outlet for all of my curiosities",
    "Great for getting support for social causes and organizations!"
];

var question2 = [
    "img/socialmediatime.jpeg",
    "Approximately how much time do you spend posting on social media a day?",
    "Just until I get bored of online people",
    "I end up on it later at night and read for a couple hours",
    "A few minutes here and there but never any long blocks of time",
    "I usually only spend time on it to upload my photos or my blog so maybe a few hours",
    "I usually always have it up but only to watch over my posts"
];

var question3 = [
    "img/internet.jpg",
    "What's the most valuable trait of the Internet to you?",
    "I post just to get a reaction out of people",
    "That every site has its own oddities and people have to follow them",
    "I like the ability to be anonymous",
    "My voice can be heard on any subject on the internet",
    "My posts can change people’s minds to my point of view"
];

var question4 = [
    "img/posts.jpg",
    "What are the majority of your posts on the internet about?",
    "What ever I feel like",
    "I post when I see someone doing something they shouldn't",
    "I never have posted, or have only posted a few things on the internet but usually I read",
    "I don’t know I post about everything that it would be too hard to figure out",
    "I love posting about organizations or asking people to support social causes"
];

var question5 = [
    "img/annoyed.gif",
    "What type of person do you dislike the most on the internet? ",
    "People that think their opinion matters more than mine",
    "I dislike people that clearly don't know how to behave online",
    "Even though I don't post much I hate if no one on the site actually does post",
    "I dislike people that read my posts but never like, comment, or favorite them",
    "People that spew mindless babble all over the Internet"
];

var questions = [
    question1,
    question2,
    question3,
    question4,
    question5
];

var endImages = [
    "img/troll.jpg",
    "img/mod.jpg",
    "img/lurker.gif",
    "img/feedfiend.png",
    "img/activist.jpg"
];

var points = 0;

function firstQuestion() {
    // Set our end image to hidden first
    $('endImage').style.display="none";
    // Get the first question from our question array
    var firstQuestion = questions.shift();
    // Get our answer radio buttons and our image holder for the quiz
    var answers = [
        $('a1'),
        $('a2'),
        $('a3'),
        $('a4'),
        $('a5')
    ];
    var labels = [
        $('l1'),
        $('l2'),
        $('l3'),
        $('l4'),
        $('l5')
    ];
    // Get and change the image to the first element
    var quizImage = $('quizImage');
    quizImage.src = firstQuestion.shift();
    var prompt = $('q');
    prompt.innerHTML = firstQuestion.shift();
    // Now that we have our image out, lets shuffle the rest of the array
    //firstQuestion.sort(function () { return 0.5 - Math.random() });
    for (var i = 0; i < firstQuestion.length; i++) {
        // Populate the rest of the answers
        labels[i].innerHTML = firstQuestion[i];
    }
}

function checkQuestion() {
    var answers = [
        $('a1'),
        $('a2'),
        $('a3'),
        $('a4'),
        $('a5')
    ];
    for (var i = 0; i <= answers.length; i++) {
        if (answers[i].checked) {
            // Add the points
            points += parseInt(answers[i].value);
            // Uncheck
            answers[i].checked = false;
            break;
        }
    }
    nextQuestion();
}

function nextQuestion() {
    var answers = [
        $('a1'),
        $('a2'),
        $('a3'),
        $('a4'),
        $('a5')
    ];
    var labels = [
        $('l1'),
        $('l2'),
        $('l3'),
        $('l4'),
        $('l5')
    ];
    //var answer;
    var question = questions.shift();
    if(typeof question == 'undefined') {
        // we are done with the quiz
        $('quizForm').style.display="none";
        grader();
    } else {
        // Change the image to the first element
        var quizImage = $('quizImage');
        quizImage.src = question.shift();
        var prompt = $('q');
        prompt.innerHTML = question.shift();
        // Now that we have our image out, lets shuffle the rest of the array
        //question.sort(function () { return 0.5 - Math.random() });
        for (var i = 0; i < answers.length; i++) {
            labels[i].innerHTML = question[i];
        }
    }
}

function grader() {
    var finalle = $('end');
    var endImage   = $('endImage');
    // Set display back to on
    $('endImage').style.display="";
    if (points < 6) {
        // troll
        finalle.innerHTML = "<h1>Troll</h1>";
        endImage.src = endImages[0];
    } else if (points < 11) {
        // mod
        finalle.innerHTML = "<h1>Moderator</h1>";
        endImage.src = endImages[1];
    } else if (points < 17) {
        // lurker
        finalle.innerHTML = "<h1>Lurker</h1>";
        endImage.src = endImages[2];
    } else if (points < 22) {
        // feed fiend
        finalle.innerHTML = "<h1>Feed Fiend</h1>";
        endImage.src = endImages[3];
    } else {
        // activist
        finalle.innerHTML = "<h1>Activist</h1>";
        endImage.src = endImages[4];
    }
}

window.onload = function() {firstQuestion();};


