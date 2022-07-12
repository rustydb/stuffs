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

?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="style.css">
    <script type="text/javascript" src="slider.js"></script>
    <title>4551 Project - Identity Crisis</title>
</head>
<body>
<article class="intro">
    <header>
        <p id="title">
            Web Ripples  |
                <span style="font-size: x-small; position: relative; bottom: 4px">
                    Created by: Cavan Hussein & Russell Bunch
                    <span class="blinkme" style="position: relative; bottom: 1px">
                        _
                    </span>
<!--                    <a href="https://twitter.com/rbunch" class="twitter-follow-button" data-show-count="false">-->
<!--                        Follow @rbunch-->
<!--                    </a>-->
<!--                    <script>-->
<!--                        !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');-->
<!--                    </script>-->
                </span>
            <br>
                <span style="font-size: medium">Welcome to our project site,
                    <span style="font-family:  ‘Courier New’, Courier, monospace">
                        <?php echo $_SERVER['REMOTE_ADDR'] ?>
                    </span>
                    . We hope you enjoy your stay!
                </span>
        </p>
    </header>
    <!--Expand box-->
    <!--        <input type="checkbox" id="read_more" role="button">-->
    <!--        <label for="read_more" onclick="">-->
    <!--            <span>Continue..</span>-->
    <!--            <span>Eh.. go away</span>-->
    </label>
    <figure>
        <img style="float: left; padding-right: 1em" src="http://media.ign.com/games/image/article/725/725407/tubernet_1155530890.jpg" alt="Series of tubes">
    </figure>
    <section>
        <p style="text-align: left; text-indent: 1em">
            First and foremost, a brief overview of some of the terminology and background information is needed for the project.
            Our semester project had us work with domain specific languages. Domain specific languages (DSLs) are smaller languages that focus on a
            particular aspect of a system or application, unlike general purpose languages (GPLs) which span over multiple domains. GPLs are used
            more frequently because of their larger domain, languages such as C++, Java, and Python are general purpose languages. GPLs work over
            a broader spectrum and are easier to run on different machines. However domain specific languages have specificity that general purpose
            languages lack because they are specialized in a single domain. Thus they are easier for some programmers to code in when looking at a
            particular aspect of a system. This makes for more efficient coding, creating a more efficient work flow.
        </p>
    </section>
</article>
<div class="quiz">
    <div class="slider opened">
        <h3>Internet Community Placement</h3>
        <img id="quizimage" title="Question 1" alt="q1" src="banana_dolphin.gif"/>
        <form>
            <input type="radio" name="answer" value="a">Answer A should go here<br>
            <input type="radio" name="answer" value="b">Answer B should go here<br>
            <input type="radio" name="answer" value="c">Answer C should go here<br>
            <input type="radio" name="answer" value="d">Answer D should go here<br>
        </form>
    </div>
</div>
<button id="kirby"><(-.-)>zZZzzZZ</button>


</body>
</html>