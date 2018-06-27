/*1. Топ 5 самых заказываемых услуг за определенный год? */

CREATE PROCEDURE MostOrderedServices
(@year VARCHAR(4)) AS 

SELECT TOP 5 ServicesSet.Description as 'Услуга', 
	COUNT(ServicesByCategorySet.ServicesCodeService) AS 'Кол-во заказов в 2017 году'
FROM ServicesByCategorySet
	INNER JOIN ServicesSet ON ServicesSet.CodeService = ServicesByCategorySet.ServicesCodeService
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.ServicesByCategory_ServiceId = ServicesByCategorySet.ServiceId
	INNER JOIN OrderSet ON OrderSet.OrderId = OrderServicesByCategory.Order_OrderId
	INNER JOIN PaymentSet ON PaymentSet.OrderOrderId = OrderSet.OrderId
where CONVERT(datetime, PaymentSet.DataTime , 113) 
	BETWEEN CONVERT(datetime,'01/01/'+@year,104) AND CONVERT(datetime,'31/12/'+@year,104)
GROUP BY ServicesSet.Description
ORDER BY COUNT(ServicesByCategorySet.ServicesCodeService) DESC

/*2.	Вывести ФИО клиента и марку автомобиля на котором он посещал автомойку,
 когда за один заказ он приобрел две и более услуги стоимостью дороже 1000 рублей каждая. */

SELECT CONCAT(ClientSet.Surname,' ', ClientSet.Name,' ', ClientSet.Patronymic) AS 'Ф.И.О', RecordSet.DateTime AS 'Дата посещения',
CarSet.Mark AS 'Марка автомобиля', SUM(ServicesByCategorySet.Price) AS 'Общая стоимость заказа'
FROM RecordSet
	INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
	INNER JOIN OrderServicesByCategory ON OrderSet.OrderId = OrderServicesByCategory.Order_OrderId
	INNER JOIN ServicesByCategorySet ON ServicesByCategorySet.ServiceId = OrderServicesByCategory.ServicesByCategory_ServiceId
	INNER JOIN CarClientSet ON CarClientSet.CarNumber = RecordSet.CarClientCarNumber
	INNER JOIN ClientSet ON ClientSet.ClientId = CarClientSet.ClientClientId
	INNER JOIN CarSet ON CarSet.CarId = CarClientSet.CarCarId
	INNER JOIN ServicesSet ON ServicesSet.CodeService = ServicesByCategorySet.ServicesCodeService
WHERE ServicesByCategorySet.Price > 1000
GROUP BY CONCAT(ClientSet.Surname,' ', ClientSet.Name,' ', ClientSet.Patronymic), 
	RecordSet.DateTime, CarSet.Mark, RecordSet.RecordId
HAVING COUNT(OrderServicesByCategory.ServicesByCategory_ServiceId) >= 2
ORDER BY CONCAT(ClientSet.Surname,' ', ClientSet.Name,' ', ClientSet.Patronymic)


/*3. Клиенты, которые посещали автомойку более одного раза за определенный месяц в году и на каких автомобилях,
 если они разные, то вывести кол-во посещений для каждого автомобиля.*/

SELECT CONCAT(ClientSet.Surname,' ', ClientSet.Name,' ', ClientSet.Patronymic) AS 'Ф.И.О.',
 ROW_NUMBER() OVER(PARTITION BY CONCAT(ClientSet.Surname,' ', ClientSet.Name,' ', ClientSet.Patronymic)
				ORDER BY CarSet.Mark, CarSet.Model) AS '№ п/п',
 CarSet.Mark AS 'Марка', CarSet.Model AS 'Модель',  COUNT(RecordSet.RecordId) AS 'Кол-во посещений'
FROM RecordSet
	INNER JOIN CarClientSet ON CarClientSet.CarNumber = RecordSet.CarClientCarNumber
	INNER JOIN ClientSet ON ClientSet.ClientId = CarClientSet.ClientClientId
	INNER JOIN CarSet ON CarSet.CarId = CarClientSet.CarCarId
