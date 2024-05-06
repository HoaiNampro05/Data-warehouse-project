use datawarehouse;

IF EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'StoredItemOfStoreDayCube'
)
BEGIN
	TRUNCATE TABLE StoredItemOfStoreDayCube;

    INSERT INTO StoredItemOfStoreDayCube (Day, Month, Year, Descriptions, StoreKey, Quantity)
    SELECT T.Day, T.Month, T.Year, It.Descriptions, Ft_St.StoreKey, Ft_St.Quantity
    FROM FactStoreItems AS Ft_St
    INNER JOIN DimTime AS T ON T.TimeKey = Ft_St.TimeKey
    INNER JOIN DimItem AS It ON It.ItemKey = Ft_St.ItemKey
    INNER JOIN DimStore AS St ON St.StoreKey = Ft_St.StoreKey;
END
ELSE
BEGIN
    SELECT f.Day, f.Month, f.Year, f.Descriptions, f.StoreKey,f.Quantity
	INTO StoredItemOfStoreDayCube
	FROM (
		SELECT T.Day, T.Month, T.Year, It.Descriptions,Ft_St.StoreKey, Ft_St.Quantity
		FROM FactStoreItems AS Ft_St
		INNER JOIN DimTime AS T ON T.TimeKey = Ft_St.TimeKey
		INNER JOIN DimItem AS It ON It.ItemKey = Ft_St.ItemKey
		INNER JOIN DimStore AS St ON St.StoreKey = Ft_St.StoreKey
	) AS f;
END