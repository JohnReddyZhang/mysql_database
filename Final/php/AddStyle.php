<html>
<body>
<p>
    In this page you could add a new style.<br>
</p>
<form method="post" action="">
    Style's name: <input name="styleName" type="text" title="styleName" placeholder="eg. New Chinese" maxlength="30" required>
    <br>
    Style's origin location: <input name="location" typle="text" title="location" placeholder="eg. Xinxiang, China" max="140" required>
    <br>
    Style's background story: <input name="backgroundLink" type="text" title="backgroundLink" placeholder="link" required>
    <br>
    <input name="submit" type="submit" value="Submit">
    <br>
</form>

<?php
/**
 * Created by PhpStorm.
 * User: JohnReddy
 * Date: 2017/12/5
 * Time: 10:17
 */

if(isset($_REQUEST['styleName'],$_REQUEST['location'],$_REQUEST['backgroundLink'])){
    $styleName = $_REQUEST['styleName'];
    $location = $_REQUEST['location'];
    $backgroundLink = $_REQUEST['backgroundLink'];

    // Connection parameters
    $host = 'mpcs53001.cs.uchicago.edu';
    $username = 'zhzhang135';
    $password = 'MuchAd0Ab0utN0ting';
    $database = $username.'DB';

    $dish_name = $_REQUEST["dish"];


    $connection = mysqli_connect($host,$username,$password,$database)
        or die('Could not connect '.mysqli_connect_error());
    echo 'Connection Established!<br>';

    $query = "INSERT INTO Style(styleName, location, backgroundLink)
              VALUES('$styleName','$location','$backgroundLink')";

    if (mysqli_query($connection,$query) !== false){
        print "Query success!<br>
               Added into database.<br>";
        $retrieve_last = mysqli_fetch_assoc(mysqli_query($connection,"SELECT styleName, entryTime 
                                                                             FROM Style 
                                                                             WHERE entryTime >= ALL (SELECT entryTime
                                                                                                    FROM Style)"));
        print "Style $retrieve_last[styleName] is added into database @$retrieve_last[entryTime]!";
        print "This record is retrieved by visiting the database for verification purpose.";
        mysqli_free_result($retrieve_last);
    }
    elseif (mysqli_errno($connection) === 1062){
        print "<p>Query failed.<br>";
        print "Your style already exists.<br>";
        print "Style already existing:<br>";
        $list = mysqli_query($connection,"SELECT styleName From Style");
        print"<ul>";
        while ($list_tuple = mysqli_fetch_assoc($list)){
            print "<li>$list_tuple[styleName]</li>";
        }
        print "</ul></p>";
        print "<p>Please try again.</p>";
        mysqli_free_result($list);
    }
    else{
        print "Query Failed. <br>
               Double check your input please.";
    }

}
else {
    echo 'Waiting for submission...';
}

mysqli_close($connection);
?>
<br>
<form action="../final.html">
    <input type="submit" value="Go back to Main Page">
</form>
</body>
</html>

