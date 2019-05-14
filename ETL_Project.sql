create database ETLProject_db;
Use ETLProject_db;

-- create the first table (when we first did this we should have made country a varchar)
create table doctors (
	country Text,
    Year INT,
    DoctorsPerTenThousand Decimal(5,3),
    Doctors Int
    );

-- create the second table (when we first did this we should have made country a varchar)
create table malaria (
	country Text,
    Year INT,
    Deaths INT
);

-- preview both tables
select * from doctors;
select * from malaria;

-- change the table text columns to varchar in order to add the composite primary key
ALTER TABLE doctors MODIFY country varchar(100);
ALTER TABLE malaria MODIFY country varchar(100);

-- alter table to add a composite primary key
ALTER TABLE doctors
ADD CONSTRAINT Unique_Key PRIMARY KEY (country, Year);

ALTER TABLE malaria
ADD CONSTRAINT Unique_Key PRIMARY KEY (country, Year);

-- pull some example data based on a specific parameter: all the malaria deaths for 2014
-- using the countries from the doctors table
select doctors.country, malaria.deaths
from doctors
left join malaria
on doctors.country=malaria.country
and doctors.year=malaria.year
where doctors.year = 2014
order by doctors.country;

-- find the which countries from the malaria table that aren't in the doctors table
-- there is only 1: South Sudan
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
group by doctors.country
having sum(malaria.Deaths) is null;

-- find the number of distinct countries in both tables and
-- show the distinct countries of both tables
select count(distinct country) from doctors;
select count(distinct country) from malaria;
select distinct country from doctors;
select distinct country from malaria;

-- find the number of distinct countries found in doctors that aren't in malaria
select count(*) from
(select distinct doctors.country
from doctors
left join malaria
on doctors.country=malaria.country
group by doctors.country
having sum(malaria.Deaths) is null) as countryCount;


-- shows the sum of malaria deaths by country found in the doctors table
select doctors.country, sum(malaria.Deaths)
from doctors
left join malaria
on doctors.country=malaria.country
group by doctors.country