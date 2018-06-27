/*¬ывести последние 5 записей рабочего, у которого больше всего записей,
 которые были оплачены с запозданием (за полчаса и более после факта записи) с 
 указанием их даты и разницы во времени (когда произошел факт оплаты и факт записи)*/

SELECT TOP 5 RecordSet.CarClientCarNumber AS '«апись', PaymentSet.DataTime AS 'ƒата оплаты',
	DATEDIFF(MINUTE,RecordSet.DateTime, PaymentSet.DataTime) AS '–азница во времени'
FROM RecordSet
	INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
	INNER JOIN PaymentSet ON PaymentSet.OrderOrderId = OrderSet.OrderId
WHERE RecordSet.CarWasherCarWasherId = 
	(SELECT TOP 1 CarWasherSet.CarWasherId AS 'јвтомойщик'
	FROM RecordSet
		INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
		INNER JOIN PaymentSet ON PaymentSet.OrderOrderId = OrderSet.OrderId
		INNER JOIN CarWasherSet ON CarWasherSet.CarWasherId = RecordSet.CarWasherCarWasherId
	WHERE DATEDIFF(MINUTE,RecordSet.DateTime, PaymentSet.DataTime) >= 30
	GROUP BY CarWasherSet.CarWasherId
	ORDER BY COUNT(DATEDIFF(MINUTE,PaymentSet.DataTime, RecordSet.DateTime)) DESC)
ORDER BY PaymentSet.DataTime DESC 