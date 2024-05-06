use datawarehouse;


IF EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'OrderQuarterCube'
)
BEGIN
	TRUNCATE TABLE OrderQuarterCube;

    INSERT INTO OrderQuarterCube (Quarter,Year,OrderedQuantity,OrderedCost,Profit)
    SELECT T.Quarter, T.Year, sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
	FROM FactOrderItems AS Ft_Od
	INNER JOIN DimTime AS T ON T.TimeKey = Ft_Od.TimeKey
	GROUP BY T.Quarter, T.Year
END
ELSE
BEGIN
    SELECT f.Quarter, f.Year, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderQuarterCube
	FROM (
		SELECT T.Quarter, T.Year, sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
		FROM FactOrderItems AS Ft_Od
		INNER JOIN DimTime AS T ON T.TimeKey = Ft_Od.TimeKey
		GROUP BY T.Quarter, T.Year
	) AS f;
END