select �.�������, COUNT(��.�������)
from dbo.�������� � inner join dbo.[�������� � �������] ��
on �.[ID ��������] = ��.[ID ��������]
inner join dbo.[�������� ���������] ��
on ��.[ID ��������] = ��.[ID ��������] and ��.������� = 3
group by �.�������
having COUNT(��.�������)<2