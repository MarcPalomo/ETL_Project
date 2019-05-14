create database ETLProject_db;
Use ETLProject_db;

-- create the first table
create table doctors (
	country Text,
    Year INT,
    DoctorsPerTenThousand Decimal(5,3),
    Doctors Int
    );

-- create the second table
create table malaria (
	country Text,
    Year INT,
    Deaths INT
);

-- preview both tables
select * from doctors;
select * from malaria;

-- pull some example data based on a specific parameter
select doctors.country, malaria.deaths
from doctors
left join malaria
on doctors.country=malaria.country
and doctors.year=malaria.year
where doctors.year = 2014
order by doctors.country;

-- find the country from the malaria table that isn't in the doctors table
select distinct malaria.country
from malaria
left join doctors
on doctors.country=malaria.country
where doctors.doctors is null;

-- find the countries from the doctor table that aren't in the malaria table
select distinct doctors.country
from doctors
left join malaria
on doctors.country=malaria.country
where malaria.Deaths is null;

-- display the distinct countries from both tables separately
select distinct country from doctors;
select distinct country from malaria;

-- change the table text columns to varchar in order to add the composite primary key
ALTER TABLE doctors MODIFY country varchar(100);
ALTER TABLE malaria MODIFY country varchar(100);

-- alter table to add a composite primary key
ALTER TABLE doctors
ADD CONSTRAINT Unique_Key PRIMARY KEY (country, Year);

ALTER TABLE malaria
ADD CONSTRAINT Unique_Key PRIMARY KEY (country, Year);

-- there is no new column
select * from doctors;
select * from malaria;
