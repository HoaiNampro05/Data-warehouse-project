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













