<?php
/**
 * Created by Rusty and Cavan
 *
 * Selection and Intro page:
 *
 * User reads the intro to our project and selects a class which directs them to class.php
 */
// Start that session!
session_start();
// Load our answer bank
include("questions.php");
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="style.css">
    <script type="text/javascript" src="questions.js"></script>
    <!--For Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Jura:500,400' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Nunito' rel='stylesheet' type='text/css'>
    <title>4551 Project - Identity Crisis</title>
</head>
<body>
<article class="intro">
    <header>
        <table>
            <tr>
                <td>
                    <p id="title">
                        Series of Tubes |
                    </p>
                </td>
                <td style="padding-left: 1em">
                    <p>
                <span style="font-size: x-small; position: relative; bottom: 4px">
                    Created by: Cavan Hussein & Russell Bunch
                    <br>
                    for JOUR 4551 Fall 2014
                    <span class="blinkme" style="position: relative; bottom: 2px">
                        █
                    </span>

                </span>
                    </p>
                </td>
            </tr>
        </table>
    </header>
    <!--Expand box-->
    <!--        <input type="checkbox" id="read_more" role="button">-->
    <!--        <label for="read_more" onclick="">-->
    <!--            <span>Continue..</span>-->
    <!--            <span>Eh.. go away</span>-->
    </label>
    <figure>
        <img style="float: left; padding-right: 1em; padding-top: 2em"
             src="http://media.ign.com/games/image/article/725/725407/tubernet_1155530890.jpg" alt="Series of tubes">
    </figure>
    <section>
        <p style="text-align: left;">
            Good day, "<?php echo $_SERVER['REMOTE_ADDR'] ?>"
        </p>

        <p style="text-align: left; text-indent: 2em">
            The Internet is a broad world like our own and a majority of us aim to create our own, unique identity
            that we possibly could not create or experiment within our existing environment. The immense freedom that
            is privileged to those who have access to the internet allows them to explore information in larger
            quantities and in shorter durations, like bursts, than we used to be limited to. That fact presents an
            opportunity to observe humanities social development since it is safe to say that humans are developing advanced
            social skills at younger and younger ages. However the vast wealth of information that we refer to as the
            Internet isn't necessarily sitting at everyone's door step, one needs to know how formulate their question
            so they can harness the true power of the Internet.
        </p>
        <br>
        <p style="text-align: left; text-indent: 2em">
            The Internet is like a series of tubes (actually). These <i>tubes</i> are how we get to our destination, our answer
            to our question. They represent the real wealth of information and like our Pneumatic Tube Operator pictured
            above, we formulate our request sending it off with hopes that it will bring us back the information we seek.
            Not only is this an infamous quote from Senator Ted Stevens' speech against Net Neutrality but it provides an
            excellent analogy for what the Internet is (if you are unsure of what we are referring to, allow us to bring you
            up to speed with our fancy audio player).

            <audio controls="controls" style="float: right; padding: 1em;">
                <source src="seriesoftubes.ogg" type="audio/ogg">
                <source src="seriesoftubes.mp3" type="audio/mp3">
                Your Browser does not support this audio element, sorry man.
            </audio>

            Formulating your query involves utilizing different tools on such as

            <span style="font-family: 'Open Sans', sans-serif;">
                Google™
            </span>

            and

            <span style="font-family:'lucida grande',tahoma,verdana,arial,sans-serif;">
                Facebook&reg;
            </span>

            which are two prime examples of a commonly used search engines and databases but there exist many many more.
            What is so peculiar though is that these tools and resources sculpt its users into what we are today.
            Just like the automotive industry (or any large industry for that matter), our world has assimilated this
            technology at an astonishing rate. It is almost impossible to find someone in a developed country that does
            not know what the Internet is or what it can do. However, knowing 'what it can do' is the
            key. It is one thing to know how to look up information to satisfy one's curiosity but it is another to
            know how those tubes work and how you can learn from them to develop destinations of your own. It allows
            anyone to make something of there own that doesn't have to be limited to their environment or peers - it
            allows us to establish another identity stemming purely from our own will and imagination.
        </p>
        <h3>The Internet in a nutshell</h3>
        <p style="text-align: left; text-indent: 2em">
            For an overview of how the internet works, let's take a look at this website. How you got here is very much
            like how our Pneumatic Girl sent and received information and materials. You were given a URL and after you
            hit <kbd>Return</kbd> your browser needed to figure out how to get to that URL, it needed the IP (Internet
            Protocol) address. For those who are unfamiliar with IP addresses, an IP is exactly the same as a street
            address but for the Internet. Without the IP you just have a name. Not every computer has an address book of
            every website so it needs to ask another computer that is already known if it can help find the IP for that
            URL. Our capsule goes down our tube and once it gets to our assigned address book server (a.k.a. a DNS -
            Domain Name Server) that server will send the IP tied to that URL back to us. Your browser receives this and
            makes another request to that IP. From there you are sent to my home PC. My PC hears your request and fires
            back another capsule with the site, images, audio clips, and styling to your IP address. Upon receiving this
            your browser displays everything as we intended it (hopefully). Your IP address is displayed in the above
            greeting, it is what was reported to us when you requested our site - a product of Cavan's & my online identity.
        </p>
        <h3>Our Online Identity</h3>
        <p style="text-align: left; text-indent: 2em">
            Albeit a little more involved than making a profile on say, Facebook, creating a web page is how Internet
            dwellers first established themselves on the Internet. It wasn't until later when Internet users took those
            sites a step further and created forums, chat rooms, and social media sites. The Internet exploded and now
            allowed its users to make several identities. If you couldn't muster the resources to host your own web page,
            well why not have someone else do it for you? After all it was a lot easier in the early 2000s for new
            adopters of the internet to create a free website hosted by
            <span style="font-family: 'Nunito', sans-serif;">
                MySpace™
            </span>
            than pay money for their own web services and domain name. This spurred millions of people to go out and make
            their profile, their online resume to the world. Several newer sites stemmed from MySpace building on what
            it had originally gave the world and gave us, the end users, more tools and resources to build our online
            image. An end does not seem to be in sight and these available materials are growing every day, as do the products
            people create with them.
        </p>
        <p style="text-align: left; text-indent: 2em">
            However arrogance still plays its role online just as it does in reality. Regardless of us having the
            ability to create anything we want on the Internet we still fail occasionally to understand how it will be
            interpreted, similar to how we behave, dress, and voice our opinions in reality. Our behavior and voice in
            real life are directly comparable to our own posts and our reactions to others. Similarly our dress is like
            our profile(s), it is how we appear to others. Here we see the great span of personalities where some people
            try to mimic themselves on the Internet creating a virtual self to broaden their existing identity. Some create
            identities that are polar opposites of their real live selves. Some do both, whether they intend to or not.
            This creates our Psycho-social moratorium as we've discussed in class. The opportunity to create one's own
            environment in which to explore accelerates the rate at which we discover ourselves and develop - this isn't
            to say that this is a good thing but it is happening nevertheless.
        </p>

        <p style="text-align: left; text-indent: 2em">
            This leads to our quiz (don't worry, this isn't graded). We want to see where you stand on the Internet, or
            at least a very general idea of how you may be perceived on the Internet. Presented will be a photo or a text
            snippet from some site with 5 possible answers. Upon completing a question we will record your answer and
            give you the result at the end.
        </p>
        <h5>To start the quiz, wake Kirby up with a little click</h5>
    </section>
