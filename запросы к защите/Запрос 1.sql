SELECT �.������������, COUNT(�.������������)
FROM dbo.������ � INNER JOIN dbo.[�������� � �������] �� 
ON �.[ID ������] = ��.[ID ������]
INNER JOIN dbo.�������� �
ON �.[ID ��������] = ��.[ID ��������]
GROUP BY �.������������