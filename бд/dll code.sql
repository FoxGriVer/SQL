/*
Created: 24.04.2017
Modified: 24.04.2017
Model: Физическая модель
Database: MS SQL Server 2016
*/


-- Create tables section -------------------------------------------------

-- Table Студенты

CREATE TABLE [Студенты]
(
 [ID студента] Uniqueidentifier NOT NULL,
 [Фамилия] Varchar(50) NOT NULL,
 [Имя] Varchar(50) NOT NULL,
 [Отчество] Varchar(50) NULL,
 [Пол] Bit NOT NULL,
 [Адрес проживания] Varchar(1000) NOT NULL,
 [Дата рождения] Date NOT NULL,
 [Уровень владения ИЯ] Varchar(50) NOT NULL
)
go

-- Add keys for table Студенты

ALTER TABLE [Студенты] ADD CONSTRAINT [ID Студента] PRIMARY KEY ([ID студента])
go

-- Table Студенты в группах

CREATE TABLE [Студенты в группах]
(
 [Код формы оплаты] Int NOT NULL,
 [ID студента] Uniqueidentifier NOT NULL,
 [ID группы] Uniqueidentifier NOT NULL
)
go

-- Add keys for table Студенты в группах

ALTER TABLE [Студенты в группах] ADD CONSTRAINT [Unique_Identifier2] PRIMARY KEY ([ID студента],[ID группы])
go

-- Table Формы оплаты

CREATE TABLE [Формы оплаты]
(
 [Код формы оплаты] Int NOT NULL,
 [Наименование] Varchar(100) NOT NULL
)
go

-- Add keys for table Формы оплаты

ALTER TABLE [Формы оплаты] ADD CONSTRAINT [Код формы оплаты] PRIMARY KEY ([Код формы оплаты])
go

-- Table Формы обучения

CREATE TABLE [Формы обучения]
(
 [Код формы обучения] Int NOT NULL,
 [Наименование] Varchar(100) NOT NULL
)
go

-- Add keys for table Формы обучения

ALTER TABLE [Формы обучения] ADD CONSTRAINT [Код формы обучения] PRIMARY KEY ([Код формы обучения])
go

-- Table Направления подготовки

CREATE TABLE [Направления подготовки]
(
 [Код направления подготовки] Char(8) NOT NULL,
 [Наименование] Varchar(100) NOT NULL
)
go

-- Add keys for table Направления подготовки

ALTER TABLE [Направления подготовки] ADD CONSTRAINT [Код направления подготовки] PRIMARY KEY ([Код направления подготовки])
go

-- Table Группы

CREATE TABLE [Группы]
(
 [ID группы] Uniqueidentifier NOT NULL,
 [Наименования] Varchar(10) NOT NULL,
 [Год поступления] Int NOT NULL,
 [Длительность обучения] Int NOT NULL,
 [Код формы обучения] Int NOT NULL,
 [Код направления подготовки] Char(8) NOT NULL,
 [ID института] Uniqueidentifier NOT NULL
)
go

-- Add keys for table Группы

ALTER TABLE [Группы] ADD CONSTRAINT [ID Группы] PRIMARY KEY ([ID группы])
go

-- Table Институты

CREATE TABLE [Институты]
(
 [ID института] Uniqueidentifier NOT NULL,
 [Наименование] Varchar(100) NOT NULL
)
go

-- Add keys for table Институты

ALTER TABLE [Институты] ADD CONSTRAINT [ID Института] PRIMARY KEY ([ID института])
go

-- Table Зачетная ведомость

CREATE TABLE [Зачетная ведомость]
(
 [Дата сдачи] Date NOT NULL,
 [Балл] Int NOT NULL,
 [Отметка] Int NOT NULL,
 [Литера] Char(2) NOT NULL,
 [ID студента] Uniqueidentifier NOT NULL,
 [ID группы] Uniqueidentifier NOT NULL,
 [ID дисциплины в семестре] Uniqueidentifier NOT NULL
)
go

-- Add keys for table Зачетная ведомость

ALTER TABLE [Зачетная ведомость] ADD CONSTRAINT [Дата сдачи] PRIMARY KEY ([Дата сдачи],[ID студента],[ID группы],[ID дисциплины в семестре])
go

-- Table Дисциплины в семестре

