CREATE PROCEDURE Удаление_Студентов AS
DELETE Студенты
FROM Студенты 
INNER JOIN [Зачётная ведомость] zv ON Студенты.[ID студента] = zv.[ID студента]
WHERE zv.Отметка = 2