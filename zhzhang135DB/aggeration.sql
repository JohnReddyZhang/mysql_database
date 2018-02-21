#Find how much you would pay if you buy 'ing2', 'ing3'
SELECT ROUND(SUM(price),2)
FROM SellsIngredient
WHERE SellsIngredient.ingredientName = 'ing2'
OR SellsIngredient.ingredientName = 'ing3';

#Find avg energy of ingredient that has 'Rice' in it ( is a kind of rice)
SELECT avg(energyPerServ)
FROM Ingredient
WHERE ingredientName LIKE '%Rice%';

#find how many ingredients are strong in flavor
SELECT count(*)
FROM IngredientTaste
WHERE strength = 'Strong';

#find the average price of ingredients that weighs more than 23, and is sould in store 1
SELECT AVG(price)
FROM SellsIngredient
WHERE weightPerPack > 23
AND storeName = 'store1';

#find what kitchenWare is the most expensive for all kitchwares that are buyable
SELECT kitchenWareName, price
FROM SellsKitchenWare
WHERE price = 
(SELECT Max(price)
FROM SellsKitchenWare);

#Find out which dish in each style has the longest cooking time
SELECT dishName, cookingTime, styleName
FROM Dish
WHERE cookingTime in 
(SELECT MAX(cookingTime)
FROM Dish
GROUP BY StyleName)