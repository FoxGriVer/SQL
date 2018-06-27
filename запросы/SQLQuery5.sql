SELECT distinct gr.Наименование
FROM Группы gr
INNER JOIN [Дисциплина в семестре] dvs ON gr.[ID группы] = dvs.[ID группы]
WHERE (dvs.[Номер семестра обучения] IN (1,2))
GROUP BY gr.Наименование, dvs.[Номер семестра обучения]
HAVING SUM(dvs.[Количество часов в неделю]) > 50