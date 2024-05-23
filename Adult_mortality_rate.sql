SELECT * FROM Adult_mortality_rate

SELECT * FROM Population

SELECT * FROM crude_death_rate

SELECT * FROM health_expenditure

SELECT * FROM GDP


-- The result from this query shows that 32 African countries had a population greater than 75000 in 2021 and their health expenditure for 2019 was lower than 35.
SELECT p.Countries, a.Continent FROM Population p
INNER JOIN health_expenditure h ON p.Countries = h.Countries
INNER JOIN Adult_mortality_rate a ON a.Countries = h.Countries
WHERE Continent = 'Africa' 
AND p.Year_2021 > 75000 AND h.Year_2019 < 35


--The result from this query shows the top 5 European countries in terms of GDP and low female adult mortality rate
SELECT TOP 5 g.Countries, a.Continent FROM GDP g
INNER JOIN Adult_mortality_rate a ON a.Countries = g.Countries
WHERE Continent = 'Europe'
ORDER BY GDP DESC, AMR_female ASC

--The result from this query shows the Asian countries in the top 10 for population in 2019, where 3 of these countries have the lowest health expenditures. 

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


--The result from this query shows the total average of both male and female adult mortality rate for continents
      
SELECT Continent, CEILING(SUM(AMR_female)) AS total_female, CEILING(SUM(AMR_male)) AS total_male 
FROM Adult_mortality_rate
GROUP BY Continent

--The result from this query shows the relation between health expenditure and crude death rate between 2019, 2020, and 2021 for all the countries\
      
SELECT h.Countries, CEILING(h.Year_2019) AS hexp_19, CEILING(h.Year_2020) AS hexp_20, CEILING(h.Year_2021) AS hexp_21, 
CEILING(c.Year_2019) AS dr_19, CEILING(c.Year_2020) AS dr_19, CEILING(c.Year_2021) AS dr_2021
FROM health_expenditure h INNER JOIN crude_death_rate c
ON h.Countries = c.Countries





