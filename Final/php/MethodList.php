<?php
/**
 * Created by PhpStorm.
 * User: JohnReddy
 * Date: 2017/11/28
 * Time: 14:52
 */

$host = 'mpcs53001.cs.uchicago.edu';
$username = 'zhzhang135';
$password = 'MuchAd0Ab0utN0ting';
$database = $username.'DB';

$connection = mysqli_connect($host,$username,$password,$database)
or die('Could not connect '.mysqli_connect_error());

$dish_name = $_REQUEST["Dish"];

$query = "SELECT b.methodName, b.sequence, d.dishName
          FROM ByMethod b
          INNER JOIN Dish d
          ON d.ID = b.dishID
          WHERE d.dishName ='$dish_name'
          ORDER BY b.sequence";
//$sql = $connection -> prepare("SELECT b.methodName, b.sequence, d.dishName
//                                        FROM ByMethod b
//                                        INNER JOIN Dish d
//                                        ON d.ID = b.dishID
//                                        WHERE d.dishName =:parameter");
//$stmt -> bindParam(':parameter',$dish_name);
//$stmt -> execute();

$result = mysqli_query($connection,$query)
    or die("Query Failed".mysqli_error($connection));

if (mysqli_num_rows($result) > 0) {
    print "The method for cooking $dish_name is:";
    print '<ul>';
    while ($tuple = mysqli_fetch_assoc($result)) {
        print "<li>$tuple[methodName] at step $tuple[sequence]</li>";
    }
    print '</ul>';
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

mysqli_free_result($result);
mysqli_close($connection);

?>

<script type="text/javascript">
    function goBack() {
        window.history.back()
    }
</script>
<button onclick="goBack()">Go Back</button>

