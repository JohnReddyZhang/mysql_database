-- Add a kitchen ware to make it on sell at Treasure Island.
DROP PROCEDURE IF EXISTS TreasureIslandSellsThis;
DELIMITER |
CREATE PROCEDURE TreasureIslandSellsThis(
	IN addKitchenWareName VARCHAR(30),
	IN addPrice			  FLOAT
)
BEGIN
	DECLARE addStoreName  VARCHAR(30);
	SET addStoreName = "Treasure Island";
	IF addKitchenWareName NOT IN (SELECT kitchenWareName 
									FROM SellsKitchenWare 
									WHERE storeName = addStoreName)
	THEN
		IF addKitchenWareName NOT IN (SELECT wareName
										FROM KitchenWare)
		THEN
			INSERT INTO KitchenWare 
				VALUES (addKitchenWareName, NULL);
		END IF;
		INSERT INTO SellsKitchenWare 
			VALUES (addKitchenWareName, 1, addStoreName, addPrice);
	END IF;
END |
DELIMITER ;


-- Add an ingredient if it does not exist, and use the avg of energy and the avg of the weight as its energy and weight
DROP PROCEDURE IF EXISTS AddIngredient;
DELIMITER |
CREATE PROCEDURE AddIngredient(
	IN addIngredientName varChar(30),
	IN setIsVegan TINYINT,
	IN setIsSeasoning TINYINT)
BEGIN
	DECLARE avgEnergy INT;
	DECLARE avgWeight int;
	SET avgEnergy = (SELECT AVG(energyPerServ)
						FROM Ingredient);
	SET avgWeight = (SELECT AVG(weightNeededPerServ)
						FROM Ingredient);
	IF addIngredientName NOT IN (SELECT ingredientName
									FROM Ingredient)
	THEN
		INSERT INTO Ingredient 
			VALUES (addIngredientName, avgWeight, avgEnergy, setIsVegan, setIsSeasoning, 				NULL);
	END IF;
END |
DELIMITER ;
		
-- Searches for a dish taht has a certain taste (and strength)
DROP PROCEDURE IF EXISTS SearchForDishTaste;
DELIMITER |
CREATE PROCEDURE SearchForDishTaste(
	IN findTaste VARCHAR(30),
	IN findStrength VARCHAR(30))
BEGIN
	IF findTaste NOT IN (SELECT flavorName FROM Flavor) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not FOUND!';
	ELSE
		IF findStrength IS NULL THEN
			SELECT d.dishName, t.flavorName, t.strength
			FROM DishTaste t
			INNER JOIN Dish d
			ON d.ID = t.dishID
			WHERE t.flavorName = findTaste;
		ELSE
			SELECT d.dishName, t.flavorName, t.strength
			FROM DishTaste t
			INNER JOIN Dish d
			ON d.ID = t.dishID
			WHERE t.flavorName = findTaste
			AND t.strength = findStrength;
		END IF;
	END IF;
END| 
DELIMITER ;

-- Searches for dishes that uses a certain ingredient
DROP PROCEDURE IF EXISTS usesIngredient;
DELIMITER |
CREATE PROCEDURE usesIngredient(
	IN useIngredientName VARCHAR(30))
BEGIN
	IF useIngredientName NOT IN (SELECT ingredientName FROM Ingredient) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not FOUND!';
	ELSE
		SELECT DISTINCT d.dishName Dish, u.ingredientName Ingredient
		FROM Dish d
		INNER JOIN UseIngredient u
		ON d.ID = u.dishID
		WHERE u.ingredientName = useIngredientName;
	END IF;
END|
DELIMITER ;

-- Find all dishes that would cost more than desired price to prepare.
DROP PROCEDURE IF EXISTS PriceMoreThan;
DELIMITER |
CREATE PROCEDURE PriceMoreThan(
	IN forPrice float)
BEGIN
	SELECT Dish.dishName, Round(SUM(price),2) AS price
	FROM Dish
	INNER JOIN UseIngredient
	ON UseIngredient.dishID = Dish.ID
	INNER JOIN SellsIngredient
	USING (ingredientName)
	GROUP BY Dish.dishName
	HAVING SUM(price) > forPrice;
END|
DELIMITER ;

