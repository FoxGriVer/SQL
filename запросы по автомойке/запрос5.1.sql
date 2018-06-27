SELECT CarWasherSet.CarWasherId AS 'Автомойщик',
 COUNT(DATEDIFF(MINUTE,PaymentSet.DataTime, RecordSet.DateTime)) AS 'Кол-во заказов с поздней оплатой'
FROM RecordSet
INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
INNER JOIN PaymentSet ON PaymentSet.OrderOrderId = OrderSet.OrderId
INNER JOIN CarWasherSet ON CarWasherSet.CarWasherId = RecordSet.CarWasherCarWasherId
WHERE DATEDIFF(MINUTE,PaymentSet.DataTime, RecordSet.DateTime) <= -30
GROUP BY CarWasherSet.CarWasherId
ORDER BY COUNT(DATEDIFF(MINUTE,PaymentSet.DataTime, RecordSet.DateTime)) DESC