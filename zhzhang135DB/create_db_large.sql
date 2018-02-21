-- Some foreign keys added for this assignment, subject to change in future
DROP TABLE IF EXISTS Dish;
CREATE TABLE IF NOT EXISTS Dish(
	ID int NOT NULL AUTO_INCREMENT,
    dishName varchar(140),
    instructionsLink text,
    cookingTime time,
    photoLink text,
    weightPerServ float,
    styleName varchar(30),
		PRIMARY KEY (ID)
    )engine = InnoDB;

DROP TABLE IF EXISTS Ingredient;
CREATE TABLE IF NOT EXISTS Ingredient (
	ingredientName varchar(30) PRIMARY KEY,
    weightNeededPerServ float,
    energyPerServ int,
    isVegan boolean,
    isSeasoning boolean,
    photoLink text
    )engine = InnoDB;

DROP TABLE IF EXISTS Allergies;
CREATE TABLE IF NOT EXISTS Allergies (
	allergieName varchar(30) PRIMARY KEY,
    referenceLink text
    )engine = InnoDB;

DROP TABLE IF EXISTS Style;
CREATE TABLE IF NOT EXISTS Style (
	StyleName varchar(30) primary key,
    location varchar(140),
    backgroundLink text
    )engine = InnoDB;

DROP TABLE IF EXISTS CookingMethod;
CREATE TABLE IF NOT EXISTS CookingMethod(
	methodName varchar(30),
    instructionLink text,
    PRIMARY KEY(methodname)
    )engine = InnoDB;

DROP TABLE IF EXISTS Flavor;
CREATE TABLE IF NOT EXISTS Flavor (
	flavorName varchar(30),
    strength varchar(30),
    primary key(flavorName, strength)
    )engine = InnoDB;

DROP TABLE IF EXISTS KitchenWare;
CREATE TABLE IF NOT EXISTS KitchenWare(
	wareName varchar(30) primary key,
    photo text
    ) ENGINE = InnoDB;

DROP TABLE IF EXISTS Utensil;
CREATE TABLE IF NOT EXISTS Utensil (
	kitchenWareName varchar(30) primary key,
    photoLink text,
    foreign key(kitchenWareName) references KitchenWare(wareName)
    ON UPDATE CASCADE ON DELETE CASCADE
    ) ENGINE = InnoDB;

DROP TABLE IF EXISTS Appliance;
CREATE TABLE IF NOT EXISTS Appliance (
	kitchenWareName varchar(30) primary key,
    purpose varchar(50),
    foreign key(kitchenWareName) references KitchenWare(wareName)
    ON UPDATE CASCADE ON DELETE CASCADE
    ) ENGINE = InnoDB;

DROP TABLE IF EXISTS Containers;
CREATE TABLE IF NOT EXISTS Containers(
	kitchenWareName varchar(30) primary key,
    capacity int,
    foreign key(kitchenWareName) references KitchenWare(wareName)
    ON UPDATE CASCADE ON DELETE CASCADE
    )ENGINE = InnoDB;

DROP TABLE IF EXISTS Store;
CREATE TABLE IF NOT EXISTS Store(
	storeName varchar(30) primary key,
    brandPhotoLink text,
    location varchar(50),
    zip int
    ) ENGINE = innodb;

DROP TABLE IF EXISTS Isle;
CREATE TABLE IF NOT EXISTS Isle (
	isleNumber int,
    storeName varchar(30),
    categoryName varchar(30),
    PRIMARY KEY (isleNumber, storeName),
    foreign key (storeName) references Store(storeName)
    ON UPDATE CASCADE ON DELETE CASCADE
    )engine = InnoDB;

