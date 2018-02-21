<html>
<body>
<p>
    Select the ingredient you want to add photo, and give us its link.
</p>
<form method="post" action="">
    Ingredients you have:
    <select name="ingredientName" title="ingredientName">
        <?php
        $host = 'mpcs53001.cs.uchicago.edu';
        $username = 'zhzhang135';
        $password = 'MuchAd0Ab0utN0ting';
        $database = $username.'DB';
        $connection = mysqli_connect($host,$username,$password,$database)
        or die('Could not connect '.mysqli_connect_error());

        $query_ingredient = "SELECT ingredientName from Ingredient";

        $list_ingredient = mysqli_query($connection, $query_ingredient)
            or die ('Failed while trying to list existing dishes');
        while ($ingredient_tuple = mysqli_fetch_assoc($list_ingredient)) {
            print "<option value=\"$ingredient_tuple[ingredientName]\">$ingredient_tuple[ingredientName]</option>";
        }
        mysqli_free_result($list_ingredient);
        mysqli_close($connection);
        ?>
    </select>
    <br>
    <input name="photoLink" type="url" title="photoLink" placeholder="http://some.url/img.jpg" required>
    <input name="submit" type="submit" value="Submit!">
</form>
<?php
if(isset($_REQUEST['ingredientName'], $_REQUEST['photoLink'])){
    $ingredientName = $_REQUEST['ingredientName'];
    $photoLink = $_REQUEST['photoLink'];

    // Connection parameters
    $update_connection = mysqli_connect($host,$username,$password,$database)
    or die('Could not connect '.mysqli_connect_error());

    $query_update = "UPDATE Ingredient SET photoLink = '$photoLink' WHERE ingredientName = '$ingredientName'";

    if (mysqli_query($update_connection, $query_update)){
        print "Updated!<br>";
        $retrieve_last = mysqli_query($update_connection, "SELECT ingredientName, photoLink 
                                                                  FROM Ingredient 
                                                                  WHERE timeStamp >= ALL (SELECT timeStamp FROM Ingredient)");
        $last_tuple = mysqli_fetch_assoc($retrieve_last);
        print "Current photo for $last_tuple[ingredientName] is:<br>
               <img src=\"$last_tuple[photoLink]\" alt=\"Photo for $last_tuple[ingredientName]\"><br>
               link is: $last_tuple[photoLink]";
        print "This record is retrieved by visiting the database for verification purpose.
                <br>It will display an actual picture if the url is valid.";
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
