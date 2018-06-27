/*2.	������� ��� ������� � ����� ���������� �� ������� �� ������� ���������,
 ����� �� ���� ����� �� �������� ��� � ����� ������ ���������� ������ 1000 ������ ������. */

SELECT ClientSet.Surname + ' ' + ClientSet.Name + '' + ClientSet.Patronymic AS '�.�.�.',
CarSet.Mark AS '����� ����������', SUM(ServicesByCategorySet.Price) AS '����� ��������� ������'
FROM RecordSet
	INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
	INNER JOIN OrderServicesByCategory ON OrderSet.OrderId = OrderServicesByCategory.Order_OrderId
	INNER JOIN ServicesByCategorySet ON ServicesByCategorySet.ServiceId = OrderServicesByCategory.ServicesByCategory_ServiceId
	INNER JOIN CarClientSet ON CarClientSet.CarNumber = RecordSet.CarClientCarNumber
	INNER JOIN ClientSet ON ClientSet.ClientId = CarClientSet.ClientClientId
	INNER JOIN CarSet ON CarSet.CarId = CarClientSet.CarCarId
	INNER JOIN ServicesSet ON ServicesSet.CodeService = ServicesByCategorySet.ServicesCodeService
WHERE ServicesByCategorySet.Price > 1000
GROUP BY ClientSet.Surname + ' ' + ClientSet.Name + '' + ClientSet.Patronymic,
	CarSet.Mark, RecordSet.RecordId
HAVING COUNT(OrderServicesByCategory.ServicesByCategory_ServiceId) >= 2
ORDER BY ClientSet.Surname + ' ' + ClientSet.Name + '' + ClientSet.Patronymic
