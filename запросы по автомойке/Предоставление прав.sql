/* ADMIN */
GRANT SELECT TO �������������
GRANT INSERT TO �������������
GRANT UPDATE TO �������������
GRANT EXEC TO �������������

/* MANAGER */
GRANT SELECT TO ��������
GRANT INSERT TO ��������
GRANT UPDATE TO ��������

GRANT EXEC ON ClientsInMonths TO ��������

DENY INSERT ON ServicesByCategorySet TO ��������
DENY INSERT ON WorkSchedule  TO ��������
DENY UPDATE ON ServicesByCategorySet TO ��������
DENY UPDATE ON WorkSchedule  TO ��������

/* CLIENT */
GRANT SELECT ON TO ������
GRANT INSERT TO ������
GRANT UPDATE TO ������
