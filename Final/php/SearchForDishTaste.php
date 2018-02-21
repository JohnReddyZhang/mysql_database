<?php
/**
 * Created by PhpStorm.
 * User: JohnReddy
 * Date: 2017/11/28
 * Time: 11:07
 */

$host = 'mpcs53001.cs.uchicago.edu';
$username = 'zhzhang135';
$password = 'MuchAd0Ab0utN0ting';
$database = $username.'DB';

$strength = $_REQUEST["strength"];
$flavor = $_REQUEST["flavor"];
$connection = mysqli_connect($host,$username,$password,$database)
    or die('Could Not Connect'.mysqli_connect_error());
print "Your desired taste is $flavor, <br>";

if ($strength == "NULL"){
    $query = "CALL SearchForDishTaste('$flavor',NULL)";
    print "Your desired strength is all strength";
}
else{
    $query = "CALL SearchForDishTaste('$flavor','$strength')";
    print "Your desired strength is $strength";
}

$result = mysqli_query($connection, $query)
    or die("Could not Query".mysqli_error($connection));

print"<ul>";
while ($tuple = mysqli_fetch_assoc($result)){
    print "<li>$tuple[dishName]</li>";
}
print "</ul>";

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

