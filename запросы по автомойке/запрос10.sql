/*10. Таблица статистики количества оказанных услуг работником для каждого класса.*/

DECLARE @columns VARCHAR(MAX), @sql VARCHAR(MAX);
SET @columns = '';

SELECT @columns += ', ' + QUOTENAME(col.[Название категории])
FROM 
	(SELECT CategoryOfCarSet.Description AS 'Название категории'
	FROM ServicesByCategorySet
	INNER JOIN CategoryOfCarSet ON CategoryOfCarSet.CategoryId = ServicesByCategorySet.CategoryOfCarCategoryId
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.ServicesByCategory_ServiceId = ServicesByCategorySet.ServiceId
	INNER JOIN OrderSet ON OrderSet.OrderId = OrderServicesByCategory.Order_OrderId
	INNER JOIN RecordSet ON RecordSet.RecordId = OrderSet.RecordRecordId
	GROUP BY CategoryOfCarSet.Description) AS col

SET @sql= 'SELECT * 
FROM 
	(SELECT CarWasherSet.Surname AS Автомойщик, COUNT(OrderServicesByCategory.ServicesByCategory_ServiceId) AS SERVICES, CategoryOfCarSet.Description AS CARS
	FROM RecordSet 
	INNER JOIN CarWasherSet ON CarWasherSet.CarWasherId = RecordSet.CarWasherCarWasherId
	INNER JOIN OrderSet ON RecordSet.RecordId = OrderSet.RecordRecordId
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.Order_OrderId = OrderSet.OrderId
	INNER JOIN ServicesByCategorySet ON ServicesByCategorySet.ServiceId = OrderServicesByCategory.ServicesByCategory_ServiceId
	INNER JOIN CategoryOfCarSet ON CategoryOfCarSet.CategoryId = ServicesByCategorySet.CategoryOfCarCategoryId
	GROUP BY CarWasherSet.Surname, CategoryOfCarSet.Description
	) AS temp 
PIVOT(MAX(temp.SERVICES) FOR temp.CARS IN (' +STUFF(@columns, 1, 2, '') +')) RESULT;';
EXECUTE(@sql)