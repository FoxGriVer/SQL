SELECT gr1.������������, COUNT(case when fo.[��� ����� ������] = '1' then 1 end) AS '������',
COUNT(case when fo.[��� ����� ������] = '2' then 1 end) AS '�������',
COUNT(case when fo.[��� ����� ������] = '3' then 1 end) AS '�������'
FROM [�������� � �������] svg
INNER JOIN ������ gr1 ON svg.[ID ������] = gr1.[ID ������]
inner join [����� ������] fo ON fo.[��� ����� ������] = svg.[��� ����� ������]
GROUP BY gr1.������������
