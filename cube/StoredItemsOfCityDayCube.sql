use datawarehouse;

IF EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'StoredItemOfCityDayCube'
)
BEGIN
	TRUNCATE TABLE StoredItemOfCityDayCube;

    INSERT INTO StoredItemOfCityDayCube (Day, Month, Year, Descriptions,CityName,OfficeAddress,Quantity)
    SELECT T.Day, T.Month, T.Year, It.Descriptions,Ct.CityName,Ct.OfficeAddress,sum(Ft_St.Quantity) as Quantity
	FROM FactStoreItems AS Ft_St
	INNER JOIN DimTime AS T ON T.TimeKey = Ft_St.TimeKey
	INNER JOIN DimItem AS It ON It.ItemKey = Ft_St.ItemKey
	INNER JOIN DimStore AS St ON St.StoreKey = Ft_St.StoreKey
	INNER JOIN DimRepresentativeOffice AS Ct ON Ct.CityKey = St.CityKey
	GROUP BY T.Day, T.Month, T.Year,Ct.CityName,Ct.OfficeAddress, It.Descriptions
END
ELSE
BEGIN
    SELECT f.Day, f.Month, f.Year, f.Descriptions, f.CityName,f.OfficeAddress,f.Quantity
	INTO StoredItemOfCityDayCube
	FROM (
		SELECT T.Day, T.Month, T.Year, It.Descriptions,Ct.CityName,Ct.OfficeAddress,sum(Ft_St.Quantity) as Quantity
		FROM FactStoreItems AS Ft_St
		INNER JOIN DimTime AS T ON T.TimeKey = Ft_St.TimeKey
		INNER JOIN DimItem AS It ON It.ItemKey = Ft_St.ItemKey
		INNER JOIN DimStore AS St ON St.StoreKey = Ft_St.StoreKey
		INNER JOIN DimRepresentativeOffice AS Ct ON Ct.CityKey = St.CityKey
		GROUP BY T.Day, T.Month, T.Year,Ct.CityName,Ct.OfficeAddress, It.Descriptions
	) AS f;
END