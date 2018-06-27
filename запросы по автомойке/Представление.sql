CREATE VIEW CategoriesBySeasons AS 
SELECT CategoryOfCarSet.Description AS '��������� ����������',
COUNT(OrderServicesByCategory.Order_OrderId) AS '���-�� ���������', 
Seasons.Season AS '�����'
FROM ServicesByCategorySet 
INNER JOIN CategoryOfCarSet ON CategoryOfCarSet.CategoryId = ServicesByCategorySet.CategoryOfCarCategoryId
INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.ServicesByCategory_ServiceId = ServicesByCategorySet.ServiceId
INNER JOIN OrderSet ON OrderSet.OrderId = OrderServicesByCategory.Order_OrderId
INNER JOIN RecordSet ON RecordSet.RecordId = OrderSet.RecordRecordId
INNER JOIN Seasons ON Seasons.NumberOfMount = RecordSet.NumberOfSeason
GROUP BY CategoryOfCarSet.Description, Seasons.Season