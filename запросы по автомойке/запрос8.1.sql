SELECT CarWasherSet.Surname, work1.Month, work1.Year, work1.NumberOfHours,
work2.Month, work2.Year, work2.NumberOfHours,
WORK3.Month, WORK3.Year, WORK3.NumberOfHours
FROM RecordSet
INNER JOIN CarWasherSet ON RecordSet.CarWasherCarWasherId = CarWasherSet.CarWasherId
INNER JOIN WorkSchedule as work1 ON work1.CarWasherId = CarWasherSet.CarWasherId
LEFT JOIN WorkSchedule AS work2 ON work2.CarWasherId = CarWasherSet.CarWasherId AND work1.Month + 1 = work2.Month
AND work1.Year = work2.Year
LEFT JOIN WorkSchedule AS work3 ON WORK3.CarWasherId = CarWasherSet.CarWasherId AND work1.Month - 11 = work3.Month 
AND work1.Year + 1 = work3.Year
WHERE work1.NumberOfHours > 120 AND (work2.NumberOfHours > 120 OR work3.NumberOfHours > 120)
GROUP BY CarWasherSet.Surname, work1.Month, work1.Year, work1.NumberOfHours, work1.CarWasherId,
work2.Month, work2.Year, work2.NumberOfHours,
WORK3.Month, WORK3.Year, WORK3.NumberOfHours
ORDER BY CarWasherSet.Surname, work1.Month, work1.Year, work1.NumberOfHours

