

-- Buy all bargain ingredients in hong kong market's cost, and possible energy you could get
SELECT stuffCategory Category, ROUND(SUM(price),2) price, SUM(Ingredient.energyPerServ) energy
FROM HongKongMarketBargains H
INNER JOIN Ingredient
ON Ingredient.ingredientName = H.stuffName
GROUP BY stuffCategory;

SELECT Round(SUM(weightPerServ),2)
FROM Dish
INNER JOIN VeganDishes
ON Dish.dishName = VeganDishes.dishName;

-- See what ingredients are needed for pre-clean required dishes
SELECT DISTINCT dishName, ingredientName
FROM Dish
NATURAL JOIN PreClean
INNER JOIN UseIngredient
ON UseIngredient.dishID = Dish.ID;

-- All dishes that costs more than 50 to prepare (buy all ingredients as a whole packet)
SELECT Dish.dishName, Round(SUM(price),2) AS price
FROM Dish
INNER JOIN UseIngredient
ON UseIngredient.dishID = Dish.ID
INNER JOIN SellsIngredient
USING (ingredientName)
GROUP BY Dish.dishName
HAVING SUM(price) > 50;

-- What flavor and strength did all dishes not cover?
SELECT Flavor.flavorName flavor, Flavor.strength strength
FROM Flavor
LEFT OUTER JOIN DishTaste
ON Flavor.flavorName = DishTaste.flavorName
AND Flavor.strength = DishTaste.strength
WHERE dishID IS NULL;

-- Price to bu all kinds of certain stuff in organic stores (Bread has two kinds in different isles)
-- TempTable
DROP TABLE IF EXISTS stuffAtOrganicShops;
CREATE TEMPORARY TABLE stuffAtOrganicShops
AS
SELECT *
FROM (Select ingredientName stuffName, isleNumber, storeName, price, 'Ingredient' category
	  FROM SellsIngredient
	  UNION
	  Select kitchenWareName stuffName, isleNumber, storeName, price, 'KithcenWare' category
	  FROM SellsKitchenWare) stuffList
WHERE storeName = 'Whole Foods'
OR storeName LIKE '%Trader%';
-- Query
SELECT O.stuffName, SUM(price) price
FROM stuffAtOrganicShops O
INNER JOIN Ingredient I
ON O.stuffName = I.ingredientName
WHERE I.isVegan = 1
GROUP BY O.stuffName;

-- How heavy stuff you will get if you buy one of each ingredient in both stores in hyde park
-- TempTable
DROP TABLE IF EXISTS StoreInHydePark;
CREATE TEMPORARY TABLE StoreInHydePark
AS
SELECT storeName
FROM Store
WHERE zip = '60615';
-- Query
SELECT H.storeName, ROUND(SUM(S.weightPerPack),2) weight
FROM StoreInHydePark H
INNER JOIN SellsIngredient S
ON H.storeName = S.storeName
GROUP BY H.storeName;

-- Howmuch it will cost to buy all ingredients with strong flavors
SELECT DISTINCT S.ingredientName, price
FROM SellsIngredient S
INNER JOIN IngredientTaste T
ON S.ingredientName = T.ingredientName
WHERE strength = 'Strong';

-- what kitchen wares were left out
SELECT wareName
FROM KitchenWare K
LEFT OUTER JOIN UseWare U
ON K.wareName = U.kitchenWareName
WHERE kitchenWareName IS NULL;


-- In the cookbook which dish in which style has most allergies?
DROP VIEW IF EXISTS typesOfAllergies;
CREATE VIEW typesOfAllergies
AS
SELECT dishName dish, COUNT(allergiesName) types
	  FROM Dish
	  INNER JOIN ContainsAllergy A
	  ON Dish.ID = A.dishID
	  GROUP BY dish;
-- Query
SELECT Dish.dishName name, Dish.styleName style
FROM Dish
INNER JOIN
(SELECT dish, types
FROM typesOfAllergies A
GROUP BY dish
HAVING types = (SELECT MAX(types) FROM typesOfAllergies)) maxAllergies
ON Dish.dishName = maxAllergies.dish
