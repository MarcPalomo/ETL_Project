create database ETLProject_db;
Use ETLProject_db;


create table doctors (
	country Text,
    Year INT,
    DoctorsPerTenThousand Decimal(5,3),
    Doctors Int
    );
    
create table malaria (
	country Text,
    Year INT,
    Deaths INT
);

select * from doctors;
select * from malaria;


select doctors.country, malaria.deaths
from doctors
left join malaria
on doctors.country=malaria.country
and doctors.year=malaria.year
where doctors.year = 2014
order by doctors.country;


