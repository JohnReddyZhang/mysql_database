CREATE PROCEDURE TreasureIslandSellsThis(IN addKitchenWareName VARCHAR(30), IN addPrice FLOAT)
  BEGIN
	DECLARE addStoreName  VARCHAR(30);
	SET addStoreName = "Treasure Island";
	IF addKitchenWareName NOT IN (SELECT kitchenWareName 
									FROM SellsKitchenWare 
									WHERE storeName = addStoreName)
	THEN
		IF addKitchenWareName NOT IN (SELECT wareName
										FROM KitchenWare)
		THEN
			INSERT INTO KitchenWare 
				VALUES (addKitchenWareName, NULL);
		END IF;
		INSERT INTO SellsKitchenWare 
			VALUES (addKitchenWareName, 1, addStoreName, addPrice);
	END IF;
END;
