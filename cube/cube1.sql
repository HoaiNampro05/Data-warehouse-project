IF OBJECT_ID('OrderItemCustomerOfCityYearCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderItemCustomerOfCityYearCube;
	SELECT * FROM OrderItemCustomerOfCityYearCube;
	INSERT INTO OrderItemCustomerOfCityYearCube
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.Year, f.CityKey, f.CityName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select i.ItemKey, i.Descriptions,t.Year, ct.CityKey, ct.CityName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions,t.Year, ct.CityKey, ct.CityName, ct.State
	) AS f order by f.Year;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.Year, f.CityKey, f.CityName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderItemCustomerOfCityYearCube
	FROM (
		Select i.ItemKey, i.Descriptions,t.Year, ct.CityKey, ct.CityName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions,t.Year,  ct.CityKey, ct.CityName, ct.State
	) AS f order by f.Year;
    PRINT 'Bang khong ton tai'
END



IF OBJECT_ID('OrderItemCustomerOfStateDayCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderItemCustomerOfStateDayCube;
	SELECT * FROM OrderItemCustomerOfStateDayCube;
	INSERT INTO OrderItemCustomerOfStateDayCube
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.Day, f.Month, f.Year, f.CustomerKey, f.CustomerName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select i.ItemKey, i.Descriptions,t.Day, t.Month, t.Year, cus.CustomerKey, cus.CustomerName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions,t.Day, t.Month, t.Year, cus.CustomerKey, cus.CustomerName, ct.State
	) AS f order by f.Year, f.Month, f.Day;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.Day, f.Month, f.Year, f.CustomerKey, f.CustomerName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderItemCustomerOfStateDayCube
	FROM (
		Select i.ItemKey, i.Descriptions,t.Day, t.Month, t.Year, cus.CustomerKey, cus.CustomerName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions,t.Day, t.Month, t.Year, cus.CustomerKey, cus.CustomerName, ct.State
	) AS f order by f.Year, f.Month, f.Day;
    PRINT 'Bang khong ton tai'
END



IF OBJECT_ID('OrderItemCustomerOfStateMonthCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderItemCustomerOfStateMonthCube;
	SELECT * FROM OrderItemCustomerOfStateMonthCube;
	INSERT INTO OrderItemCustomerOfStateMonthCube
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.Month, f.Year, f.CustomerKey, f.CustomerName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select i.ItemKey, i.Descriptions, t.Month, t.Year, cus.CustomerKey, cus.CustomerName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions, t.Month, t.Year, cus.CustomerKey, cus.CustomerName, ct.State
	) AS f order by f.Year, f.Month;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.Month, f.Year, f.CustomerKey, f.CustomerName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderItemCustomerOfStateMonthCube
	FROM (
		Select i.ItemKey, i.Descriptions, t.Month, t.Year, cus.CustomerKey, cus.CustomerName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions, t.Month, t.Year, cus.CustomerKey, cus.CustomerName, ct.State
	) AS f order by f.Year, f.Month;
    PRINT 'Bang khong ton tai'
END


IF OBJECT_ID('OrderItemCustomerOfStateQuarterCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderItemCustomerOfStateQuarterCube;
	SELECT * FROM OrderItemCustomerOfStateQuarterCube;
	INSERT INTO OrderItemCustomerOfStateQuarterCube
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.Quarter, f.Year, f.CustomerKey, f.CustomerName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select i.ItemKey, i.Descriptions, t.Quarter, t.Year, cus.CustomerKey, cus.CustomerName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions, t.Quarter, t.Year, cus.CustomerKey, cus.CustomerName, ct.State
	) AS f order by f.Year, f.Quarter;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.Quarter, f.Year, f.CustomerKey, f.CustomerName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderItemCustomerOfStateQuarterCube
	FROM (
		Select i.ItemKey, i.Descriptions, t.Quarter, t.Year, cus.CustomerKey, cus.CustomerName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions, t.Quarter, t.Year, cus.CustomerKey, cus.CustomerName, ct.State
	) AS f order by f.Year, f.Quarter;
    PRINT 'Bang khong ton tai'
END



