select �.������������, count(DISTINCT ��.[��� ����� ��������]) as '���-��'
from dbo.���������� � inner join dbo.[���������� � ��������] ��
on �.[��� ����������] = ��.[��� ����������]
inner join dbo.[����� ��������] ��
on ��.[��� ����� ��������] = ��.[��� ����� ��������]
GROUP BY �.������������
HAVING count(DISTINCT ��.[��� ����� ��������]) > 1