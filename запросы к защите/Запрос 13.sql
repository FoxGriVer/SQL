select �.�������, �.���, �.��������,�.������������, cast(AVG(��.�������*1.0) as decimal(3,2))
from dbo.�������� � inner join dbo.[�������� � �������] ��
on �.[ID ��������] = ��.[ID ��������]
inner join dbo.[�������� ���������] ��
on ��.[ID ��������] = ��.[ID ��������] and ��.[ID ������] = ��.[ID ������]
inner join dbo.������ �
on �.[ID ������] = ��.[ID ������]
group by �.�������, �.���, �.��������, �.[ID ��������], �.������������