IF OBJECT_ID('OrderItemCustomerOfStateYearCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderItemCustomerOfStateYearCube;
	SELECT * FROM OrderItemCustomerOfStateYearCube;
	INSERT INTO OrderItemCustomerOfStateYearCube
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.Year, f.CustomerKey, f.CustomerName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select i.ItemKey, i.Descriptions, t.Year, cus.CustomerKey, cus.CustomerName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions, t.Year, cus.CustomerKey, cus.CustomerName, ct.State
	) AS f order by f.Year;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.Year, f.CustomerKey, f.CustomerName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderItemCustomerOfStateYearCube
	FROM (
		Select i.ItemKey, i.Descriptions, t.Year, cus.CustomerKey, cus.CustomerName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions, t.Year, cus.CustomerKey, cus.CustomerName, ct.State
	) AS f order by f.Year;
    PRINT 'Bang khong ton tai'
END



IF OBJECT_ID('OrderCustomerDayCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderCustomerDayCube;
	SELECT * FROM OrderCustomerDayCube;
	INSERT INTO OrderCustomerDayCube
	SELECT top 9999999 f.Day, f.Month, f.Year, f.CustomerKey, f.CustomerName, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select t.Day, t.Month, t.Year, cus.CustomerKey, cus.CustomerName, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimTime t
		where t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey
		group by t.Day, t.Month, t.Year, cus.CustomerKey, cus.CustomerName
	) AS f order by f.Year, f.Month, f.Day;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.Day, f.Month, f.Year, f.CustomerKey, f.CustomerName, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderCustomerDayCube
	FROM (
		Select t.Day, t.Month, t.Year, cus.CustomerKey, cus.CustomerName, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimTime t
		where t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey 
		group by t.Day, t.Month, t.Year, cus.CustomerKey, cus.CustomerName
	) AS f order by f.Year, f.Month, f.Day;
    PRINT 'Bang khong ton tai'
END



IF OBJECT_ID('OrderCustomerMonthCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderCustomerMonthCube;
	SELECT * FROM OrderCustomerMonthCube;
	INSERT INTO OrderCustomerMonthCube
	SELECT top 9999999 f.Month, f.Year, f.CustomerKey, f.CustomerName, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select  t.Month, t.Year, cus.CustomerKey, cus.CustomerName, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimTime t
		where t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey
		group by t.Month, t.Year, cus.CustomerKey, cus.CustomerName
	) AS f order by f.Year, f.Month;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.Month, f.Year, f.CustomerKey, f.CustomerName, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderCustomerMonthCube
	FROM (
		Select  t.Month, t.Year, cus.CustomerKey, cus.CustomerName, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimTime t
		where t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey 
		group by t.Month, t.Year, cus.CustomerKey, cus.CustomerName
	) AS f order by f.Year, f.Month;
    PRINT 'Bang khong ton tai'
END


IF OBJECT_ID('OrderCustomerQuarterCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderCustomerQuarterCube;
	SELECT * FROM OrderCustomerQuarterCube;
	INSERT INTO OrderCustomerQuarterCube
	SELECT top 9999999 f.Quarter, f.Year, f.CustomerKey, f.CustomerName, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select  t.Quarter, t.Year, cus.CustomerKey, cus.CustomerName, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimTime t
		where t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey
		group by t.Quarter, t.Year, cus.CustomerKey, cus.CustomerName
	) AS f order by f.Year, f.Quarter;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.Quarter, f.Year, f.CustomerKey, f.CustomerName, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderCustomerQuarterCube
	FROM (
		Select  t.Quarter, t.Year, cus.CustomerKey, cus.CustomerName, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimTime t
		where t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey 
		group by t.Quarter, t.Year, cus.CustomerKey, cus.CustomerName
	) AS f order by f.Year, f.Quarter;
    PRINT 'Bang khong ton tai'
END


