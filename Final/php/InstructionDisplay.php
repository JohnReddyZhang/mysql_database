<html>
<body>
<p>
    Now I will display the instruction of cooking a certain dish, <br>
    and its corresponding photo.
</p>
<form method=post action="">
    <p>'
        Tell me what you want to learn about:'
    </p>'
    <input name="dish" type="text" title="dishName" placeholder="Dish name">'
    <input type="submit" value="Find!">
</form>

<br>;
<?php
if(isset($_REQUEST["dish"])){
    /**
     * Created by PhpStorm.
     * User: JohnReddy
     * Date: 2017/12/4
     * Time: 22:06
     */


// Connection parameters
    $host = 'mpcs53001.cs.uchicago.edu';
    $username = 'zhzhang135';
    $password = 'MuchAd0Ab0utN0ting';
    $database = $username.'DB';

    $dish_name = $_REQUEST["dish"];


    $connection = mysqli_connect($host,$username,$password,$database)
    or die('Could not connect '.mysqli_connect_error());
    echo 'Connection Established!<br>';

    $query = "SELECT dishName, instructionsLink, photoLink
          FROM Dish
          WHERE dishName = '$dish_name'";
    $result = mysqli_query($connection, $query)
    or die("Query Failed".mysqli_error($connection));

    print "You asked for dish $dish_name";

    if (mysqli_num_rows($result) > 0){
        $tuple = mysqli_fetch_assoc($result);
        print "<p>The dish's instruction could be viewed at: <a href='$tuple[instructionsLink]'>$tuple[dishName]</a>";
        print "<br> Note that the link could not work because all links in the databse is actually placeholder like 'linkk1'.</p>";
        print "<p>The dish's photo:<br></p>";
        print "<img src='$result[photoLink]' alt='photo of $result[dishName]'>";
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
    mysqli_free_result($list);
    mysqli_close($connection);
}
else{
    print "Waiting for submission...";
}
?>
<br>
<br>
<script type="text/javascript">
    function goBack() {
        window.history.back()
    }
</script>
<form action="../final.html">
    <input type="submit" value="Go back to Main Page">
</form>

</body>
</html>
