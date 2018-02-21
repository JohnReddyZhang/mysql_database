INSERT INTO Dish VALUES (16,'Northeastern Style Stew of Potato, Eggplant and Green Pepper','linkk16','00:30:00','pthotoDiSanXian',50,'style1');

INSERT INTO Ingredient 
VALUES
('Tomato',5,20,1,0,'TomatoPhoto'),
('Szechuan Pepper',0.3,5,1,1,'sichuanpepperPhoto');

DROP TABLE IF EXISTS DailyBargain;
CREATE TABLE DailyBargain(
	StuffName varchar(30) PRIMARY KEY,
	price float,
	store varchar(30));

INSERT INTO DailyBargain
(SELECT ingredientName StuffName, price, storeName store
FROM SellsIngredient
WHERE price < 22);

INSERT INTO DailyBargain(
SELECT kitchenWareName, price, storeName
FROM SellsKitchenWare
WHERE price < 27);

#prices more than 25 is not a bargain and we decide that we don't like stroe 5 at all.
DELETE FROM DailyBargain
WHERE price > 25
OR store = 'store5';

CREATE TABLE IF NOT EXISTS SafeIngredient LIKE Ingredient;
INSERT SafeIngredient (SELECT * FROM Ingredient);
#ingredients with '4' in its name are dangerous ingredients.
DELETE FROM SafeIngredient WHERE ingredientName LIKE '%4%';

#ingredients in SafeIngredient are now all vegan because of some magic.
UPDATE SafeIngredient
SET isVegan = 1
WHERE isVegan = 0;

#Treasure Island now sells all things in DailyBargain that are ingredients
UPDATE DailyBargain
SET store = 'Treasure Island'
WHERE StuffName LIKE "%ing%";