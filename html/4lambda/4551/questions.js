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
    var finalle  = $('end');
    var endImage = $('endImage');
    var def      = $('def');
    var synop    = $('synop');
    // Set display back to on
    endImage.style.display="";
    if (points < 6) {
        // troll
        finalle.innerHTML    = "<h1>You seem to be...  a Troll</h1>";
        endImage.src         = endImages[0];
        def.innerHTML      = "Troll: one who posts a deliberately provocative message to a new group or message board " +
        "with the intention of causing maximum disruption and argument.";
        synop.innerHTML        = ">This isn't necessarily bad but you may not be making many friends on the Internet - or maybe " +
        "you are? Albeit trolls have been given a bad reputation they do hold a value on the Internet. A value that" +
        "is a catalyst for controversy and development. This  may negatively affect some but it can help build character " +
        "in some (tough love, right?)."
    } else if (points < 11) {
        // mod
        finalle.innerHTML   = "<h1>It feels like you are a Moderator</h1>";
        endImage.src        = endImages[1];
        def.innerHTML     = "Moderator: One who has the job of maintaining order, harmony, and attempts to build consensus " +
        "(this job may also be unofficial).";
        synop.innerHTML       = "Maybe you're an offical moderator somewhere, maybe you just really hate when someone uses " +
        "poor [insert_language_of_choice] online, or maybe you feel justice in the real world should also be dealt with " +
        "accordingly online. Which ever it may be, thank you. You're probably one of the few reasons why people find " +
        "safe-havens in certain blogs, subreddits, or similar niches on the Internet.";
    } else if (points < 17) {
        // lurker
        finalle.innerHTML   = "<h1>You are probably a Lurker</h1>";
        endImage.src        = endImages[2];
        def.innerHTML     = "Lurker: Lurker is someone who doesn't usually contribute content to the community but actively" +
        "observes others.";
        synop.innerHTML       = "Now this isn't a bad thing. By the 1% rule (which Wikipedia refers to " +
        "as the rule of thumb pertaining to participation in an Internet community) states that 1% of " +
        "the users create the content, 9% contribute, and the remaining 90% lurk. However lurkers " +
        "are usually more careful users of the Internet.";
    } else if (points < 22) {
        // feed fiend
        finalle.innerHTML   = "<h1>You are sound like a Feed Fiend</h1>";
        endImage.src        = endImages[3];
        def.innerHTML     = "Feed Fiend: One that frequently posts and reviews all the other posting of the other users.";
        synop.innerHTML       = "Otherwise known as, contributors & creators. You sound like you may post a lot or be very active on" +
        "specific sites. You are what drives the community forward, or backwards, by your content. In " +
        "fact if you are big enough in one you sites we would say that you are the sites main content."
    } else {
        // activist
        finalle.innerHTML   = "<h1>You are an Activist</h1>";
        endImage.src        = endImages[4];
        def.innerHTML     = "Activist: One that wants to convince people on the Internet of their point of view. They tend to " +
        "respond to a political agenda, stick to posting about a particular organization or company, " +
        "or perhaps they are only active in one specific community.";
        synop.innerHTML       = "You probably have or probably will make your own Internet community to rally others " +
        "one of those things and you are a very strong member in that community.";
    }
}

window.onload = function() {firstQuestion();};


