CREATE PROCEDURE ClientsInMonths
(@service VARCHAR(MAX), @month INT ) AS
SELECT ClientSet.Surname AS 'Фамилия рабочего'
FROM RecordSet
INNER JOIN CarClientSet ON CarClientSet.CarNumber = RecordSet.CarClientCarNumber
INNER JOIN ClientSet ON CarClientSet.ClientClientId = ClientSet.ClientId
INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.Order_OrderId = OrderSet.OrderId
INNER JOIN ServicesByCategorySet ON ServicesByCategorySet.ServiceId = OrderServicesByCategory.ServicesByCategory_ServiceId
INNER JOIN ServicesSet ON ServicesSet.CodeService = ServicesByCategorySet.ServicesCodeService
WHERE ServicesSet.Description = @service AND MONTH(RecordSet.DateTime) = @month
GROUP BY ClientSet.Surname, ServicesSet.Description