GROUP BY CONCAT(ClientSet.Surname,' ', ClientSet.Name,' ', ClientSet.Patronymic), CarSet.Mark, CarSet.Model
ORDER BY CONCAT(ClientSet.Surname,' ', ClientSet.Name,' ', ClientSet.Patronymic)


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

/*5. Вывести последние 5 записей рабочего, у которого больше всего записей,
 которые были оплачены с запозданием (за полчаса и более после факта записи) с 
 указанием их даты и разницы во времени (когда произошел факт оплаты и факт записи)*/

SELECT TOP 5 RecordSet.CarClientCarNumber AS 'Запись', PaymentSet.DataTime AS 'Дата оплаты',
	DATEDIFF(MINUTE,RecordSet.DateTime, PaymentSet.DataTime) AS 'Разница во времени'
FROM RecordSet
	INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
	INNER JOIN PaymentSet ON PaymentSet.OrderOrderId = OrderSet.OrderId
WHERE RecordSet.CarWasherCarWasherId = 
	(SELECT TOP 1 CarWasherSet.CarWasherId AS 'Автомойщик'
	FROM RecordSet
		INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
		INNER JOIN PaymentSet ON PaymentSet.OrderOrderId = OrderSet.OrderId
		INNER JOIN CarWasherSet ON CarWasherSet.CarWasherId = RecordSet.CarWasherCarWasherId
	WHERE DATEDIFF(MINUTE,RecordSet.DateTime, PaymentSet.DataTime) >= 30
	GROUP BY CarWasherSet.CarWasherId
	ORDER BY COUNT(DATEDIFF(MINUTE,PaymentSet.DataTime, RecordSet.DateTime)) DESC)
ORDER BY PaymentSet.DataTime DESC 

/*6. Вывести выручку в определенном месяце определенного года и разницу с выручкой прошлого года*/
CREATE PROCEDURE DeferenceBetweenTwoYears
(@_year INT, @_month INT) AS
DECLARE @PASTYEAR INT

SET @PASTYEAR = @_year - 1;

WITH PastYear(outputsum, _month, _year) AS 
		(SELECT SUM(ServicesByCategorySet.Price), MONTH(RecordSet.DateTime), YEAR(RecordSet.DateTime)
		FROM RecordSet
		INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
		INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.Order_OrderId = OrderSet.OrderId
		INNER JOIN ServicesByCategorySet ON ServicesByCategorySet.ServiceId = OrderServicesByCategory.ServicesByCategory_ServiceId
		INNER JOIN Seasons ON RecordSet.NumberOfSeason = Seasons.NumberOfMount
		WHERE MONTH(RecordSet.DateTime) = @_month AND YEAR(RecordSet.DateTime) = @PASTYEAR
		GROUP BY MONTH(RecordSet.DateTime), YEAR(RecordSet.DateTime))
SELECT @_month AS 'Месяц', @_year AS 'Год', SUM(ServicesByCategorySet.Price) AS 'Выручка в текущем году',
		SUM(ServicesByCategorySet.Price) - PastYear.outputsum AS 'Разница с прошлым годом'
FROM RecordSet
	INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.Order_OrderId = OrderSet.OrderId
	INNER JOIN ServicesByCategorySet ON ServicesByCategorySet.ServiceId = OrderServicesByCategory.ServicesByCategory_ServiceId
	INNER JOIN Seasons ON RecordSet.NumberOfSeason = Seasons.NumberOfMount
	inner join PastYear on RecordSet.NumberOfSeason = PastYear._month
WHERE MONTH(RecordSet.DateTime) = @_month AND YEAR(RecordSet.DateTime) = @_year
GROUP BY PastYear.outputsum

/*7. Вывести для каждого рабочего категорию автомобиля для которой он оказал наибольшее 
количество услуг с указанием количества за предыдущий месяц.*/

SELECT TOP(1) WITH TIES CarWasherSet.Surname AS 'Фамилия рабочего',
CategoryOfCarSet.Description AS 'Категория автомобиля',
COUNT(OrderServicesByCategory.ServicesByCategory_ServiceId) AS 'Кол-во заказов'
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


/*8. Вывести ФИО рабочих, которые перерабатывали (работали больше определенного кол-ва часов) два месяца подряд*/

