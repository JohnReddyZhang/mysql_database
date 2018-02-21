-- Test for procedure Price More Than
CALL PriceMoreThan(20);

-- First will show result, second raises error
CALL usesIngredient("Black Pepper");
CALL usesIngredient("what");

-- First will show when strength is null, second not null, and third for exception
CALL SearchForDishTaste("cheesy", NULL);
CALL SearchForDishTaste("cheesy", "mild");
CALL SearchForDishTaste("what", NULL);
	
	
-- first checks that TI does not sell Frying Pan,
-- Then run procedure,
-- Then shows it sells Frying Pan.
SELECT * FROM SellsKitchenWare WHERE kitchenWareName = "Frying Pan";
CALL TreasureIslandSellsThis('Frying Pan', 30.4);
SELECT * FROM SellsKitchenWare WHERE kitchenWareName = "Frying Pan";

-- Test for Add ingredient
SELECT * FROM Ingredient WHERE ingredientName = "New One";
CALL AddIngredient("New One", 1, 1);
SELECT * FROM Ingredient WHERE ingredientName = "New One";