IF OBJECT_ID('OrderCustomerYearCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderCustomerYearCube;
	SELECT * FROM OrderCustomerYearCube;
	INSERT INTO OrderCustomerYearCube
	SELECT top 9999999 f.Year, f.CustomerKey, f.CustomerName, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select  t.Year, cus.CustomerKey, cus.CustomerName, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimTime t
		where t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey
		group by t.Year, cus.CustomerKey, cus.CustomerName
	) AS f order by f.Year;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.Year, f.CustomerKey, f.CustomerName, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderCustomerYearCube
	FROM (
		Select  t.Year, cus.CustomerKey, cus.CustomerName, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimTime t
		where t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey 
		group by  t.Year, cus.CustomerKey, cus.CustomerName
	) AS f order by f.Year;
    PRINT 'Bang khong ton tai'
END



IF OBJECT_ID('OrderCustomerOfCityDayCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderCustomerOfCityDayCube;
	SELECT * FROM OrderCustomerOfCityDayCube;
	INSERT INTO OrderCustomerOfCityDayCube
	SELECT top 9999999 f.Day, f.Month, f.Year, f.CityKey, f.CityName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select i.ItemKey, i.Descriptions,t.Day, t.Month, t.Year,  ct.CityKey, ct.CityName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions,t.Day, t.Month, t.Year, ct.CityKey, ct.CityName, ct.State
	) AS f order by f.Year, f.Month, f.Day;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.Day, f.Month, f.Year,  f.CityKey, f.CityName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderCustomerOfCityDayCube
	FROM (
		Select t.Day, t.Month, t.Year, ct.CityKey, ct.CityName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimRepresentativeOffice ct, DimTime t
		where t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by t.Day, t.Month, t.Year, ct.CityKey, ct.CityName, ct.State
	) AS f order by f.Year, f.Month, f.Day;
    PRINT 'Bang khong ton tai'
END



IF OBJECT_ID('OrderCustomerOfCityMonthCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderCustomerOfCityMonthCube;
	SELECT * FROM OrderCustomerOfCityMonthCube;
	INSERT INTO OrderCustomerOfCityMonthCube
	SELECT top 9999999  f.Month, f.Year, f.CityKey, f.CityName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select i.ItemKey, i.Descriptions, t.Month, t.Year,  ct.CityKey, ct.CityName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct, DimTime t
		where i.ItemKey = ft.ItemKey and t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions, t.Month, t.Year, ct.CityKey, ct.CityName, ct.State
	) AS f order by f.Year, f.Month;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.Month, f.Year,  f.CityKey, f.CityName, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderCustomerOfCityMonthCube
	FROM (
		Select t.Month, t.Year, ct.CityKey, ct.CityName, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimRepresentativeOffice ct, DimTime t
		where t.TimeKey = ft.TimeKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by t.Month, t.Year, ct.CityKey, ct.CityName, ct.State
	) AS f order by f.Year, f.Month;
    PRINT 'Bang khong ton tai'
END

--Thống kê doanh thu các thành phố trong các quý

DROP TABLE IF EXISTS OrderCustomerOfCityQuarterCube;
SELECT top 9999999 f.*
INTO OrderCustomerOfCityQuarterCube
FROM (
	SELECT dr.CityKey, dr.CityName,ti.Quarter, ti.Year, sum(fa.OrderedCost) as DoanhThu, sum(fa.OrderedQuantity) as SoLuongBan, sum(fa.Profit) as LoiNhuan
	FROM FactOrderItems fa
	INNER JOIN DimCustomer dc ON fa.CustomerKey = dc.CustomerKey
	INNER JOIN DimRepresentativeOffice dr ON dr.CityKey = dc.CityKey 
	INNER JOIN DimTime ti ON ti.TimeKey = fa.TimeKey
	GROUP BY dr.CityKey, dr.CityName, ti.Quarter, ti.Year
) AS f
ORDER BY f.Year, f.Quarter;

DROP TABLE IF EXISTS OrderCustomerOfCityYearCube;
SELECT top 9999999 f.*
INTO OrderCustomerOfCityYearCube
FROM (
	SELECT dr.CityKey, dr.CityName, ti.Year, sum(fa.OrderedCost) as DoanhThu, sum(fa.OrderedQuantity) as SoLuongBan, sum(fa.Profit) as LoiNhuan
	FROM FactOrderItems fa
	INNER JOIN DimCustomer dc ON fa.CustomerKey = dc.CustomerKey
	INNER JOIN DimRepresentativeOffice dr ON dr.CityKey = dc.CityKey 
	INNER JOIN DimTime ti ON ti.TimeKey = fa.TimeKey
	GROUP BY dr.CityKey, dr.CityName, ti.Year
) AS f
ORDER BY f.Year;

