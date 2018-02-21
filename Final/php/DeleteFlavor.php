<html>
<body>
<p>
    Delete a flavor in dictionary. Dishes with this flavor will be deleted (in DishTaste table).
</p>
<form method="post" action="">
    Flavors you have:
    <select name="flavorName" title="flavorName">
        <?php
        $host = 'mpcs53001.cs.uchicago.edu';
        $username = 'zhzhang135';
        $password = 'MuchAd0Ab0utN0ting';
        $database = $username.'DB';
        $connection = mysqli_connect($host,$username,$password,$database)
        or die('Could not connect '.mysqli_connect_error());

        $query_flavor = "SELECT DISTINCT flavorName from Flavor";

        $list_flavor = mysqli_query($connection, $query_flavor)
            or die ('Failed while trying to list existing flavors');
        while ($flavor_tuple = mysqli_fetch_assoc($list_flavor)) {
            print "<option value=\"$flavor_tuple[flavorName]\">$flavor_tuple[flavorName]</option>";
        }
        mysqli_free_result($list_flavor);
        mysqli_close($connection);
        ?>
    </select>
    <br>
    <input name="submit" type="submit" value="Delete!">
</form>
<form>
    <input type="button" value="Refresh List" onClick="window.location.reload()">
</form>
<p>
    Refreshing the page will update the selection above.
    <br>If you deleted a flavor, you could see them disappeared after refreshing.
    <br>They are available to be inspected in the results text.
</p>
<?php
if(isset($_REQUEST['flavorName'])){
    $flavorName = $_REQUEST['flavorName'];

    // Connection parameters
    $delete_connection = mysqli_connect($host,$username,$password,$database)
    or die('Could not connect '.mysqli_connect_error());

    $query_update = "DELETE FROM Flavor WHERE flavorName = '$flavorName'";
    $result = mysqli_query($delete_connection, $query_update)
        or die("ErrorNO: ".mysqli_error($connection));
    if (!mysqli_errno($delete_connection)){
        print "Updated!<br>Current flavor:<br>";
        $current_flavors = mysqli_query($delete_connection, "SELECT DISTINCT flavorName 
                                                                    FROM Flavor;");
        print "<ul>";
        while ($current_tuple = mysqli_fetch_assoc($current_flavors)){
            print "<li>$current_tuple[flavorName]</li>";
        }
        print "</ul>";
        mysqli_free_result($current_flavors);
    }
    else{
        print mysqli_errno($delete_connection).": Sorry, unexpected error.";
    }

    mysqli_close($delete_connection);


}
else{
    print "Waiting for submission...";
}
?>

<br>
<form action="../final.html">
    <input type="submit" value="Go back to Main Page">
</form>

</body>
</html>
