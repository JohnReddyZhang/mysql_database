<?php
/**
 * Created by PhpStorm.
 * User: JohnReddy
 * Date: 2017/11/28
 * Time: 09:09
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

// Getting the input parameter (dish):
$dish = $_REQUEST['dish'];

//See all the allergies that is contained in the desired dish.
$query = "SELECT d.dishName, c.allergiesName 
          FROM Dish d
          INNER JOIN ContainsAllergy c
          ON d.ID = c.dishID
          WHERE d.dishName = '$dish'";

$result = mysqli_query($connect, $query)
or die('Query failed: ' . mysqli_error($connect));

if (mysqli_num_rows($result) > 0) {

    print "Dish <b>$dish</b> contains following allergies:";
    // Printing all allergies in HTML
    print '<ul>';
    while ($tuple = mysqli_fetch_array($result)) {
        print '<li> Allergy: ' . $tuple['allergiesName'] . '</li>';
    }
}
else{
    print "The query returns No results. Check your input.";
    $dish_list_query = "SELECT dishName
                        FROM Dish";
    $list = mysqli_query($connection, $dish_list_query)
    or die('Listing failed.'.mysqli_error($connection));
    print 'Dishes we have:';
    print '<ul>';
    while ($list_tuple = mysqli_fetch_assoc($list)){
        print "<li>$list_tuple[dishName]</li>";
    }
    print '</ul>';
}

print '</ul>';

// Free result
mysqli_free_result($result);
mysqli_free_result($list);

// Closing connection
mysqli_close($connect);

?>

<script type="text/javascript">
    function goBack() {
        window.history.back()
    }
</script>
<button onclick="goBack()">Go Back</button>