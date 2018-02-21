<?php
/**
 * Created by PhpStorm.
 * User: JohnReddy
 * Date: 2017/11/28
 * Time: 08:55
 */

// Connection parameters
$host = 'mpcs53001.cs.uchicago.edu';
$username = 'zhzhang135';
$password = 'MuchAd0Ab0utN0ting';
$database = $username.'DB';

// Attempting to connect
$connect = mysqli_connect($host, $username, $password, $database)
or die('Could not connect: ' . mysqli_connect_error());
print 'Connected successfully!<br>';

// Selecting a database
//   Unnecessary in this case because we have already selected
//   the right database with the connect statement.
mysqli_select_db($connect, $database)
or die('Could not select database');
print 'Selected database successfully!<br>';

// Listing tables in your database
$query = 'SHOW TABLES';
$result = mysqli_query($connect, $query)
or die('Show tables failed: ' . mysqli_error());

print "The tables in $database database are:<br>";

// Printing table names in HTML
print '<ul>';
while ($tuple = mysqli_fetch_row($result)) {
    print '<li>'.$tuple[0].'</li>';
}
print '</ul>';

// Free result
mysqli_free_result($result);

// Closing connection
mysqli_close($connect);

?>


<script type="javascript">
    function goBack() {
        window.history.back()
    }
</script>
<button onclick="goBack()">Go Back</button>