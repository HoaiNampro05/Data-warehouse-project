IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'OrderItemCustomerYearCube')
BEGIN
    TRUNCATE TABLE OrderItemCustomerYearCube;
    INSERT INTO OrderItemCustomerYearCube
    SELECT top 9999999 f.*
    FROM (
        SELECT ti.year,fa.CustomerKey,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by ti.year,fa.CustomerKey,fa.ItemKey
    ) AS f
    ORDER BY f.year,f.CustomerKey,f.ItemKey;
END
ELSE
BEGIN
    SELECT top 9999999 f.*
    INTO OrderItemCustomerYearCube
    FROM (
        SELECT ti.year,fa.CustomerKey,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by ti.year,fa.CustomerKey,fa.ItemKey
    ) AS f
    ORDER BY f.year,f.CustomerKey,f.ItemKey;
END

