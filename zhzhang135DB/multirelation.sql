#Find all dishes that does not use kitchenware "kw1"
SELECT DishName, PhotoLink
FROM Dish, UseWare
WHERE Dish.ID = UseWare.dishID
AND KitchenWareName != 'kw1';

#Find whether a dish is vegan or not if it is sold in Store1 and has lower than 170 cal in energy
SELECT Ingredient.ingredientName, isVegan
FROM Ingredient, SellsIngredient
WHERE energyPerServ < 170
AND StoreName = 'Store1'
AND Ingredient.ingredientName = SellsIngredient.ingredientName;

#Find ingredients that is strong in flavor and is vegan and retrun waht flavor it is strong in
SELECT Ingredient.ingredientName, flavorName AS Flavor
FROM Ingredient, IngredientTaste
WHERE Ingredient.ingredientName = IngredientTaste.ingredientName
AND Strength = 'Strong'
AND isVegan = 1;

#Find kitchenwares's photo which sells more than 25
SELECT wareName, photo, price
FROM KitchenWare, SellsKitchenWare
WHERE price > 25
AND kitchenWareName = wareName;

#Find whether a dish contains allergy 'aller2' and weight per serving < 25
SELECT dishName, allergiesName
FROM Dish, ContainsAllergy
WHERE dishID = ID
AND allergiesName = 'aller2'
AND weightPerServ < 25;

#Find Photo of Store and its name if it sells ingredient 'ingredient3' or 'ingredient2'
SELECT Store.BrandPhotoLink, Store.storeName
FROM Store, SellsIngredient
WHERE Store.storeName = SellsIngredient.storeName
AND (ingredientName = 'ing3'
OR ingredientName = 'ing2');

/* 
SELECT Store.BrandPhotoLink, Store.storeName
FROM Store
WHERE Store.storeName IN
(SELECT Sub.storeName
FROM Store Sub, SellsIngredient 
WHERE Sub.storeName = SellsIngredient.storeName
AND (ingredientName = 'ing3'
OR ingredientName = 'ing2')
); */
