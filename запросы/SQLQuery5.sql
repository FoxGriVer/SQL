SELECT distinct gr.������������
FROM ������ gr
INNER JOIN [���������� � ��������] dvs ON gr.[ID ������] = dvs.[ID ������]
WHERE (dvs.[����� �������� ��������] IN (1,2))
GROUP BY gr.������������, dvs.[����� �������� ��������]
HAVING SUM(dvs.[���������� ����� � ������]) > 50