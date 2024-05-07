IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'OrderItemCustomerQuarterCube')
BEGIN
    TRUNCATE TABLE OrderItemCustomerQuarterCube;
    INSERT INTO OrderItemCustomerQuarterCube
    SELECT top 9999999 f.*
    FROM (
        SELECT ti.Quarter,ti.year,fa.CustomerKey,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by ti.Quarter,ti.year,fa.CustomerKey,fa.ItemKey
    ) AS f
    ORDER BY f.Quarter,f.year,f.CustomerKey,f.ItemKey;
END
ELSE
BEGIN
    SELECT top 9999999 f.*
    INTO OrderItemCustomerQuarterCube
    FROM (
        SELECT ti.Quarter,ti.year,fa.CustomerKey,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by ti.Quarter,ti.year,fa.CustomerKey,fa.ItemKey
    ) AS f
    ORDER BY f.Quarter,f.year,f.CustomerKey,f.ItemKey;
END


