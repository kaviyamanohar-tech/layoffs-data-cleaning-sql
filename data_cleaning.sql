-- Data cleaning  project


select *
from layoffs;

-- removing duplicates
-- standardize the data
-- null values or blank values
-- remove any column


select *
from layoffs_staging;

insert layoffs_staging
select *
from layoffs;


select *,
ROW_NUMBER() OVER(partition by 
company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions ) as row_num
from layoffs_staging;

with duplicate_cte as
(
select *,
ROW_NUMBER() OVER(partition by 
company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions ) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num>1
;



CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num`int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select*
from layoffs_staging2;

insert into layoffs_staging2
select *,
ROW_NUMBER() OVER(partition by 
company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions ) as row_num
from layoffs_staging;

select *
from layoffs_staging2
where row_num>1;


delete
from layoffs_staging2
where row_num>1;

delete
from layoffs_staging2
where row_num>1;

use world_layoffs;

delete
from layoffs_staging2
where row_num>1;

select  *
from layoffs_staging2
;

-- standardizing data

select distinct (trim(company))
from layoffs_staging2
;

select company,trim(company)
from layoffs_staging2
;

update layoffs_staging2
set company= trim(company)
;

select *
from layoffs_staging2
;

select *
from layoffs_staging2
where industry like 'crypto%'
;
-- here we r selecting everything that is named as crypto

update layoffs_staging2
set industry= 'crypto'
where industry like 'crypto%'
;




select distinct location 
from layoffs_staging2
order by 1
;

-- we r checking location if there is any mess to check



-- then at country
select distinct country
from layoffs_staging2
order by 1
;

select * 
from layoffs_staging2
;

select *
from layoffs_staging2
where country like 'United states%'
order by 1
;

select distinct country,trim(country)
from layoffs_staging2
order by 1
;
-- this gives country and trim(country) as separate column.


select distinct country,trim(trailing '.'from country)
from layoffs_staging2
order by 1
;

update layoffs_staging2
 set country=trim(trailing '.'from country)
 where country='United states%'
 ;
 
 
 -- whhen we do visualizations later just we need to focus date
 
-- this literally changes the data type


select `date` ,
STR_TO_DATE(`date`,'%m/%d/%Y')
from layoffs_staging2
;


update layoffs_staging2
set `date`=STR_TO_DATE(`date`,' %m/%d/%Y')
;

select `date`
from layoffs_staging2
;

alter table layoffs_staging2
modify column`date` date;

select  *
from layoffs_staging2
;

-- null values taking off

select  *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null
; 
-- pretty useless

select  distinct industry
from layoffs_staging2
;

select *
from layoffs_staging2
where industry is null
or industry='';


select *
from layoffs_staging2
where company='airbnb'
;

-- we r updating travel in airbnb coz it is empty when we already knew which sector it is we r populating it



















SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
   ON t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null
;

SELECT t1.industry,t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
   ON t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null
;


update layoffs_staging2 t1
join layoffs_staging2 t2
   on t1.company= t2.company 
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null
;


-- the above code doesnt actually worked bcoz blanks are diff from nulls
update layoffs_staging2
set industry = null
where industry='';


select *
from layoffs_staging2
where company like 'Bally%'
;


select *
from layoffs_staging2
;


delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null
; 


select *
from layoffs_staging2
;

alter table layoffs_staging2
drop column row_num
;