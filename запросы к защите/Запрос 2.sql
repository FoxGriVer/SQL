SELECT �.������������, COUNT(CASE WHEN �.��� = 'true' THEN 1 END)
FROM dbo.������ � INNER JOIN dbo.[�������� � �������] �� 
ON �.[ID ������] = ��.[ID ������]
INNER JOIN dbo.�������� �
ON �.[ID ��������] = ��.[ID ��������]
GROUP BY �.������������