<?php
/**
 * Created by PhpStorm.
 * User: JohnReddy
 * Date: 2017/11/28
 * Time: 14:08
 */

// Connection parameters
$host = 'mpcs53001.cs.uchicago.edu';
$username = 'zhzhang135';
$password = 'MuchAd0Ab0utN0ting';
$database = $username.'DB';

// Attempting to connect
$connect = mysqli_connect($host, $username, $password, $database)
or die('Could not connect: ' . mysqli_connect_error());

// Listing ingredients in database
$query = "SELECT ingredientName FROM Ingredient";
$result = mysqli_query($connect, $query)
or die('Show ingredients failed: ' . mysqli_error());

print "The ingredients we have database are:<br>";
// Printing ingredient names in HTML
print '<ul>';
while ($tuple = mysqli_fetch_assoc($result)) {
    print '<li>'.$tuple["ingredientName"].'</li>';
}
print '</ul>';

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
<p>
    Go back a page.
</p>

<form action="AddIngredient.php.php">
    <input type="submit" value="Verify your input">
    <p>
        Add another ingredient.
    </p>
</form>

<form action="../final.html">
    <input type="submit" value="Go back to Main Page">
</form>

