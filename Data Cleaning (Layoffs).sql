SELECT * FROM aniket.layoffs;

update layoffs
set percentage_laid_off = 0
where percentage_laid_off is null; 

update layoffs
set Total_laid_off = 0
where Total_laid_off is null;

update layoffs
set funds_raised_millions = 0
where funds_raised_millions is null; 

update layoffs
set industry = 'Other'
where industry is null;  

alter table layoffs
modify date date;


-- create new table
create table staging 
like layoffs;

-- insert into row data
insert staging
select *
from layoffs;

-- insert into staging

CREATE TABLE `staging_` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_no` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into 
staging_ 
select * , 
row_number () over (partition by company , location , industry, total_laid_off , percentage_laid_off , 'date' , stage ,country , funds_raised_millions) as row_no from staging;

-- Delete duplicate data

delete from staging_
where row_no>1;

-- checking the complete data stagging where row_no>1

select * from	staging_
where row_no>1;

-- serially checking the data colums of industry

select distinct industry
from staging_ order by 1;

-- removing white space from company

select company , trim(company)
from staging_ ;

update staging_
set company = trim(company);

-- sandardizing the data

update staging_
set industry = 'crypto'
where industry like 'Crypto%';

-- checking the distinct locations for need of standardization

select distinct country
from staging_
order by 1;

-- found . after united states.
select distinct country , trim(trailing '.' from country)
from staging_
order by 1;

update staging_
set country = trim(trailing '.' from country )
where country like 'United states%';

-- Standardizing the data string to a date format
select `date`,
str_to_date(`date`,'%m/%d/%Y')
from staging_;

update staging_
set `date` = case
when `date` like '%/%/%' then str_to_date(`date`,'%m/%d/%Y')
when `date` like '%-%-%' then str_to_date(`date`,'%Y-%m-%d')
else null
end;
 select `date` from staging;

-- Removing the null datas

 select *
 from staging_ s1
 join staging_ s2
 on s1.company = s2.company and s1.location = s2.location
 where s1.industry is null or s1.industry='' 
       and s2.industry is not null;

-- populating the null values for industry of the same company and location

update staging_ s1
join staging_ s2
on s1.company = s2.company and s1.location = s2.location 
set s1.industry = s2.industry
where s1.industry is null 
and s2.industry is not null;

select * from staging_;

alter table staging_
modify `date` date;

select * from staging;








