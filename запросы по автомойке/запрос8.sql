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

