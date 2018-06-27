/* ADMIN */
GRANT SELECT TO Администратор
GRANT INSERT TO Администратор
GRANT UPDATE TO Администратор
GRANT EXEC TO Администратор

/* MANAGER */
GRANT SELECT TO Менеджер
GRANT INSERT TO Менеджер
GRANT UPDATE TO Менеджер

GRANT EXEC ON ClientsInMonths TO Менеджер

DENY INSERT ON ServicesByCategorySet TO Менеджер
DENY INSERT ON WorkSchedule  TO Менеджер
DENY UPDATE ON ServicesByCategorySet TO Менеджер
DENY UPDATE ON WorkSchedule  TO Менеджер

/* CLIENT */
GRANT SELECT ON TO Клиент
GRANT INSERT TO Клиент
GRANT UPDATE TO Клиент
