use datawarehouse;

IF EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'StoredItemOfDayCube'
)
BEGIN
	TRUNCATE TABLE StoredItemOfDayCube;

    INSERT INTO StoredItemOfDayCube (Day, Month, Year, Descriptions,ItemQuantityOfAll)
    SELECT T.Day, T.Month, T.Year, It.Descriptions,sum(Ft_St.Quantity) as ItemQuantityOfAll
	FROM FactStoreItems AS Ft_St
	INNER JOIN DimTime AS T ON T.TimeKey = Ft_St.TimeKey
	INNER JOIN DimItem AS It ON It.ItemKey = Ft_St.ItemKey
	GROUP BY T.Day, T.Month, T.Year,It.ItemKey, It.Descriptions
END
ELSE
BEGIN
    SELECT f.Day, f.Month, f.Year, f.Descriptions,f.ItemQuantityOfAll
	INTO StoredItemOfDayCube
	FROM (
		SELECT T.Day, T.Month, T.Year, It.Descriptions,sum(Ft_St.Quantity) as ItemQuantityOfAll
		FROM FactStoreItems AS Ft_St
		INNER JOIN DimTime AS T ON T.TimeKey = Ft_St.TimeKey
		INNER JOIN DimItem AS It ON It.ItemKey = Ft_St.ItemKey
		GROUP BY T.Day, T.Month, T.Year,It.ItemKey,It.Descriptions
	) AS f;
END