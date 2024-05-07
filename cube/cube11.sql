IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'OrderItemYearCube')
BEGIN
    TRUNCATE TABLE OrderItemYearCube;
    INSERT INTO OrderItemYearCube
    SELECT top 9999999 f.*
    FROM (
        SELECT  ti.year,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by  ti.year,fa.ItemKey
    ) AS f
    ORDER BY f.year,f.ItemKey
END
ELSE
BEGIN
    SELECT top 9999999 f.*
    INTO OrderItemYearCube
    FROM (
        SELECT  ti.year,fa.ItemKey,sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey
        group by ti.year,fa.ItemKey
    ) AS f
    ORDER BY f.year,f.ItemKey
END

select *from OrderItemYearCube