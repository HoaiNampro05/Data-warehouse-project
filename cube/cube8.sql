IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'OrderItemDayCube')
BEGIN
    TRUNCATE TABLE OrderItemDayCube;
    INSERT INTO OrderItemDayCube
    SELECT top 9999999 f.*
    FROM (
        SELECT ti.TimeKey,ti.day,ti.quarter,ti.year,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by ti.TimeKey,ti.day,ti.quarter,ti.year,fa.ItemKey
    ) AS f
    ORDER BY f.TimeKey,f.day,f.quarter,f.year,f.ItemKey
END
ELSE
BEGIN
    SELECT top 9999999 f.*
    INTO OrderItemDayCube
    FROM (
        SELECT ti.TimeKey,ti.day,ti.quarter,ti.year,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by ti.TimeKey,ti.day,ti.quarter,ti.year,fa.ItemKey
    ) AS f
    ORDER BY f.TimeKey,f.day,f.quarter,f.year,f.ItemKey
END

