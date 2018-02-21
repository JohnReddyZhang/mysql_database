load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_style.txt"
REPLACE INTO TABLE Style
FIELDS TERMINATED BY '|'
(`styleName`, `location`, `backgroundLink`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_dish.txt"
REPLACE INTO TABLE Dish
FIELDS TERMINATED BY '|'
(`dishName`, `instructionsLink`, `cookingTime`, `photoLink`, `weightPerServ`, `styleName`)
SET ID = NULL;

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_ingredients.txt"
REPLACE INTO TABLE Ingredient
FIELDS TERMINATED BY '|'
(`ingredientName`, `weightNeededPerServ`, `energyPerServ`, `isVegan`, `isSeasoning`, `photoLink`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_allergies.txt"
REPLACE INTO TABLE Allergies
FIELDS TERMINATED BY '|'
(allergieName,referenceLink);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_cookingmethod.txt"
REPLACE INTO TABLE CookingMethod
FIELDS TERMINATED BY '|'
(`methodName`, `instructionLink`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_flavor.txt"
REPLACE INTO TABLE Flavor
FIELDS TERMINATED BY '|'
(`flavorName`, `strength`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_kitchenware.txt"
REPLACE INTO TABLE KitchenWare
FIELDS TERMINATED BY '|'
(`wareName`, `photo`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_kitchenware_utensil.txt"
REPLACE INTO TABLE Utensil
FIELDS TERMINATED BY '|'
(`kitchenWareName`, `photoLink`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_kitchenware_appliance.txt"
REPLACE INTO TABLE Appliance
FIELDS TERMINATED BY '|'
(`kitchenWareName`, `purpose`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_kitchenware_containers.txt"
REPLACE INTO TABLE Containers
FIELDS TERMINATED BY '|'
(`kitchenWareName`, `capacity`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_store.txt"
REPLACE INTO TABLE Store
FIELDS TERMINATED BY '|'
(`storeName`, `brandPhotoLink`, `location`,`zip`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/entity_store_isle.txt"
REPLACE INTO TABLE Isle
FIELDS TERMINATED BY '|'
(`isleNumber`, `storeName`, `categoryName`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/relation_bymethod.txt"
REPLACE INTO TABLE ByMethod
FIELDS TERMINATED BY '|'
(`dishID`, `methodName`, `sequence`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/relation_useingredient.txt"
REPLACE INTO TABLE UseIngredient
FIELDS TERMINATED BY '|'
(`dishID`, `ingredientName`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/relation_useware.txt"
REPLACE INTO TABLE UseWare
FIELDS TERMINATED BY '|'
(`dishID`, `kitchenWareName`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/relation_containsallergy.txt"
REPLACE INTO TABLE ContainsAllergy
FIELDS TERMINATED BY '|'
(`dishID`, `allergiesName`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/relation_sellsingredient.txt"
REPLACE INTO TABLE SellsIngredient
FIELDS TERMINATED BY '|'
(`ingredientName`, `isleNumber`, `storeName`, `price`, `weightPerPack`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/relation_sellskitchenware.txt"
REPLACE INTO TABLE SellsKitchenWare
FIELDS TERMINATED BY '|'
(`kitchenWareName`, `isleNumber`, `storeName`, `price`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/relation_dishtaste.txt"
REPLACE INTO TABLE DishTaste
FIELDS TERMINATED BY '|'
(`dishID`, `flavorName`, `strength`);

load data
LOCAL INFILE "Users/JohnReddy/Documents/Database/zhzhang135DBlocalTestRun/data/relation_ingredienttaste.txt"
REPLACE INTO TABLE IngredientTaste
FIELDS TERMINATED BY '|'
(`ingredientName`, `flavorName`, `strength`);
