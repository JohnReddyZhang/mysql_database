SELECT 'Allergies' TableName, COUNT(*) Count
FROM Allergies
UNION ALL
SELECT 'Appliance' TableName, COUNT(*) Count
FROM Appliance
UNION ALL
SELECT 'ByMethod' TableName, COUNT(*) Count
FROM ByMethod
UNION ALL
SELECT 'Containers' TableName, COUNT(*) Count
FROM Containers
UNION ALL
SELECT 'ContainsAllergy' TableName, COUNT(*) Count
FROM ContainsAllergy
UNION ALL
SELECT 'CookingMethod' TableName, COUNT(*) Count
FROM CookingMethod
UNION ALL
SELECT 'Dish' TableName, COUNT(*) Count
FROM Dish
UNION ALL
SELECT 'DishTaste' TableName, COUNT(*) Count
FROM DishTaste
UNION ALL
SELECT 'Flavor' TableName, COUNT(*) Count
FROM Flavor
UNION ALL
SELECT 'Ingredient' TableName, COUNT(*) Count
FROM Ingredient
UNION ALL
SELECT 'IngredientTaste' TableName, COUNT(*) Count
FROM IngredientTaste
UNION ALL
SELECT 'Isle' TableName, COUNT(*) Count
FROM Isle
UNION ALL
SELECT 'KitchenWare' TableName, COUNT(*) Count
FROM KitchenWare
UNION ALL
SELECT 'SellsIngredient' TableName, COUNT(*) Count
FROM SellsIngredient
UNION ALL
SELECT 'SellsKitchenWare' TableName, COUNT(*) Count
FROM SellsKitchenWare
UNION ALL
SELECT 'Store' TableName, COUNT(*) Count
FROM Store
UNION ALL
SELECT 'Style' TableName, COUNT(*) Count
FROM Style
UNION ALL
SELECT 'UseIngredient' TableName, COUNT(*) Count
FROM UseIngredient
UNION ALL
SELECT 'UseWare' TableName, COUNT(*) Count
FROM UseWare
UNION ALL
SELECT 'Utensil' TableName, COUNT(*) Count
FROM Utensil
UNION ALL
