/*7. ������� ��� ������� �������� ��������� ���������� ��� ������� �� ������ ���������� 
���������� ����� � ��������� ���������� �� ���������� �����.*/

SELECT TOP(1) WITH TIES CarWasherSet.Surname AS '������� ��������',
CategoryOfCarSet.Description AS '��������� ����������',
COUNT(OrderServicesByCategory.ServicesByCategory_ServiceId) AS '���-�� �������'
FROM RecordSet
	INNER JOIN CarWasherSet ON CarWasherSet.CarWasherId = RecordSet.CarWasherCarWasherId
	INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.Order_OrderId = OrderSet.OrderId
	INNER JOIN ServicesByCategorySet ON ServicesByCategorySet.ServiceId = OrderServicesByCategory.ServicesByCategory_ServiceId
	INNER JOIN CategoryOfCarSet ON CategoryOfCarSet.CategoryId = ServicesByCategorySet.CategoryOfCarCategoryId
WHERE (RecordSet.DateTime) > dateadd(MONTH, -1, GETDATE())
GROUP BY CarWasherSet.Surname, CategoryOfCarSet.Description
order by ROW_NUMBER() over(partition by CarWasherSet.Surname
						   order by count(ServicesByCategorySet.ServicesCodeService) desc)