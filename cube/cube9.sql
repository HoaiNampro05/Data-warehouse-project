IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'OrderItemMonthCube')
BEGIN
    TRUNCATE TABLE OrderItemMonthCube;
    INSERT INTO OrderItemMonthCube
    SELECT top 9999999 f.*
    FROM (
        SELECT  ti.month,ti.year,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by  ti.month,ti.year,fa.ItemKey
    ) AS f
    ORDER BY f.month,f.year,f.ItemKey
END
ELSE
BEGIN
    SELECT top 9999999 f.*
    INTO OrderItemMonthCube
    FROM (
        SELECT  ti.month,ti.year,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by  ti.month,ti.year,fa.ItemKey
    ) AS f
    ORDER BY f.month,f.year,f.ItemKey
END

