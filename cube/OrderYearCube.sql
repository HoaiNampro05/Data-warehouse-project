use datawarehouse;


IF EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'OrderYearCube'
)
BEGIN
	TRUNCATE TABLE OrderYearCube;

    INSERT INTO OrderYearCube (Year,OrderedQuantity,OrderedCost,Profit)
    SELECT T.Year, sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
	FROM FactOrderItems AS Ft_Od
	INNER JOIN DimTime AS T ON T.TimeKey = Ft_Od.TimeKey
	GROUP BY  T.Year
END
ELSE
BEGIN
    SELECT f.Year, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderYearCube
	FROM (
		SELECT T.Year, sum(Ft_Od.OrderedQuantity) as OrderedQuantity, sum(Ft_Od.OrderedCost) as OrderedCost, sum(Ft_Od.Profit) as Profit
		FROM FactOrderItems AS Ft_Od
		INNER JOIN DimTime AS T ON T.TimeKey = Ft_Od.TimeKey
		GROUP BY T.Year
	) AS f;
END