select ������.������������, Count(case when ��������.���='true' then 1 end) as '���', Count(case when ��������.���='false' then 1 end) as '���' 
from [�������� � �������] 
inner join [������] on [������].[ID ������]=[�������� � �������].[ID ������] 
inner join [��������] on [��������].[ID ��������]=[�������� � �������].[ID ��������] 
group by ������.������������