CREATE TABLE [Дисциплины в семестре]
(
 [ID дисциплины в семестре] Uniqueidentifier NOT NULL,
 [Номер семестра обучения] Int NOT NULL,
 [Количество часов в неделю] Int NOT NULL,
 [ID группы] Uniqueidentifier NOT NULL,
 [Код дисциплины] Varchar(15) NOT NULL,
 [Код формы контроля] Int NOT NULL,
 [ID преподавателя] Uniqueidentifier NOT NULL
)
go

-- Add keys for table Дисциплины в семестре

ALTER TABLE [Дисциплины в семестре] ADD CONSTRAINT [ID Дисциплины в семестре] PRIMARY KEY ([ID дисциплины в семестре])
go

-- Table Преподаватели

CREATE TABLE [Преподаватели]
(
 [ID преподавателя] Uniqueidentifier NOT NULL,
 [Фамилия] Varchar(50) NOT NULL,
 [Имя] Varchar(50) NOT NULL,
 [Отчество] Varchar(50) NOT NULL,
 [Должность] Varchar(50) NOT NULL,
 [Учёное звание] Varchar(50) NOT NULL,
 [Семейное положение] Varchar(50) NOT NULL,
 [ID института] Uniqueidentifier NOT NULL
)
go

-- Add keys for table Преподаватели

ALTER TABLE [Преподаватели] ADD CONSTRAINT [ID Преподавателя] PRIMARY KEY ([ID преподавателя])
go

-- Table Дисциплины

CREATE TABLE [Дисциплины]
(
 [Код дисциплины] Varchar(15) NOT NULL,
 [Наименование] Varchar(50) NOT NULL
)
go

-- Add keys for table Дисциплины

ALTER TABLE [Дисциплины] ADD CONSTRAINT [Код дисциплины] PRIMARY KEY ([Код дисциплины])
go

-- Table Формы контроля

CREATE TABLE [Формы контроля]
(
 [Код формы контроля] Int NOT NULL,
 [Наименование] Varchar(100) NOT NULL
)
go

-- Add keys for table Формы контроля

ALTER TABLE [Формы контроля] ADD CONSTRAINT [Код формы контроля] PRIMARY KEY ([Код формы контроля])
go

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE [Студенты в группах] ADD CONSTRAINT [Форма оплаты студента в группе] FOREIGN KEY ([Код формы оплаты]) REFERENCES [Формы оплаты] ([Код формы оплаты]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Студенты в группах] ADD CONSTRAINT [СГ-студенты] FOREIGN KEY ([ID студента]) REFERENCES [Студенты] ([ID студента]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Студенты в группах] ADD CONSTRAINT [СГ-группы] FOREIGN KEY ([ID группы]) REFERENCES [Группы] ([ID группы]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Зачетная ведомость] ADD CONSTRAINT [Проходят испытания] FOREIGN KEY ([ID студента], [ID группы]) REFERENCES [Студенты в группах] ([ID студента], [ID группы]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Группы] ADD CONSTRAINT [Форма обучения группы] FOREIGN KEY ([Код формы обучения]) REFERENCES [Формы обучения] ([Код формы обучения]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Группы] ADD CONSTRAINT [Направления подготовки группы] FOREIGN KEY ([Код направления подготовки]) REFERENCES [Направления подготовки] ([Код направления подготовки]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Группы] ADD CONSTRAINT [Группы в институте] FOREIGN KEY ([ID института]) REFERENCES [Институты] ([ID института]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Преподаватели] ADD CONSTRAINT [Работают] FOREIGN KEY ([ID института]) REFERENCES [Институты] ([ID института]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Дисциплины в семестре] ADD CONSTRAINT [Изучают] FOREIGN KEY ([ID группы]) REFERENCES [Группы] ([ID группы]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Дисциплины в семестре] ADD CONSTRAINT [Изучаются] FOREIGN KEY ([Код дисциплины]) REFERENCES [Дисциплины] ([Код дисциплины]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Дисциплины в семестре] ADD CONSTRAINT [Контролируются] FOREIGN KEY ([Код формы контроля]) REFERENCES [Формы контроля] ([Код формы контроля]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Дисциплины в семестре] ADD CONSTRAINT [Читают лекции] FOREIGN KEY ([ID преподавателя]) REFERENCES [Преподаватели] ([ID преподавателя]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Зачетная ведомость] ADD CONSTRAINT [Строка в зачетной книжке] FOREIGN KEY ([ID дисциплины в семестре]) REFERENCES [Дисциплины в семестре] ([ID дисциплины в семестре]) ON UPDATE NO ACTION ON DELETE NO ACTION
go




