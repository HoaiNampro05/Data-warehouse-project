use datawarehouse;

IF EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'StoredItemOfStateDayCube'
)
BEGIN
	TRUNCATE TABLE StoredItemOfCityDayCube;

    INSERT INTO StoredItemOfStateDayCube (Day, Month, Year, Descriptions, State,Quantity)
    SELECT T.Day, T.Month, T.Year, It.Descriptions,Ct.State,sum(Ft_St.Quantity) as Quantity
	FROM FactStoreItems AS Ft_St
	INNER JOIN DimTime AS T ON T.TimeKey = Ft_St.TimeKey
	INNER JOIN DimItem AS It ON It.ItemKey = Ft_St.ItemKey
	INNER JOIN DimStore AS St ON St.StoreKey = Ft_St.StoreKey
	INNER JOIN DimRepresentativeOffice AS Ct ON Ct.CityKey = St.CityKey
	GROUP BY T.Day, T.Month, T.Year,Ct.State, It.Descriptions
END
ELSE
BEGIN
    SELECT f.Day, f.Month, f.Year, f.Descriptions, f.State,f.Quantity
	INTO StoredItemOfStateDayCube
	FROM (
		SELECT T.Day, T.Month, T.Year, It.Descriptions,Ct.State,sum(Ft_St.Quantity) as Quantity
		FROM FactStoreItems AS Ft_St
		INNER JOIN DimTime AS T ON T.TimeKey = Ft_St.TimeKey
		INNER JOIN DimItem AS It ON It.ItemKey = Ft_St.ItemKey
		INNER JOIN DimStore AS St ON St.StoreKey = Ft_St.StoreKey
		INNER JOIN DimRepresentativeOffice AS Ct ON Ct.CityKey = St.CityKey
		GROUP BY T.Day, T.Month, T.Year,Ct.State, It.Descriptions
	) AS f;
END