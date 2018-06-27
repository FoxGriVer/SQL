SELECT gr1.Наименование, COUNT(case when fo.[Код формы оплаты] = '1' then 1 end) AS 'Бюджет',
COUNT(case when fo.[Код формы оплаты] = '2' then 1 end) AS 'Договор',
COUNT(case when fo.[Код формы оплаты] = '3' then 1 end) AS 'Целевая'
FROM [Студенты в группах] svg
INNER JOIN Группы gr1 ON svg.[ID группы] = gr1.[ID группы]
inner join [Формы оплаты] fo ON fo.[Код формы оплаты] = svg.[Код формы оплаты]
GROUP BY gr1.Наименование
