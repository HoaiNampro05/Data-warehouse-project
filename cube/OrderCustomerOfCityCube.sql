use datawarehouse;


IF EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'OrderCustomerOfCityCube'
)
BEGIN
	TRUNCATE TABLE OrderCustomerOfCityCube;

    INSERT INTO OrderCustomerOfCityCube (CityName,OfficeAddress,OrderedQuantity,OrderedCost,Profit)
    SELECT RO.CityName, RO.OfficeAddress,sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
	FROM FactOrderItems AS Ft_Od
	INNER JOIN DimCustomer AS Cu ON Cu.CustomerKey = Ft_Od.CustomerKey
	INNER JOIN DimRepresentativeOffice AS RO ON RO.CityKey = Cu.CityKey
	GROUP BY  RO.CityName,RO.OfficeAddress
END
ELSE
BEGIN
    SELECT f.CityName,f.OfficeAddress,f.OrderedQuantity,f.OrderedCost,f.Profit
	INTO OrderCustomerOfCityCube
	FROM (
		SELECT RO.CityName, RO.OfficeAddress,sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
		FROM FactOrderItems AS Ft_Od
		INNER JOIN DimCustomer AS Cu ON Cu.CustomerKey = Ft_Od.CustomerKey
		INNER JOIN DimRepresentativeOffice AS RO ON RO.CityKey = Cu.CityKey
		GROUP BY  RO.CityName,RO.OfficeAddress
	) AS f;
END