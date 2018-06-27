SELECT ClientSet.Surname + ' ' + ClientSet.Name + '' + ClientSet.Patronymic AS 'Ф.И.О.', ROW_NUMBER() OVER(PARTITION BY ClientSet.Surname + ' ' + ClientSet.Name + '' + ClientSet.Patronymic
ORDER BY CarSet.Mark, CarSet.Model) AS '№ п/п',
 CarSet.Mark AS 'Марка', CarSet.Model AS 'Модель',  COUNT(RecordSet.RecordId) AS 'Кол-во посещений'
FROM RecordSet
INNER JOIN CarClientSet ON CarClientSet.CarNumber = RecordSet.CarClientCarNumber
INNER JOIN ClientSet ON ClientSet.ClientId = CarClientSet.ClientClientId
INNER JOIN CarSet ON CarSet.CarId = CarClientSet.CarCarId
GROUP BY ClientSet.Surname + ' ' + ClientSet.Name + '' + ClientSet.Patronymic, CarSet.Mark, CarSet.Model
ORDER BY ClientSet.Surname + ' ' + ClientSet.Name + '' + ClientSet.Patronymic
