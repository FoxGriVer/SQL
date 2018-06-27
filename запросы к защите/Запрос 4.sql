SELECT Г.Наименование
FROM dbo.Группы Г LEFT JOIN dbo.[Студенты в группах] СГ 
ON Г.[ID группы] = СГ.[ID группы]
LEFT JOIN dbo.Студенты С
ON С.[ID студента] = СГ.[ID студента]
where СГ.[ID группы] IS NULL