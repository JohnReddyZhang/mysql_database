<html>
<body>
<p>
    In this page you could add a new dish.
</p>
<form method="post" action="">
    Dish's name: <input name="dish" type="text" title="dishName" placeholder="eg. Fried Rice" maxlength="140" required>
    <br>
    Cooking time: <input name="cookingTime" type="time" title="cookingTime" placeholder="eg. 00:20:00" pattern="[0-9][0-9]:[0-5][0-9]:[0-5][0-9]" required>
    <br>
    Weight Per Serv: <input name="weightPerServ" type="number" title="cookingTime" placeholder="eg. 200" min="0" step="0.1" required>
    <br>
    Style: <input name="style" type="text" tiltle="style" placeholder="eg. Cajun" maxlength="30" required>
    <br>
    Instruction link: <input name="instructionsLink" type="text" placeholder="link" required>
    (I should restrict this to a url but for now I won't. Same to the photo's link)
    <br>
    Photo link: <input name="photoLink" type="text" placeholder="link" required>
    <input name="submit" type="submit" value="Submit">
    <br>
</form>
<?php
/**
 * Created by PhpStorm.
 * User: JohnReddy
 * Date: 2017/12/4
 * Time: 22:53
 */

if(isset($_REQUEST['dish'],$_REQUEST['cookingTime'],$_REQUEST['weightPerServ'],$_REQUEST['style'])){
    $dish = $_REQUEST['dish'];
    $cooking_time = $_REQUEST['cookingTime'];
    $weight = $_REQUEST['weightPerServ'];
    $style = $_REQUEST['style'];
    $instructionsLink = $_REQUEST['instructionsLink'];
    $photo = $_REQUEST['photoLink'];

    // Connection parameters
    $host = 'mpcs53001.cs.uchicago.edu';
    $username = 'zhzhang135';
    $password = 'MuchAd0Ab0utN0ting';
    $database = $username.'DB';

    $dish_name = $_REQUEST["dish"];


    $connection = mysqli_connect($host,$username,$password,$database)
        or die('Could not connect '.mysqli_connect_error());
    echo 'Connection Established!<br>';

    $query = "INSERT INTO Dish(dishName, instructionsLink, cookingTime, photoLink, weightPerServ, styleName)
              VALUES('$dish','$instructionsLink','$cooking_time','$photo','$weight','$style')";

    if (mysqli_query($connection,$query) !== false){
        print "Query success!<br>
               Added into database!<br>";
        $retrieve_last = mysqli_fetch_assoc(mysqli_query($connection,"SELECT * FROM Dish ORDER BY ID DESC"));
        print "Dish $retrieve_last[dishName] is added into database!";
        print "This record is retrieved by visiting the database for verification purpose.";

    }
    elseif (mysqli_errno($connection) === 1452){
        print "<p>Query failed.<br>";
        print "Your style $style does not exist.<br>";
        print "Available Style:<br>";
        $list = mysqli_query($connection,"SELECT styleName From Style");
        print"<ul>";
        while ($list_tuple = mysqli_fetch_assoc($list)){
            print "<li>$list_tuple[styleName]</li>";
        }
        print "</ul></p>";
        print "<p>To add a new style, Click <a href='AddStyle.php'>Here</a></p>";
        mysqli_free_result($list);
    }
    elseif (mysqli_errno($connection) === 1062){
        print"<p>Query Failed.<br>
              The dish $dish you instered already exists!<br>";
        $list = mysqli_query($connection, "SELECT dishName FROM Dish");
        print "Here is all dishes we have:
               <ul>";
        while ($list_tuple = mysqli_fetch_assoc($list)){
            print "<li>$list_tuple[dishName]</li>";
        }
        print "</ul></p>";
        mysqli_free_result($list);
    }
    else{
        print "Error No.:".mysqli_errno($connection).": Sorry, unexpected error.";

    }

}
else {
    echo 'Waiting for submission...';
}


// Closing connection
mysqli_close($connection);

?>
<br>
<form action="../final.html">
    <input type="submit" value="Go back to Main Page">
</form>
</body>
</html>