</article>
<button id="kirby"><(-.-)>zZZzzZZ</button>
<div class="quiz">
    <div class="slider opened">
        <a href="https://twitter.com/rbunch" class="twitter-follow-button" data-show-count="false">
            Follow @rbunch
        </a>
        <script>
            !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');
        </script>

        <!-- Javascript and PHP function to print out our quiz questions-->
        <form id="quizForm" onsubmit="event.preventDefault();">
            <h3>Quiz</h3>
            <img id="quizImage" title="Question" alt="q" src=""/>
            <p id="q">
                Choose a reaction that best aligns with your own.
            </p>
            <input id="a1" type="radio" name="answer" value="1">
            <label id="l1"></label><br>
            <input id="a2" type="radio" name="answer" value="2">
            <label id="l2"></label><br>
            <input id="a3" type="radio" name="answer" value="3">
            <label id="l3"></label><br>
            <input id="a4" type="radio" name="answer" value="4">
            <label id="l4"></label><br>
            <input id="a5" type="radio" name="answer" value="5">
            <label id="l5"></label><br>
            <button type="button" onclick="checkQuestion()">Next</button>
        </form>
        <p id="end">
            <!--Final result should go here-->
        </p>
        <img id="endImage" title="End" alt="e" src=""/>
    </div>

</div>
<script type="text/javascript" src="slider.js"></script>
</body>
</html>