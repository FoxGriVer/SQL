select DISTINCT(С.Фамилия)
from dbo.Студенты С inner join dbo.[Студенты в группах] СГ
on С.[ID студента] = СГ.[ID студента]
inner join dbo.[Зачетная ведомость] ЗВ
on СГ.[ID студента] = ЗВ.[ID студента]
where 


