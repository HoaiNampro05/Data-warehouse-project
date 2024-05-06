use datawarehouse;


IF EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'OrderCustomerOfStateCube'
)
BEGIN
	TRUNCATE TABLE OrderCustomerOfStateCube;

    INSERT INTO OrderCustomerOfStateCube (State,OrderedQuantity,OrderedCost,Profit)
	SELECT RO.State,sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
	FROM FactOrderItems AS Ft_Od
	INNER JOIN DimCustomer AS Cu ON Cu.CustomerKey = Ft_Od.CustomerKey
	INNER JOIN DimRepresentativeOffice AS RO ON RO.CityKey = Cu.CityKey
	GROUP BY  RO.State
END
ELSE
BEGIN
    SELECT f.State,f.OrderedQuantity,f.OrderedCost,f.Profit
	INTO OrderCustomerOfStateCube
	FROM (
		SELECT RO.State,sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
		FROM FactOrderItems AS Ft_Od
		INNER JOIN DimCustomer AS Cu ON Cu.CustomerKey = Ft_Od.CustomerKey
		INNER JOIN DimRepresentativeOffice AS RO ON RO.CityKey = Cu.CityKey
		GROUP BY  RO.State
	) AS f;
END