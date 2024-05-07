IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'OrderItemCustomerOfCityQuarterCube')
BEGIN
    TRUNCATE TABLE OrderItemCustomerOfCityQuarterCube;
    INSERT INTO OrderItemCustomerOfCityQuarterCube
    SELECT top 9999999 f.*
    FROM (
        SELECT ti.Quarter,ti.year, re.CityKey,re.CityName,fa.ItemKey, sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimRepresentativeOffice re,DimCustomer cus,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey and cus.CustomerKey = fa.CustomerKey and cus.CityKey = re.CityKey
        group by ti.Quarter,ti.year, re.CityKey,re.CityName,fa.ItemKey
    ) AS f
    ORDER BY f.Quarter,f.year, f.CityKey,f.CityName,f.ItemKey;
END
ELSE
BEGIN
    SELECT top 9999999 f.*
    INTO OrderItemCustomerOfCityQuarterCube
    FROM (
        SELECT ti.Quarter,ti.year, re.CityKey,re.CityName,fa.ItemKey, sum(fa.OrderedQuantity) as 'OrderedQuantity',sum(fa.OrderedCost) as 'OrderedCost',
        sum(fa.Profit) as 'Profit'
        FROM FactOrderItems fa,DimRepresentativeOffice re,DimCustomer cus,DimTime ti
        WHERE fa.TimeKey = ti.TimeKey and cus.CustomerKey = fa.CustomerKey and cus.CityKey = re.CityKey 
        group by ti.Quarter,ti.year, re.CityKey,re.CityName,fa.ItemKey
    ) AS f
    ORDER BY f.Quarter,f.year, f.CityKey,f.CityName,f.ItemKey;
END
