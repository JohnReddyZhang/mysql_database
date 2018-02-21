CREATE PROCEDURE AddIngredient(IN addIngredientName VARCHAR(30), IN setIsVegan TINYINT, IN setIsSeasoning TINYINT)
  BEGIN
	DECLARE avgEnergy INT;
	DECLARE avgWeight INT;
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
END;

