CREATE PROCEDURE ���������_������������� AS 
UPDATE �������������
SET [ID �������������] = (SELECT [ID �������������] FROM ������������� WHERE ������� = '�������')
FROM ������������� 
INNER JOIN [���������� � ��������] ON �������������.[ID �������������] = [���������� � ��������].[ID �������]
INNER JOIN ������ ON ������.[ID ������] = [���������� � ��������].[ID ������]
WHERE ������.������������ = '8�42'