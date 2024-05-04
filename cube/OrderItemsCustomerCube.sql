--Thống kê doanh thu khách hàng theo sản phẩm

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