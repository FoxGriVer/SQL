CREATE LOGIN OurAdmin
WITH PASSWORD = 'admin123',
DEFAULT_DATABASE = CarWash

CREATE LOGIN OurManager
WITH PASSWORD = 'manager123',
DEFAULT_DATABASE = CarWash

CREATE LOGIN OurClient
WITH PASSWORD = 'client123',
DEFAULT_DATABASE = CarWash

CREATE USER ������������� FOR LOGIN OurAdmin;
CREATE USER �������� for LOGIN OurManager;
CREATE USER ������ for LOGIN OurClient;
