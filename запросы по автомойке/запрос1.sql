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
