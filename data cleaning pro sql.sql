use demoo;
drop database demoo;
select * from demoo;

create database layoff;
select * from layoffs;
use layoffs;

create table layoffs_staging
like layoffs;

select * from layoffs_staging;
insert layoffs_staging
select * from layoffs;

select *,
Row_number() over(
Partition by company, industry, total_laid_off, percentage_laid_off,'date') as row_num
from layoffs_staging;

with duplicate_cte as
(
select *,
row_number() over(
partition by company,location, industry, total_laid_off, percentage_laid_off,'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num >1;

select* 
from layoffs_staging
where company = 'casper';


with duplicate_cte as
(
select *,
row_number() over(
partition by company,location, industry, total_laid_off, percentage_laid_off,'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
 delete
from duplicate_cte
where row_num >1;


CREATE TABLE `layoffs_staging2`(
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select* 
from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(
partition by company,location, industry, total_laid_off, percentage_laid_off,'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging;

select* 
from layoffs_staging2
where row_num > 1;

delete
from layoffs_staging2
where row_num > 1;

select* 
from layoffs_staging2;

## standardizing data


select distinct(company)
from layoffs_staging2;

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

use layoff;

select industry
from layoffs_staging2;

select distinct industry
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where industry like 'crypto%';

update layoffs_staging2
set industry = 'crypto'
where industry like 'crypto%';

select * 
from layoffs_staging2;

select distinct location
from layoffs_staging2;

select distinct location
from layoffs_staging2
order by 1;


select distinct country
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where country like 'united state%'
order by 1;


select distinct country, trim(country)
from layoffs_staging2
order by 1;


select distinct country, trim(country)
from layoffs_staging2
order by 1;


select distinct country, trim(trailing ',' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing ',' from country)
where country like 'united states%';


select * from layoffs_staging2;

select date ,
str_to_date(date , '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set date = str_to_date( date , '%m/%d/%Y');

alter table layoffs_staging2
modify column date  DATE;

select * from layoffs_staging2;

select * 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;


select distinct industry
from layoffs_staging2;


select *
from layoffs_staging2
where industry is null
or industry = '';

select *
from layoffs_staging2
where company = 'Airbnb';

select * 
from layoffs_staging2 t1
join layoffs_staging t2
     on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;  

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging t2
     on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null; 


update layoffs_staging2
set industry = null
where industry = '';


select *
from layoffs_staging2
where company like 'bally%';

select * from layoffs_staging;

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoffs_staging;

alter table layoffs_staging2
drop column row_num;


