use datawarehouse;


IF EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'OrderItemsCube'
)
BEGIN
	TRUNCATE TABLE OrderItemsCube;

    INSERT INTO OrderItemsCube (Descriptions,OrderedQuantity,OrderedCost,Profit)
    SELECT It.Descriptions, sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
	FROM FactOrderItems AS Ft_Od
	INNER JOIN DimItem AS It ON It.ItemKey = Ft_Od.ItemKey
	GROUP BY  It.ItemKey,It.Descriptions
END
ELSE
BEGIN
    SELECT f.Descriptions,f.OrderedQuantity,f.OrderedCost,f.Profit
	INTO OrderItemsCube
	FROM (
		SELECT It.Descriptions, sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
		FROM FactOrderItems AS Ft_Od
		INNER JOIN DimItem AS It ON It.ItemKey = Ft_Od.ItemKey
	GROUP BY  It.ItemKey,It.Descriptions
	) AS f;
END