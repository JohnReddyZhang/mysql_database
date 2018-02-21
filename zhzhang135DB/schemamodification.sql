ALTER TABLE DailyBargain
ADD oldPrice float DEFAULT NULL;

ALTER TABLE DailyBargain
MODIFY COLUMN oldPrice int DEFAULT NULL;

#I don't even know what am I doing here but it seems fun
ALTER TABLE DailyBargain
CHANGE oldPrice Pier varchar(20);

ALTER TABLE DailyBargain
DROP Pier;