CREATE PROCEDURE [�������� ����������2]
	@code_of_disc varchar(15),
	@number_of_hours int,
	@code_of_controll int,
	@semester int,
	@group_name varchar(10),
	@year_of_recipt int,
	@name varchar(50),
	@surname varchar(50),
	@patr varchar(50)
AS
INSERT INTO [���������� � ��������]([��� �����������], [���������� ����� � ������], [��� ����� ��������], 
[����� �������� ��������], [ID �������], [ID ������] )
VALUES(@code_of_disc, @number_of_hours, @code_of_controll, @semester,
(SELECT [ID �������������]
FROM �������������
WHERE ��� = @name AND ������� = @surname AND �������� = @patr),
(SELECT [ID ������]
FROM ������
WHERE [��� �����������] = @year_of_recipt AND ������������ = @group_name)
)