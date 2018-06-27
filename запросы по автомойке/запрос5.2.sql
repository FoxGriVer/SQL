/*������� ��������� 5 ������� ��������, � �������� ������ ����� �������,
 ������� ���� �������� � ����������� (�� ������� � ����� ����� ����� ������) � 
 ��������� �� ���� � ������� �� ������� (����� ��������� ���� ������ � ���� ������)*/

SELECT TOP 5 RecordSet.CarClientCarNumber AS '������', PaymentSet.DataTime AS '���� ������',
	DATEDIFF(MINUTE,RecordSet.DateTime, PaymentSet.DataTime) AS '������� �� �������'
FROM RecordSet
	INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
	INNER JOIN PaymentSet ON PaymentSet.OrderOrderId = OrderSet.OrderId
WHERE RecordSet.CarWasherCarWasherId = 
	(SELECT TOP 1 CarWasherSet.CarWasherId AS '����������'
	FROM RecordSet
		INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
		INNER JOIN PaymentSet ON PaymentSet.OrderOrderId = OrderSet.OrderId
		INNER JOIN CarWasherSet ON CarWasherSet.CarWasherId = RecordSet.CarWasherCarWasherId
	WHERE DATEDIFF(MINUTE,RecordSet.DateTime, PaymentSet.DataTime) >= 30
	GROUP BY CarWasherSet.CarWasherId
	ORDER BY COUNT(DATEDIFF(MINUTE,PaymentSet.DataTime, RecordSet.DateTime)) DESC)
ORDER BY PaymentSet.DataTime DESC 