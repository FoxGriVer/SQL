CREATE PROCEDURE [Добавить дисциплину2]
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
INSERT INTO [Дисциплина в семестре]([Код дисциплницы], [Количество часов в неделю], [Код формы контроля], 
[Номер семестра обучения], [ID лектора], [ID группы] )
VALUES(@code_of_disc, @number_of_hours, @code_of_controll, @semester,
(SELECT [ID Преподавателя]
FROM Преподаватели
WHERE Имя = @name AND Фамилия = @surname AND Отчество = @patr),
(SELECT [ID группы]
FROM Группы
WHERE [Год поступления] = @year_of_recipt AND Наименование = @group_name)
)