SELECT (CarWasherSet.Surname +' ' +CarWasherSet.Name + '' + CarWasherSet.Patronymic) AS 'Автомойщик'
FROM RecordSet
	INNER JOIN CarWasherSet ON RecordSet.CarWasherCarWasherId = CarWasherSet.CarWasherId
	INNER JOIN WorkSchedule as work1 ON work1.CarWasherId = CarWasherSet.CarWasherId
	INNER JOIN WorkSchedule AS work2 ON work2.CarWasherId = CarWasherSet.CarWasherId AND
	((work1.Month + 1 = work2.Month AND work1.Year = work2.Year)
		OR ((work1.Month = 12 AND work2.Month = 1)) AND (work1.Year + 1 = work2.Year))
WHERE work1.NumberOfHours > 120 AND (work2.NumberOfHours > 120)
GROUP BY CarWasherSet.Surname, CarWasherSet.Name, CarWasherSet.Patronymic
ORDER BY CarWasherSet.Surname

/*9.	Вывести топ 3 рабочих при работе которых клиент чаще всего заказывает дополнительные услуги и их количество*/
SELECT TOP 5 CarWasherSet.Surname, count(distinct OrderServicesByCategory.ServicesByCategory_ServiceId) - 
count(distinct RecordServicesByCategory.ServicesByCategory_ServiceId) AS 'Кол-во дополнительных услуг'
FROM RecordSet
	INNER JOIN CarWasherSet ON CarWasherSet.CarWasherId = RecordSet.CarWasherCarWasherId
	INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.Order_OrderId = OrderSet.OrderId
	LEFT JOIN RecordServicesByCategory ON OrderServicesByCategory.Order_OrderId = RecordServicesByCategory.Order_OrderId and
	 (OrderServicesByCategory.ServicesByCategory_ServiceId = RecordServicesByCategory.ServicesByCategory_ServiceId)
GROUP BY CarWasherSet.Surname
ORDER BY count(distinct OrderServicesByCategory.ServicesByCategory_ServiceId) - 
count(distinct RecordServicesByCategory.ServicesByCategory_ServiceId) DESC

/*10. Таблица статистики количества оказанных услуг работником для каждого класса.*/
DECLARE @columns VARCHAR(MAX), @sql VARCHAR(MAX);
SET @columns = '';

SELECT @columns += ', ' + QUOTENAME(col.[Название категории])
FROM 
	(SELECT CategoryOfCarSet.Description AS 'Название категории'
	FROM ServicesByCategorySet
	INNER JOIN CategoryOfCarSet ON CategoryOfCarSet.CategoryId = ServicesByCategorySet.CategoryOfCarCategoryId
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.ServicesByCategory_ServiceId = ServicesByCategorySet.ServiceId
	INNER JOIN OrderSet ON OrderSet.OrderId = OrderServicesByCategory.Order_OrderId
	INNER JOIN RecordSet ON RecordSet.RecordId = OrderSet.RecordRecordId
	GROUP BY CategoryOfCarSet.Description) AS col

SET @sql= 'SELECT * 
FROM 
	(SELECT CarWasherSet.Surname AS Автомойщик, COUNT(OrderServicesByCategory.ServicesByCategory_ServiceId) AS SERVICES, CategoryOfCarSet.Description AS CARS
	FROM RecordSet 
	INNER JOIN CarWasherSet ON CarWasherSet.CarWasherId = RecordSet.CarWasherCarWasherId
	INNER JOIN OrderSet ON RecordSet.RecordId = OrderSet.RecordRecordId
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.Order_OrderId = OrderSet.OrderId
	INNER JOIN ServicesByCategorySet ON ServicesByCategorySet.ServiceId = OrderServicesByCategory.ServicesByCategory_ServiceId
	INNER JOIN CategoryOfCarSet ON CategoryOfCarSet.CategoryId = ServicesByCategorySet.CategoryOfCarCategoryId
	GROUP BY CarWasherSet.Surname, CategoryOfCarSet.Description
	) AS temp 
PIVOT(MAX(temp.SERVICES) FOR temp.CARS IN (' +STUFF(@columns, 1, 2, '') +')) RESULT;';
EXECUTE(@sql)
