--Thống kê doanh thu các thành phố trong các quý

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