# Analysis on Adult Mortality rate between 2019 and 2022

### Project Overview

This project aims to get insights from datesets on adult mortality rate from different countries between 2019 and 2022 and how it relates to their Population and GDP. Analyzing this datasets gives insights on the impact of health expenditure on adult mortality rate.

### Data sources

Multiple tables datasets were used to do this analysis. These datasets include: 

### Tools

- Excel (Data cleaning)
- SQL (Data manipulation)
- Powerbi (visualization)

### Exploratory Data Analysis

These key questions were answered by analyzing these datasets:

- Does increased spending on healthcare lead to a decrease in adult deaths?
- Do wealthier countries spend more on healthcare?
  
## Data manipulation in SQL

SELECT * FROM Adult_mortality_rate

SELECT * FROM Population

SELECT * FROM crude_death_rate

SELECT * FROM health_expenditure

SELECT * FROM GDP


--African countries where population in 2021 was greater than 75000 and their health expenditure for 2019 was lower than 35
SELECT p.Countries, a.Continent FROM Population p
INNER JOIN health_expenditure h ON p.Countries = h.Countries
INNER JOIN Adult_mortality_rate a ON a.Countries = h.Countries
WHERE Continent = 'Africa' 
AND p.Year_2021 > 75000 AND h.Year_2019 < 35


--SHOW THE TOP 5 EUROPEAN COUNTRIES IN TERMS OF GDP AND LOW FEMALE ADULT MORTALITY RATE
SELECT TOP 5 g.Countries, a.Continent FROM GDP g
INNER JOIN Adult_mortality_rate a ON a.Countries = g.Countries
WHERE Continent = 'Europe'
ORDER BY GDP DESC, AMR_female ASC

--Among the Asian countries in the top 10 for population in 2019, theses are the 3 countries with lowest health expenditures. 

SELECT TOP 3 h.Year_2019 AS hexp_2019, h.Countries FROM health_expenditure h
INNER JOIN (
      SELECT DISTINCT TOP 10 p.Year_2019, p.Countries FROM Population p
      INNER JOIN Adult_mortality_rate a ON
      a.Countries = p.Countries
      WHERE Continent = 'Asia'
      ORDER BY p.Year_2019 DESC
) AS p ON h.Countries = p.Countries
WHERE h.Year_2019 IS NOT NULL
ORDER BY h.Year_2019 ASC


--Getting the total average of both male and female adult mortality rate for continents
SELECT Continent, CEILING(SUM(AMR_female)) AS total_female, CEILING(SUM(AMR_male)) AS total_male 
FROM Adult_mortality_rate
GROUP BY Continent

--Showing the relation between health expenditure and crude death rate between 2019, 2020, and 2021
SELECT h.Countries, CEILING(h.Year_2019) AS hexp_19, CEILING(h.Year_2020) AS hexp_20, CEILING(h.Year_2021) AS hexp_21, 
CEILING(c.Year_2019) AS dr_19, CEILING(c.Year_2020) AS dr_19, CEILING(c.Year_2021) AS dr_2021
FROM health_expenditure h INNER JOIN crude_death_rate c
ON h.Countries = c.Countries
