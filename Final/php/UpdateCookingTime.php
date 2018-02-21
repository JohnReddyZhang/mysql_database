<html>
<body>
<p>
    Select the dish you want to update, and update its cooking time.
</p>
<form method="post" action="">
    Dishes you have:
    <select name="dishName" title="dishName">
        <?php
        $host = 'mpcs53001.cs.uchicago.edu';
        $username = 'zhzhang135';
        $password = 'MuchAd0Ab0utN0ting';
        $database = $username.'DB';
        $connection = mysqli_connect($host,$username,$password,$database)
            or die('Could not connect '.mysqli_connect_error());

        $query_dishes = "SELECT dishName from Dish";

        $list_dishes = mysqli_query($connection, $query_dishes)
            or die ('Failed while trying to list existing dishes');
        while ($dish_tuple = mysqli_fetch_assoc($list_dishes)) {
            print "<option value=\"$dish_tuple[dishName]\">$dish_tuple[dishName]</option>";
        }
        mysqli_free_result($list_dishes);
        mysqli_close($connection);
        ?>
    </select>
    <br>
    <input name="cookingTime" type="time" title="cookingTime" placeholder="eg. 00:20:00" pattern="[0-9][0-9]:[0-5][0-9]:[0-5][0-9]" required>
    <input name="submit" type="submit" value="Submit!">
</form>
<?php
if(isset($_REQUEST['dishName'], $_REQUEST['cookingTime'])){
    $dishName = $_REQUEST['dishName'];
    $cookingTime = $_REQUEST['cookingTime'];

    // Connection parameters
    $update_connection = mysqli_connect($host,$username,$password,$database)
        or die('Could not connect '.mysqli_connect_error());

    $query_update = "UPDATE Dish SET cookingTime = '$cookingTime' WHERE dishName = '$dishName'";

    if (mysqli_query($update_connection, $query_update)){
        print "Updated!<br>";
        $retrieve_last = mysqli_query($update_connection, "SELECT dishName, cookingTime 
                                                                  FROM Dish 
                                                                  WHERE timeStamp >= ALL (SELECT timeStamp FROM Dish)");
        $last_tuple = mysqli_fetch_assoc($retrieve_last);
        print "Current cooking time for $last_tuple[dishName] is $last_tuple[cookingTime]";
        print "This record is retrieved by visiting the database for verification purpose.";
        mysqli_free_result($retrieve_last);
    }
    else{
        print mysqli_errno($update_connection).": Sorry, unexpected error.";
    }

    mysqli_close($update_connection);

}
?>

<br>
<form action="../final.html">
    <input type="submit" value="Go back to Main Page">
</form>

</body>
</html>
