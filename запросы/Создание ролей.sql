CREATE LOGIN OurAdmin
WITH PASSWORD = 'admin123',
DEFAULT_DATABASE = CarWash

CREATE LOGIN OurManager
WITH PASSWORD = 'manager123',
DEFAULT_DATABASE = CarWash

CREATE LOGIN OurClient
WITH PASSWORD = 'client123',
DEFAULT_DATABASE = CarWash

CREATE USER Администратор FOR LOGIN OurAdmin;
CREATE USER Менеджер for LOGIN OurManager;
CREATE USER Клиент for LOGIN OurClient;
