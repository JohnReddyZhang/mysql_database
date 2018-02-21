-- Activates trigger NoMoreHomeStyle
INSERT INTO Dish(dishName, instructionsLink, cookingTime, photoLink, weightPerServ, styleName) 
VALUES ("NewDish","Link","00:30:30","Photo","20.4","Homestyle");

-- Show Result: Should return EMPTY because NewDish was not added.
SELECT * FROM Dish WHERE dishName = "NewDish";

-- Not Activate trigger NoMoreHomeStyle
INSERT INTO Dish(dishName, instructionsLink, cookingTime, photoLink, weightPerServ, styleName) 
VALUES ("BeijingDish","Link","00:30:30","Photo","20.4","Chinese Beijing");

-- Show Result: should return the inserted value because trigger was not triggered
SELECT * FROM Dish WHERE dishName = "BeijingDish";

-- Activates trigger AddToCajunCollection
INSERT INTO Dish(dishName, instructionsLink, cookingTime, photoLink, weightPerServ, styleName) 
VALUES ("NewCajunDish","Link","00:30:30","Photo","20.4","Cajun");

-- Show Result:
SELECT * FROM CajunCollection WHERE dishName = "NewCajunDish";

-- Not Activate trigger AddToCajunCollection
INSERT INTO Dish(dishName, instructionsLink, cookingTime, photoLink, weightPerServ, styleName) 
VALUES ("SichuanDish","Link","00:30:30","Photo","20.4","Chinese SzeChuan");

-- Show Result: SichuanDish should not appear because trigger not triggered
SELECT * FROM CajunCollection;

-- Activates trigger LogDishUpdates
UPDATE Dish SET styleName = "Cajun" WHERE dishName = "Steamed Brownrice";
UPDATE Dish SET styleName = "New England" WHERE dishName = "Healthy Salad";

-- Show Results: Show all results above
SELECT * FROM DishUpdates;

-- Not Activate trigger LogDishUpdates
INSERT INTO Dish(dishName, instructionsLink, cookingTime, photoLink, weightPerServ, styleName) 
VALUES ("NewCajunDish","Link","00:30:30","Photo","20.4","Cajun");
-- (Run the insert first if you did not run "Activates trigger AddToCajunCollection" first
UPDATE Dish SET dishName = "CAAAAAjun" WHERE dishName = "NewCajunDish";

-- Show Results: should be EMPTY because CAAAAAjun was not added to the table due to no changes in styleName
SELECT * FROM DishUpdates WHERE dishName = "CAAAAAjun";