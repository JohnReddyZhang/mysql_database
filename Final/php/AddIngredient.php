<html>
<body>
<p>
    In this page you add a new ingredient.
</p>
<form method="post" action="">
    Ingredient: <input name="ingredientName" type="text" maxlength="30" placeholder="eg. Bread" required>
    <br>
    Weight (per serv): <input name="weightNeededPerServ" type="number" step="0.01" placeholder="eg. 20.3" required>
    <br>
    Energy (per serv): <input name="energyPerServ" type="number" placeholder="eg. 200" required>
    <br>
    <fieldset>
        <legend>Is it Vegan:</legend>
        <input type="radio" name="isVegan" value="1" title="Yes" checked>Yes
        <input type="radio" name="isVegan" value="0" title="No">No
    </fieldset>
    <br>
    <fieldset>
        <legend>Is it a Seasoning:</legend>
        <input type="radio" name="isSeasoning" value="1" title="Yes">Yes
        <input type="radio" name="isSeasoning" value="0" title="No" checked>No
    </fieldset>
    <br>
    <input type="submit" name="submit" value="Submit!">
</form>
    <?php
    // Connection parameters
    if(isset($_REQUEST['ingredientName'],$_REQUEST['weightNeededPerServ'],$_REQUEST['energyPerServ'])){
        $host = 'mpcs53001.cs.uchicago.edu';
        $username = 'zhzhang135';
        $password = 'MuchAd0Ab0utN0ting';
        $database = $username.'DB';

        $connection = mysqli_connect($host,$username,$password,$database)
        or die('Could not connect '.mysqli_connect_error());
        echo 'Connection Established!<br>';

        $ingredientName = $_REQUEST['ingredientName'];
        $weight = $_REQUEST['weightNeededPerServ'];
        $energy = $_REQUEST['energyPerServ'];
        $isVegan = $_REQUEST['isVegan'];
        $isSeasoning = $_REQUEST['isSeasoning'];

        $query = "CALL AddIngredient('$ingredientName', $isVegan, $isSeasoning, $weight, $energy)";

        if (mysqli_query($connection, $query)!== false){
            print "Query Succeed!";
        }
        elseif(mysqli_errno($connection) === 1644){
            print "Ingredient Already exists!";
        }
        else{
            print mysqli_errno($connection)."Unexpected Error. Sorry, please try again.";
        }
        mysqli_free_result($result);
        mysqli_close($connection);
    }
    else{
        print"Waiting for submission...";
    }

    ?>
<br>

<form action="AllIngredient.php">
    <input type="submit" value="Verify your input">
    <p>
        This will redirect you to a page showing all ingredients. If your input was success, you could see your input there.
    </p>
</form>

<form action="../final.html">
    <input type="submit" value="Go back to Main Page">
</form>

</body>
</html>
<?php
/**
 * Created by PhpStorm.
 * User: JohnReddy
 * Date: 2017/12/5
 * Time: 12:10
 */