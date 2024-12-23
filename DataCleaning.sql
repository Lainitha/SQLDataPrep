-- Data Cleaning
Select *
from layoffs;


-- 1.Remove Duplicates
-- 2. Standertize Data
-- 3. Null Values or Non values
-- 4. Remove Any columns


CREATE TABLE layoffs_stagging
like layoffs;


select *
from layoffs_stagging;

insert layoffs_stagging
select *
from layoffs;


select *,
row_number() over(
PARTITION BY company, location, industry, total_laid_off,percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
from layoffs_stagging;


with duplicate_cte as
(
select *,
row_number() over(
PARTITION BY company, location, industry, total_laid_off,percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
from layoffs_stagging
)

select *
from duplicate_cte
where row_num > 1;



select *
from layoffs_stagging
where company = "100 Thieves";

CREATE TABLE `layoffs_stagging2` (
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
from layoffs_stagging2;

insert into layoffs_stagging2
select *,
row_number() over(
PARTITION BY company, location, industry, total_laid_off,percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
from layoffs_stagging;


select *
from layoffs_stagging2
where row_num>1;

DELETE   
from layoffs_stagging2 
where row_num > 1;


-- standadize the data

select distinct company
from layoffs_stagging2;

select distinct TRIM(company)
from layoffs_stagging2;

select company , TRIM(company)
from layoffs_stagging2;

Update layoffs_stagging2
set company = TRIM(company);

-- done
-- now for industry column

select distinct industry
from layoffs_stagging2
order by 1;

select *
from layoffs_stagging2
where industry like 'Crypto%';

update layoffs_stagging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct industry
from layoffs_stagging2;

select distinct country
from layoffs_stagging2
order by 1;

select *
from layoffs_stagging2
where country like 'United States%'
order by 1;

select distinct country , TRIM(TRAILING '.' from country)
from layoffs_stagging2
order by 1;

update layoffs_stagging2
set counntry = TRIM(TRAILING '.' from country)
where country like 'United States%';

select distinct country
from layoffs_stagging2;

select `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
from layoffs_stagging2;

update layoffs_stagging2
set `date`= STR_TO_DATE(`date`,'%m/%d/%Y');

Alter table layoffs_stagging2
modify column `date` DATE;








