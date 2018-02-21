<?php
/**
 * Created by PhpStorm.
 * User: JohnReddy
 * Date: 2017/12/7
 * Time: 17:59
 * This is just a test page and is not part of the final project.
 */
if(isset($_REQUEST['kw'], $_REQUEST['photo'])){
    $kw = $_REQUEST['kw'];
    $photo = $_REQUEST['photo'];
    if ($photo == "") {
        $photo = NULL;
    }

    // Connection parameters
    $connection = mysqli_connect($host,$username,$password,$database)
    or die('Could not connect '.mysqli_connect_error());

    $query = "INSERT INTO KitchenWare VALUES ('$kw','$photo')";

    if (mysqli_query($connection, $query_update)){
        print "Updated!<br>";
        $retrieve_last = mysqli_query($connection, "SELECT ingredientName, photoLink 
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
        print mysqli_errno($connection).": Sorry, unexpected error.";
    }

    mysqli_close($connection);

}
?>
<form method="post" action="">
    Kitchenware name:<input name="kw" type="text" title="kw" placeholder="kw" required>
    Photo link: <input name="photo" type="text" title="photo">
    <input name="submit" type="submit" value="Submit!">
</form>

