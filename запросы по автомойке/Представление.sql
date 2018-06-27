CREATE VIEW CategoriesBySeasons AS 
SELECT CategoryOfCarSet.Description AS 'Категория автомобиля',
COUNT(OrderServicesByCategory.Order_OrderId) AS 'Кол-во посещений', 
Seasons.Season AS 'Сезон'
FROM ServicesByCategorySet 
INNER JOIN CategoryOfCarSet ON CategoryOfCarSet.CategoryId = ServicesByCategorySet.CategoryOfCarCategoryId
INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.ServicesByCategory_ServiceId = ServicesByCategorySet.ServiceId
INNER JOIN OrderSet ON OrderSet.OrderId = OrderServicesByCategory.Order_OrderId
INNER JOIN RecordSet ON RecordSet.RecordId = OrderSet.RecordRecordId
INNER JOIN Seasons ON Seasons.NumberOfMount = RecordSet.NumberOfSeason
GROUP BY CategoryOfCarSet.Description, Seasons.Season