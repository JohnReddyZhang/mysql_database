-- Shows All dishes that all its ingredients were vegan. (Cheese is vegan... in my idea);
DROP VIEW IF EXISTS VeganDishes;
CREATE VIEW VeganDishes
AS SELECT Dish.dishName
FROM Dish
INNER JOIN UseIngredient
ON Dish.ID = UseIngredient.dishID
INNER JOIN Ingredient
ON UseIngredient.ingredientName = Ingredient.ingredientName
GROUP BY Dish.dishName
HAVING SUM(Ingredient.isVegan) = COUNT(Ingredient.isVegan);

-- Displays all stuff in Hongkong Market that its price is lower than 25
DROP VIEW IF EXISTS HongKongMarketBargains;
CREATE VIEW HongKongMarketBargains
AS
SELECT stuffName, price, stuffCategory
FROM
(SELECT ingredientName stuffName, price, storeName, 'Ingredient' stuffCategory
FROM SellsIngredient
UNION
SELECT kitchenWareName stuffName, price, storeName, 'Kitchen Ware' stuffCategory
FROM SellsKitchenWare) stuffList
WHERE price <= 25
AND storeName = 'Hong Kong Market';

-- See what dishes need to clean the ingredients first (have Clean as one of the methond procedure)
DROP VIEW IF EXISTS PreClean;
CREATE VIEW PreClean
AS
SELECT Dish.dishName
FROM Dish
INNER JOIN ByMethod
ON Dish.ID = ByMethod.dishID
WHERE ByMethod.methodName = 'Clean';