SELECT CarWasherSet.CarWasherId AS '����������',
 COUNT(DATEDIFF(MINUTE,PaymentSet.DataTime, RecordSet.DateTime)) AS '���-�� ������� � ������� �������'
FROM RecordSet
INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
INNER JOIN PaymentSet ON PaymentSet.OrderOrderId = OrderSet.OrderId
INNER JOIN CarWasherSet ON CarWasherSet.CarWasherId = RecordSet.CarWasherCarWasherId
WHERE DATEDIFF(MINUTE,PaymentSet.DataTime, RecordSet.DateTime) <= -30
GROUP BY CarWasherSet.CarWasherId
ORDER BY COUNT(DATEDIFF(MINUTE,PaymentSet.DataTime, RecordSet.DateTime)) DESC