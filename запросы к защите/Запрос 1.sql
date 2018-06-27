SELECT Г.Наименование, COUNT(Г.Наименование)
FROM dbo.Группы Г INNER JOIN dbo.[Студенты в группах] СГ 
ON Г.[ID группы] = СГ.[ID группы]
INNER JOIN dbo.Студенты С
ON С.[ID студента] = СГ.[ID студента]
GROUP BY Г.Наименование