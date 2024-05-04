--Thống kê doanh thu khách hàng theo sản phẩm

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