DROP TABLE IF EXISTS OrderCustomerOfStateDayCube;
SELECT top 9999999 f.*
INTO OrderCustomerOfStateDayCube
FROM (
	SELECT dr.State, ti.Day, ti.Month, ti.Year , sum(fa.OrderedCost) as DoanhThu, sum(fa.OrderedQuantity) as SoLuongBan, sum(fa.Profit) as LoiNhuan
	FROM FactOrderItems fa
	INNER JOIN DimCustomer dc ON fa.CustomerKey = dc.CustomerKey
	INNER JOIN DimRepresentativeOffice dr ON dr.CityKey = dc.CityKey 
	INNER JOIN DimTime ti ON ti.TimeKey = fa.TimeKey
	GROUP BY dr.State, ti.Day, ti.Month, ti.Year
) AS f
ORDER BY f.Year, f.Month, f.Day;

DROP TABLE IF EXISTS OrderCustomerOfStateMonthCube;
SELECT top 9999999 f.*
INTO OrderCustomerOfStateMonthCube
FROM (
	SELECT dr.State, ti.Month, ti.Year , sum(fa.OrderedCost) as DoanhThu, sum(fa.OrderedQuantity) as SoLuongBan, sum(fa.Profit) as LoiNhuan
	FROM FactOrderItems fa
	INNER JOIN DimCustomer dc ON fa.CustomerKey = dc.CustomerKey
	INNER JOIN DimRepresentativeOffice dr ON dr.CityKey = dc.CityKey 
	INNER JOIN DimTime ti ON ti.TimeKey = fa.TimeKey
	GROUP BY dr.State, ti.Month, ti.Year
) AS f
ORDER BY f.Year, f.Month;

DROP TABLE IF EXISTS OrderCustomerOfStateQuarterCube;
SELECT top 9999999 f.*
INTO OrderCustomerOfStateQuarterCube
FROM (
	SELECT dr.State, ti.Quarter, ti.Year , sum(fa.OrderedCost) as DoanhThu, sum(fa.OrderedQuantity) as SoLuongBan, sum(fa.Profit) as LoiNhuan
	FROM FactOrderItems fa
	INNER JOIN DimCustomer dc ON fa.CustomerKey = dc.CustomerKey
	INNER JOIN DimRepresentativeOffice dr ON dr.CityKey = dc.CityKey 
	INNER JOIN DimTime ti ON ti.TimeKey = fa.TimeKey
	GROUP BY dr.State, ti.Quarter, ti.Year
) AS f
ORDER BY f.Year, f.Quarter;

DROP TABLE IF EXISTS OrderCustomerOfStateYearCube;
SELECT top 9999999 f.*
INTO OrderCustomerOfStateYearCube
FROM (
	SELECT dr.State,ti.Year , sum(fa.OrderedCost) as DoanhThu, sum(fa.OrderedQuantity) as SoLuongBan, sum(fa.Profit) as LoiNhuan
	FROM FactOrderItems fa
	INNER JOIN DimCustomer dc ON fa.CustomerKey = dc.CustomerKey
	INNER JOIN DimRepresentativeOffice dr ON dr.CityKey = dc.CityKey 
	INNER JOIN DimTime ti ON ti.TimeKey = fa.TimeKey
	GROUP BY dr.State, ti.Year
) AS f
ORDER BY f.Year;

DROP TABLE IF EXISTS OrderItemsCustomerCube;
SELECT top 9999999 f.*
INTO OrderItemsCustomerCube
FROM (
	SELECT dc.CustomerKey, dc.CustomerName, di.ItemKey, di.Descriptions , sum(fa.OrderedCost) as DoanhThu, sum(fa.OrderedQuantity) as SoLuongBan, sum(fa.Profit) as LoiNhuan
	FROM FactOrderItems fa
	INNER JOIN DimCustomer dc ON fa.CustomerKey = dc.CustomerKey
	INNER JOIN DimItem di ON fa.ItemKey = di.ItemKey
	GROUP BY dc.CustomerKey, dc.CustomerName, di.ItemKey, di.Descriptions
) AS f
ORDER BY f.CustomerKey;

