select �.�������, COUNT(�.[ID ������])
from dbo.�������� � inner join dbo.[�������� � �������] ��
ON �.[ID ��������] = ��.[ID ��������]
inner join dbo.������ �
ON ��.[ID ������] = �.[ID ������]
WHERE �.[��� �����������] = 2014
GROUP BY �.�������