/*9. ������� ��� 3 ������� ��� ������ ������� ������ ���� ����� ���������� �������������� ������ � �� ����������*/

SELECT TOP 5 CarWasherSet.Surname +' '+ CarWasherSet.Name + CarWasherSet.Patronymic AS '����������',
COUNT(distinct OrderServicesByCategory.ServicesByCategory_ServiceId) - 
 COUNT(distinct RecordServicesByCategory.ServicesByCategory_ServiceId) AS '���-�� �������������� �����'
FROM RecordSet
	INNER JOIN CarWasherSet ON CarWasherSet.CarWasherId = RecordSet.CarWasherCarWasherId
	INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.Order_OrderId = OrderSet.OrderId
	INNER JOIN RecordServicesByCategory ON RecordServicesByCategory.Order_OrderId = OrderSet.OrderId
GROUP BY CarWasherSet.Surname +' '+ CarWasherSet.Name + CarWasherSet.Patronymic
HAVING COUNT(distinct OrderServicesByCategory.ServicesByCategory_ServiceId) > 
			COUNT(distinct RecordServicesByCategory.ServicesByCategory_ServiceId)
ORDER BY COUNT(distinct OrderServicesByCategory.ServicesByCategory_ServiceId) - 
 COUNT(distinct RecordServicesByCategory.ServicesByCategory_ServiceId) DESC
