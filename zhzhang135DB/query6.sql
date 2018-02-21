-- Select all dishes that uses ingredient with "Blak Pepper"
SELECT DISTINCT d.dishName Dish, u.ingredientName Ingredient
FROM Dish d
INNER JOIN UseIngredient u
ON d.ID = u.dishID
WHERE u.ingredientName LIKE "%Black Pepper%";

-- Select all vegan ingredient that are sold in a branch of "Hong Kong Market",
-- and calculate how much it will cost to buy them in each brach.
SELECT s.storeName Store, SUM(price) TotalPrice
FROM Ingredient i
NATURAL JOIN SellsIngredient s
WHERE i.isVegan = 1
AND s.storeName LIKE "Hong Kong Market%"
GROUP BY s.storeName;

-- See how many kitchenwares Dish "Kunpao Chicken_0" uses
SELECT d.dishName Dish, COUNT(*) Kitchenwares
FROM UseWare u
INNER JOIN Dish d
ON u.dishID = d.ID
WHERE d.dishName = "Kunpao Chicken_0";

-- See what dishes used ingredients that tastes like "cheesy", and what those ingredients are in each dish
-- Using subqueries
SELECT DISTINCT d.dishName, cheesyIngredient.ingredientName
FROM Dish d
INNER JOIN UseIngredient u
ON d.ID = u.dishID
INNER JOIN (SELECT t.ingredientName ingredientName, t.strength strength
            FROM IngredientTaste t
            WHERE t.flavorName LIKE "cheesy%") cheesyIngredient
ON u.ingredientName = cheesyIngredient.ingredientName;

-- Find dishes that need less than 40 minutes to cook and weights less than 40
-- In the meantime, the ingredients it use should have strong-ish tastes
SELECT DISTINCT d.dishName
FROM Dish d
INNER JOIN UseIngredient u
ON d.ID = u.dishID
INNER JOIN IngredientTaste t
ON t.ingredientName = u.ingredientName
WHERE d.weightPerServ < 40
AND d.cookingTime < "00:40:00"
AND t.strength LIKE "%strong%";
