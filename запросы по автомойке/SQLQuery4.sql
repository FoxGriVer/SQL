SELECT ClientSet.Surname + ' ' + ClientSet.Name + '' + ClientSet.Patronymic AS '�.�.�.', ROW_NUMBER() OVER(PARTITION BY ClientSet.Surname + ' ' + ClientSet.Name + '' + ClientSet.Patronymic
ORDER BY CarSet.Mark, CarSet.Model) AS '� �/�',
 CarSet.Mark AS '�����', CarSet.Model AS '������',  COUNT(RecordSet.RecordId) AS '���-�� ���������'
FROM RecordSet
INNER JOIN CarClientSet ON CarClientSet.CarNumber = RecordSet.CarClientCarNumber
INNER JOIN ClientSet ON ClientSet.ClientId = CarClientSet.ClientClientId
INNER JOIN CarSet ON CarSet.CarId = CarClientSet.CarCarId
GROUP BY ClientSet.Surname + ' ' + ClientSet.Name + '' + ClientSet.Patronymic, CarSet.Mark, CarSet.Model
ORDER BY ClientSet.Surname + ' ' + ClientSet.Name + '' + ClientSet.Patronymic
