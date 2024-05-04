--Thống kê doanh thu các bang (miền) theo ngày

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