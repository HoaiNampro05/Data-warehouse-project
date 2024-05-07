IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'OrderItemCustomerMonthCube')
BEGIN
    TRUNCATE TABLE OrderItemCustomerMonthCube;
    INSERT INTO OrderItemCustomerMonthCube
    SELECT top 9999999 f.*
    FROM (
        SELECT ti.Month,ti.year,fa.CustomerKey,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by ti.Month,ti.year,fa.CustomerKey,fa.ItemKey
    ) AS f
    ORDER BY f.Month,f.year,f.CustomerKey,f.ItemKey;
END
ELSE
BEGIN
    SELECT top 9999999 f.*
    INTO OrderItemCustomerMonthCube
    FROM (
        SELECT ti.Month,ti.year,fa.CustomerKey,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by ti.Month,ti.year,fa.CustomerKey,fa.ItemKey
    ) AS f
    ORDER BY f.Month,f.year,f.CustomerKey,f.ItemKey;
END

