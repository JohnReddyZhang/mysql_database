SELECT ID,dishName from Dish WHERE weightPerServ < 20.0;
SELECT ingredientName from Ingredient WHERE energyPerServ < 20 OR isVegan = 1;
SELECT categoryName from Isle where storeName = 'store1' AND isleNumber = 2;
SELECT * from Stroe;
SELECT location as place FROM Style where backgroundLink IS NOT NULL;
SELECT '1' as isVegan, isSeasoning FROM Ingredient WHERE isVegan = '1';