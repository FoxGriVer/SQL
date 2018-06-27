select Группы.Наименование, Count(case when Студенты.Пол='true' then 1 end) as 'Муж', Count(case when Студенты.Пол='false' then 1 end) as 'Жен' 
from [Студенты в группах] 
inner join [Группы] on [Группы].[ID группы]=[Студенты в группах].[ID группы] 
inner join [Студенты] on [Студенты].[ID студента]=[Студенты в группах].[ID студента] 
group by Группы.Наименование