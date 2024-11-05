DECLARE @counter INT =20;
DECLARE @result VARCHAR(20)= REPLICATE('* ',20);

WHILE @counter>0
BEGIN
    SELECT REPLICATE('* ',@counter);
    SET @counter =  @counter-1
END;
