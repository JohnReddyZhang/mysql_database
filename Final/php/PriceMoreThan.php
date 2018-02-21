<?php
/**
 * Created by PhpStorm.
 * User: JohnReddy
 * Date: 2017/11/28
 * Time: 10:31
 */

// Connection parameters
$host = 'mpcs53001.cs.uchicago.edu';
$username = 'zhzhang135';
$password = 'MuchAd0Ab0utN0ting';
$database = $username.'DB';

$query_price = $_REQUEST['price'];

// Attempting to connect
$connection = mysqli_connect($host, $username, $password, $database)
or die('Could not connect: ' . mysqli_connect_error());
echo 'Connected successfully!<br>';

$query = "CALL PriceMoreThan($query_price)";
$result = mysqli_query($connection,$query)
    or die('Query Failed'.mysqli_error($connection));
print "The following dishes costs more than <b>$query_price</b>";
print '<ol>';
while($tuple = mysqli_fetch_assoc($result)){
    print   "<li>".$tuple["dishName"]." costs ".$tuple["price"].'</li>';
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
