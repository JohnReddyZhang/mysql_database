<html>
<body>
<p>
    Add a kitchenware to Treasure Island's product list (and give it a price). Using stored procedure.
</p>
<form method="post" action="">
    Kitchenware Name:<input type="text" name="kitchenWare" maxlength="30" placeholder="eg. Frying Spoon" required>
    <br>
    Price: <input type="number" name="price" step="0.01" placeholder="eg. 20.5" required>
    <br>
    <input type="submit" name="submit" value="Submit!">
</form>
<?php
if(isset($_REQUEST['kitchenWare'], $_REQUEST['price'])){
    $kitchenWare = $_REQUEST['kitchenWare'];
    $price = $_REQUEST['price'];

    $host = 'mpcs53001.cs.uchicago.edu';
    $username = 'zhzhang135';
    $password = 'MuchAd0Ab0utN0ting';
    $database = $username.'DB';
    $connection = mysqli_connect($host,$username,$password,$database)
        or die('Could not connect '.mysqli_connect_error());

    $query = "CALL TreasureIslandSellsThis('$kitchenWare', $price)";
    $result = mysqli_query($connection,$query);
    if(!mysqli_errno($connection)){
        print "Successfully Added!<br>
               Added to database!<br>";
        $retrieve = mysqli_query($connection,"SELECT kitchenWareName, isleNumber, price 
                                 FROM SellsKitchenWare 
                                 WHERE storeName = 'Treasure Island'");
        print "Now Treasure island has:<ul>";
        while ($retrieve_tuple = mysqli_fetch_assoc($retrieve)){
            print "<li>$retrieve_tuple[kitchenWareName] on isle $retrieve_tuple[isleNumber], price is $retrieve_tuple[price] </li>";
        }
        print "</ul>";
    }
    else if (mysqli_error($connection)){
        print mysqli_error($connection);
    }
}
else{
    print "Waiting for submission...";
}
?>

<form action="../final.html">
    <input type="submit" value="Go back to Main Page">
</form>

</body>
</html>