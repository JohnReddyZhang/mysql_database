-- If a dish features "homestyle", then the dish is not inserted into Dish table
DROP TRIGGER IF EXISTS NoMoreHomeStyle;
DELIMITER |
CREATE TRIGGER NoMoreHomeStyle
BEFORE INSERT ON Dish
FOR EACH ROW
	BEGIN
		IF (NEW.styleName) = "Homestyle" THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No Homestyle!";
		END IF;
	END|
DELIMITER ;

-- If a dish is cajun, it is added into Cajuncollection
DROP TABLE IF EXISTS CajunCollection;
CREATE TABLE CajunCollection(
	ID int NOT NULL AUTO_INCREMENT,
	dishName varChar(140),
	instructionsLink text,
	cookingTime Time,
	PRIMARY KEY (ID)
);
DROP TRIGGER IF EXISTS AddToCajunCollection;
DELIMITER |
CREATE TRIGGER AddToCajunCollection
AFTER INSERT ON Dish
FOR EACH ROW
	BEGIN
		IF (NEW.styleName) = "Cajun" THEN
			INSERT INTO CajunCollection(dishName, instructionsLink, cookingTime)
				VALUES (NEW.dishName, NEW.instructionsLink, NEW.cookingTime);
		END IF;
	END |
DELIMITER ;


-- If a style update happened in Dish, log it into DishLog
DROP TABLE IF EXISTS DishUpdates;
CREATE TABLE DishUpdates (
	dishName varChar(140),
	oldStyle VARCHAR(30),
	newStyle VarChar(30),
	userMakingChange varChar(50),
	dateChanged datetime
);
DROP TRIGGER IF EXISTS LogDishUpdates;
DELIMITER |
CREATE TRIGGER LogDishUpdates
AFTER UPDATE ON Dish
FOR EACH ROW
	BEGIN
		IF (NEW.styleName <> OLD.styleName) THEN
			INSERT IGNORE INTO DishUpdates
				VALUES (NEW.dishName, OLD.styleName, NEW.styleName, CURRENT_USER(), NOW());
		END IF;
	END |
DELIMITER ;
SHOW TRIGGERS;