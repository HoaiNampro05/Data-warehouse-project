use datawarehouse;


IF EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'OrderCustomerCube'
)
BEGIN
	TRUNCATE TABLE OrderCustomerCube;

    INSERT INTO OrderCustomerCube (CustomerName,OrderedQuantity,OrderedCost,Profit)
    SELECT Cu.CustomerName, sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
	FROM FactOrderItems AS Ft_Od
	INNER JOIN DimCustomer AS Cu ON Cu.CustomerKey = Ft_Od.CustomerKey
	GROUP BY  Cu.CustomerKey, Cu.CustomerName
END
ELSE
BEGIN
    SELECT f.CustomerName,f.OrderedQuantity,f.OrderedCost,f.Profit
	INTO OrderCustomerCube
	FROM (
		SELECT Cu.CustomerName, sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
		FROM FactOrderItems AS Ft_Od
		INNER JOIN DimCustomer AS Cu ON Cu.CustomerKey = Ft_Od.CustomerKey
		GROUP BY  Cu.CustomerKey, Cu.CustomerName
	) AS f;
END