IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'OrderItemQuarterCube')
BEGIN
    TRUNCATE TABLE OrderItemQuarterCube;
    INSERT INTO OrderItemQuarterCube
    SELECT top 9999999 f.*
    FROM (
        SELECT  ti.quarter,ti.year,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by  ti.quarter,ti.year,fa.ItemKey
    ) AS f
    ORDER BY f.quarter,f.year,f.ItemKey
END
ELSE
BEGIN
    SELECT top 9999999 f.*
    INTO OrderItemQuarterCube
    FROM (
        SELECT  ti.quarter,ti.year,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by  ti.quarter,ti.year,fa.ItemKey
    ) AS f
    ORDER BY f.quarter,f.year,f.ItemKey
END