#Relations:
DROP TABLE IF EXISTS ByMethod;
CREATE TABLE IF NOT EXISTS ByMethod(
	dishID int,
    methodName varchar(30),
    sequence int,
    PRIMARY KEY (dishID, methodName),
    foreign key (dishID) references Dish(ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    foreign key (methodName) references CookingMethod(methodName)
    ON UPDATE CASCADE ON DELETE CASCADE
    )engine = InnoDB;

DROP TABLE IF EXISTS UseIngredient;
CREATE TABLE IF NOT EXISTS UseIngredient(
	dishID int,
    ingredientName varchar(30),
    primary key(dishID, ingredientName),
    foreign key(dishID) references Dish(ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    foreign key(ingredientName) references Ingredient(ingredientName)
    ON UPDATE CASCADE ON DELETE CASCADE
    )engine = InnoDB;

DROP TABLE IF EXISTS UseWare;
CREATE TABLE IF NOT EXISTS UseWare(
	dishID int,
    kitchenWareName varchar(30),
    PRIMARY KEY(dishID, kitchenWareName),
    foreign key(dishID) references Dish(ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
	foreign key(kitchenWareName) references KitchenWare(wareName)
	ON UPDATE CASCADE ON DELETE CASCADE
    )engine = InnoDB;

DROP TABLE IF EXISTS ContainsAllergy;
CREATE TABLE IF NOT EXISTS ContainsAllergy (
	dishID INT,
    allergiesName VARCHAR(30),
    PRIMARY KEY(dishID, allergiesName),
    foreign KEY(dishID) references Dish(ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    foreign KEY(allergiesName) references Allergies(allergieName)
    ON UPDATE CASCADE ON DELETE CASCADE
    )engine = InnoDB;

DROP TABLE IF EXISTS SellsIngredient;
CREATE TABLE IF NOT EXISTS SellsIngredient (
	ingredientName varchar(30),
    isleNumber int,
    storeName varchar(30),
    price float,
    weightPerPack float,
    PRIMARY KEY(ingredientName, isleNumber, storeName),
    foreign KEY(ingredientName) references Ingredient(ingredientName)
    ON UPDATE CASCADE ON DELETE CASCADE,
    foreign KEY(isleNumber) references Isle(isleNumber)
    ON UPDATE CASCADE ON DELETE CASCADE,
    foreign KEY(storeName) references Isle(storeName)
    ON UPDATE CASCADE ON DELETE CASCADE
    )engine = InnoDB;

DROP TABLE IF EXISTS SellsKitchenWare;
CREATE TABLE IF NOT EXISTS SellsKitchenWare (
		kitchenWareName VARCHAR(30),
    isleNumber int,
    storeName varchar(30),
    price float,
    PRIMARY KEY(kitchenWareName, isleNumber, storeName),
		foreign KEY(kitchenWareName) references KitchenWare(wareName)
		ON UPDATE CASCADE ON DELETE CASCADE,
    foreign KEY(isleNumber) references Isle(isleNumber)
    ON UPDATE CASCADE ON DELETE CASCADE,
    foreign KEY(storeName) references Isle(storeName)
    ON UPDATE CASCADE ON DELETE CASCADE
    )engine = InnoDB;

DROP TABLE IF EXISTS DishTaste;
CREATE TABLE IF NOT EXISTS DishTaste (
	dishID int,
    flavorName varchar(30),
    strength varchar(30),
    PRIMARY KEY (dishID, flavorName, strength),
	foreign key(dishID) references Dish(ID),
	foreign key(flavorName, strength) references Flavor(flavorName, strength)
	ON UPDATE CASCADE ON DELETE CASCADE
-- 	foreign key(strength) references Flavor(strength)
	)engine = InnoDB;

DROP TABLE IF EXISTS IngredientTaste;
CREATE TABLE IF NOT EXISTS IngredientTaste (
	ingredientName varchar(30),
    flavorName varchar(30),
    strength varchar(30),
    PRIMARY KEY(ingredientName, flavorName, strength),
	foreign KEY(ingredientName) references Ingredient(ingredientName)
	ON UPDATE CASCADE ON DELETE CASCADE,
	foreign key(flavorName, strength) references Flavor(flavorName,strength)
	ON UPDATE CASCADE ON DELETE CASCADE
--  foreign key(strength) references Flavor(strength)
--  dish or an ingredient could have several tastes combined
    )engine = InnoDB;
