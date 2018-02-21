<html>
<body>
<p>
    In this page you could add a new flavor.
</p>
<form method="post" action="">
    Flavor's name (lower case): <input name="flavor" type="text" title="flavor" placeholder="sweet" maxlength="30" pattern="[a-z]{1,}" required>

    <input name="submit" type="submit" value="Submit">
    <br>
</form>
<?php

if(isset($_REQUEST['flavor'])){
    $flavor = $_REQUEST['flavor'];

    // Connection parameters
    $host = 'mpcs53001.cs.uchicago.edu';
    $username = 'zhzhang135';
    $password = 'MuchAd0Ab0utN0ting';
    $database = $username.'DB';

    $connection = mysqli_connect($host,$username,$password,$database)
        or die('Could not connect '.mysqli_connect_error());
    echo 'Connection Established!<br>';
//    $strength_list = array('Strong','Mild','Light');

    $query = "INSERT INTO Flavor(flavorName, strength)
              VALUES('$flavor','Strong');
              INSERT INTO Flavor(flavorName, strength)
              VALUES('$flavor','Mild');
              INSERT INTO Flavor(flavorName, strength)
              VALUES('$flavor','Light');";

//    $list = mysqli_query($connection,"SELECT EXISTS (SELECT flavorName
//                                                            FROM Flavor
//                                                            WHERE flavorName = '$flavor') as exist");
//    $list_tuple = mysqli_fetch_assoc($list)
//        or die("WRONG");
    mysqli_multi_query($connection,$query);
    while(mysqli_next_result($connection)){print "";}
    // ref: https://stackoverflow.com/questions/27899598/mysqli-multi-query-commands-out-of-sync-you-cant-run-this-command-now
    if (!mysqli_errno($connection)){
        print "<p>Successfully added!</p>";
        $list = mysqli_query($connection, "SELECT DISTINCT flavorName FROM Flavor")
            or die(mysqli_error($connection));
        print "Here are all flavors we have now:
               <ul>";
        while ($list_tuple = mysqli_fetch_assoc($list)){
            print "<li>$list_tuple[flavorName]</li>";
        }
        print "</ul></p>";
        mysqli_free_result($list);
    }
    elseif (mysqli_errno($connection) === 1062){
        print"<p>Query Failed.<br>
              The flavor $flavor you inserted already exists!<br>";
        $list_existing = mysqli_query($connection, "SELECT DISTINCT flavorName FROM Flavor");
        print "Here are all flavors we have:
               <ul>";
        while ($list_existing_tuple = mysqli_fetch_assoc($list_existing)){
            print "<li>$list_existing_tuple[flavorName]</li>";
        }
        print "</ul></p>";
        mysqli_free_result($list_existing);
    }
    else{
        print "Unhandeled error:".mysqli_error($connection)."Sorry.";
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