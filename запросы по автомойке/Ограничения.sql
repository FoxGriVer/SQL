ALTER TABLE WorkSchedule
ADD CONSTRAINT NumberOfHours CHECK (NumberOfHours <= 300),
CONSTRAINT Years CHECK (WorkSchedule.Years >= 2016),
CONSTRAINT Months CHECK (WorkSchedule.Months >= 1 AND WorkSchedule.Months <= 12);

ALTER TABLE CarClientSet
ADD CONSTRAINT CarNumber CHECK (CarNumber LIKE '[0-9][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9]' 
	OR dist_id LIKE '[0-9][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9]');
