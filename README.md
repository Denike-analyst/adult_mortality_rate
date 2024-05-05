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
  
GROUP BY Continent

--Showing the relation between health expenditure and crude death rate between 2019, 2020, and 2021
SELECT h.Countries, CEILING(h.Year_2019) AS hexp_19, CEILING(h.Year_2020) AS hexp_20, CEILING(h.Year_2021) AS hexp_21, 
CEILING(c.Year_2019) AS dr_19, CEILING(c.Year_2020) AS dr_19, CEILING(c.Year_2021) AS dr_2021
FROM health_expenditure h INNER JOIN crude_death_rate c
ON h.Countries = c.Countries
