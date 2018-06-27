/*4. Какая услуга является часто оказываемой для каждой марки автомобилей для каждого сезона года.*/

SELECT  ServicesSet.Description AS 'Название услуги', Seasons.Season AS 'Сезон',
 COUNT(OrderServicesByCategory.ServicesByCategory_ServiceId) AS 'Кол-во оказанных раз'
FROM ServicesByCategorySet
	INNER JOIN ServicesSet ON ServicesSet.CodeService = ServicesByCategorySet.ServicesCodeService
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.ServicesByCategory_ServiceId = ServicesByCategorySet.ServiceId
	INNER JOIN OrderSet ON OrderSet.OrderId = OrderServicesByCategory.Order_OrderId
	INNER JOIN RecordSet ON RecordSet.RecordId = OrderSet.RecordRecordId
	INNER JOIN Seasons ON Seasons.NumberOfMount = RecordSet.NumberOfSeason
GROUP BY ServicesSet.Description, Seasons.Season
ORDER BY ServicesSet.Description
