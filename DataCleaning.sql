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






