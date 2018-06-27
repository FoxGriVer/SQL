DECLARE @columns VARCHAR(MAX), @sql VARCHAR(MAX);
SET @columns = '';
SELECT @columns += ', ' + QUOTENAME(col.[Код услуги])
FROM 
	(SELECT CategoryOfCarSet.Description AS 'Код услуги'
	FROM ServicesByCategorySet
	INNER JOIN CategoryOfCarSet ON CategoryOfCarSet.CategoryId = ServicesByCategorySet.CategoryOfCarCategoryId
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.ServicesByCategory_ServiceId = ServicesByCategorySet.ServiceId
	INNER JOIN OrderSet ON OrderSet.OrderId = OrderServicesByCategory.Order_OrderId
	INNER JOIN RecordSet ON RecordSet.RecordId = OrderSet.RecordRecordId
	GROUP BY CategoryOfCarSet.Description) AS col

PRINT @columns
