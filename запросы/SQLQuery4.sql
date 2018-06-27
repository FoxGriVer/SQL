CREATE VIEW Сдача_В_Сентябре AS
SELECT st.Имя, st.Фамилия, st.Отчество, it.Наименование AS Институт, zv.[Дата сдачи]
FROM Студенты st
INNER JOIN [Студенты в группах] svg ON st.[ID студента] = svg.[ID студента]
INNER JOIN Группы gr ON gr.[ID группы] = svg.[ID группы]
INNER JOIN Институты it ON IT.[ID института] = gr.[ID института]
INNER JOIN [Зачётная ведомость] zv ON zv.[ID студента] = st.[ID студента]
WHERE (zv.[Дата сдачи] BETWEEN '2014-09-01' AND '2014-09-30' )