DROP TABLE IF EXISTS OrderItemsCustomerOfCityCube;
SELECT top 9999999 f.*
INTO OrderItemsCustomerOfCityCube
FROM (
	SELECT dr.CityKey, dr.CityName, di.ItemKey, di.Descriptions , sum(fa.OrderedCost) as DoanhThu, sum(fa.OrderedQuantity) as SoLuongBan, sum(fa.Profit) as LoiNhuan
	FROM FactOrderItems fa
	INNER JOIN DimCustomer dc ON fa.CustomerKey = dc.CustomerKey
	INNER JOIN DimRepresentativeOffice dr ON dc.CityKey = dr.CityKey
	INNER JOIN DimItem di ON fa.ItemKey = di.ItemKey
	GROUP BY dr.CityKey, dr.CityName, di.ItemKey, di.Descriptions
) AS f
ORDER BY f.CityName;


IF OBJECT_ID('OrderMonthCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderMonthCube;
	SELECT * FROM OrderMonthCube;
	INSERT INTO OrderMonthCube
	SELECT top 9999999  f.Month, f.Year, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select  t.Month, t.Year, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimTime t
		where t.TimeKey = ft.TimeKey 
		group by  t.Month, t.Year
	) AS f order by f.Year, f.Month;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.Month, f.Year, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderMonthCube
	FROM (
		Select t.Month, t.Year, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimTime t
		where t.TimeKey = ft.TimeKey
		group by t.Month, t.Year
	) AS f order by f.Year, f.Month;
    PRINT 'Bang khong ton tai'
END



IF OBJECT_ID('OrderDayCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderDayCube;
	SELECT * FROM OrderDayCube;
	INSERT INTO OrderDayCube
	SELECT top 9999999  f.Day, f.Month, f.Year, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select  t.Day, t.Month, t.Year, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimTime t
		where t.TimeKey = ft.TimeKey 
		group by  t.Day, t.Month, t.Year
	) AS f order by f.Year, f.Month, f.Day;
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.Day, f.Month, f.Year, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderDayCube
	FROM (
		Select t.Day, t.Month, t.Year, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimTime t
		where t.TimeKey = ft.TimeKey
		group by t.Day, t.Month, t.Year
	) AS f order by f.Year, f.Month, f.Day;
    PRINT 'Bang khong ton tai'
END



IF OBJECT_ID('OrderItemCustomerOfStateCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OrderItemCustomerOfStateCube;
	SELECT * FROM OrderItemCustomerOfStateCube;
	INSERT INTO OrderItemCustomerOfStateCube
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select i.ItemKey, i.Descriptions, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct
		where i.ItemKey = ft.ItemKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions, ct.State
	) AS f order by f.ItemKey
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.ItemKey, f.Descriptions, f.State, f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OrderItemCustomerOfStateCube
	FROM (
		Select i.ItemKey, i.Descriptions, ct.State, sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft, DimCustomer cus, DimItem i, DimRepresentativeOffice ct
		where i.ItemKey = ft.ItemKey and cus.CustomerKey = ft.CustomerKey and cus.CityKey = ct.CityKey
		group by i.ItemKey, i.Descriptions,  ct.State
	) AS f order by f.ItemKey;
    PRINT 'Bang khong ton tai'
END


IF OBJECT_ID('OdersCube', 'U') IS NOT NULL
BEGIN
	TRUNCATE TABLE OdersCube;
	SELECT * FROM OdersCube;
	INSERT INTO OdersCube
	SELECT top 9999999  f.OrderedQuantity, f.OrderedCost, f.Profit
	FROM (
		Select  sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft
	) AS f
    PRINT 'Bang ton tai'
END
ELSE
BEGIN
	SELECT top 9999999 f.OrderedQuantity, f.OrderedCost, f.Profit
	INTO OdersCube
	FROM (
		Select sum(ft.OrderedQuantity) as OrderedQuantity, sum(ft.OrderedCost) as OrderedCost, sum(ft.Profit) as Profit
		from FactOrderItems ft
	) AS f;
    PRINT 'Bang khong ton tai'
END
















