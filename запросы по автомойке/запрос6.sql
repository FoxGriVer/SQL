/*������� ������� � ������������ ������ ������������� ���� � ������� � �������� �������� ����*/
CREATE PROCEDURE DeferenceBetweenTwoYears
(@_year INT, @_month INT) AS
DECLARE @YEAR INT,
	@PASTYEAR INT,
	@MONTH INT

SET @YEAR = @_year;
SET @PASTYEAR = @YEAR - 1;
SET @_month = 12;

SELECT Seasons.Description AS '�����', @YEAR AS '���', 
SUM(ServicesByCategorySet.Price) AS '������� � ������ ����',
SUM(ServicesByCategorySet.Price) - 
	(SELECT SUM(ServicesByCategorySet.Price)
	FROM RecordSet
		INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
		INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.Order_OrderId = OrderSet.OrderId
		INNER JOIN ServicesByCategorySet ON ServicesByCategorySet.ServiceId = OrderServicesByCategory.ServicesByCategory_ServiceId
		INNER JOIN Seasons ON RecordSet.NumberOfSeason = Seasons.NumberOfMount
	WHERE MONTH(RecordSet.DateTime) = @MONTH AND YEAR(RecordSet.DateTime) = @PASTYEAR
	GROUP BY Seasons.Description
	) AS '������� � ������� �����'
FROM RecordSet
	INNER JOIN OrderSet ON OrderSet.RecordRecordId = RecordSet.RecordId
	INNER JOIN OrderServicesByCategory ON OrderServicesByCategory.Order_OrderId = OrderSet.OrderId
	INNER JOIN ServicesByCategorySet ON ServicesByCategorySet.ServiceId = OrderServicesByCategory.ServicesByCategory_ServiceId
	INNER JOIN Seasons ON RecordSet.NumberOfSeason = Seasons.NumberOfMount
WHERE MONTH(RecordSet.DateTime) = @MONTH AND YEAR(RecordSet.DateTime) = @YEAR
GROUP BY Seasons.Description
ORDER BY SUM(ServicesByCategorySet.Price) DESC

