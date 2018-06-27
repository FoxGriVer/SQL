select С.Фамилия, COUNT(Г.[ID группы])
from dbo.Студенты С inner join dbo.[Студенты в группах] СГ
ON С.[ID студента] = СГ.[ID студента]
inner join dbo.Группы Г
ON СГ.[ID группы] = Г.[ID группы]
WHERE Г.[Год поступления] = 2014
GROUP BY С.Фамилия