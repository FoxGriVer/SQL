CREATE VIEW �����_�_�������� AS
SELECT st.���, st.�������, st.��������, it.������������ AS ��������, zv.[���� �����]
FROM �������� st
INNER JOIN [�������� � �������] svg ON st.[ID ��������] = svg.[ID ��������]
INNER JOIN ������ gr ON gr.[ID ������] = svg.[ID ������]
INNER JOIN ��������� it ON IT.[ID ���������] = gr.[ID ���������]
INNER JOIN [�������� ���������] zv ON zv.[ID ��������] = st.[ID ��������]
WHERE (zv.[���� �����] BETWEEN '2014-09-01' AND '2014-09-30' )
