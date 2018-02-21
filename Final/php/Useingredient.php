<?php
/**
 * Created by PhpStorm.
 * User: JohnReddy
 * Date: 2017/11/28
 * Time: 14:14
 */

// Connection parameters
$host = 'mpcs53001.cs.uchicago.edu';
$username = 'zhzhang135';
$password = 'MuchAd0Ab0utN0ting';
$database = $username.'DB';

$ingredient = $_REQUEST["ingredient"];
// Attempting to connect
$connect = mysqli_connect($host, $username, $password, $database)
or die('Could not connect: ' . mysqli_connect_error());

$query = "SELECT DISTINCT d.dishName, d.instructionsLink
          FROM UseIngredient u
          INNER JOIN Dish d
          ON u.dishID = d.ID
          WHERE ingredientName = '$ingredient'";
$result = mysqli_query($connect, $query)
    or die("Query Failed. ".mysqli_error($connect));
if (mysqli_num_rows($result) > 0) {
    print"<p>These dish(es) use your desired ingredient:";
    print "<br> Note that the link could not work because all links in the databse is actually placeholder like 'linkk1'.</p>";
    print"<ul>";
    while ($tuple = mysqli_fetch_assoc($result)) {
        print "<li>$tuple[dishName], instruction link: <a href='$tuple[instructionsLink]'>click me</a></li>";
    }
    print "</ul>";
}
else{
    print "Did not find the ingredient, or the ingredient is not used. Please try again.";
}

// Free result
mysqli_free_result($result);

// Closing connection
mysqli_close($connect);

?>
<script type="text/javascript">
    function goBack() {
        window.history.back()
    }
</script>
<button onclick="goBack()">Go Back</button>
