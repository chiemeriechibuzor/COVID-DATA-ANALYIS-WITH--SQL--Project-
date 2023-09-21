# Covidprojectanalysis

Here are summaries and documentation for each of the SQL data exploration tasks I worked on:

**Task 1: Retrieving COVID-19 Data by Location and Date**

This SQL query retrieves specific columns (location, date, total_cases, total_deaths, new_cases, and population) from the `coviddeath1` table, filtering for rows where the continent is not null. The results are ordered by location and date.

**Task 2: Calculating Death Percentage for COVID-19**

This query calculates the death percentage for COVID-19 cases by dividing total_deaths by total_cases and multiplying the result by 100. It focuses on locations with the word "state" in their names and where the continent is not null. The results are sorted by location and date.

**Task 3: Calculating Death Percentage for COVID-19 in Nigeria**

Similar to Task 2, this query calculates the death percentage for COVID-19 cases but specifically for locations containing "Nigeria" in their names. The results are ordered by location and date.

**Task 4: Calculating COVID-19 Cases as a Percentage of Population in Nigeria, Kenya, and Angola**

This query calculates the percentage of the population that has contracted COVID-19 in locations containing "Nigeria," "Kenya," and "Angola" in their names. It is filtered by continent not being null and ordered by location and date.

**Task 5: Finding Countries with the Highest COVID-19 Cases as a Percentage of Population**

This query identifies countries with the highest percentage of their population infected by COVID-19. It groups the data by location and population, calculating the percentage of population infected, and orders the results in descending order of population percentage.

**Task 6: Finding Countries with the Highest Total COVID-19 Deaths**

This query identifies countries with the highest total COVID-19 deaths by grouping data by location and ordering the results in descending order of total death count.

**Task 7: Finding Continents with the Highest Total COVID-19 Deaths**

This query identifies continents with the highest total COVID-19 deaths by grouping data by continent and ordering the results in descending order of total death count.

**Task 8: Summarizing Global COVID-19 Cases and Deaths**

This query summarizes global COVID-19 cases and deaths by date. It calculates the total cases and total deaths for each date and orders the results by date and total cases.

**Task 9: Retrieving COVID-19 Vaccination Data**

This query retrieves data from the `CovidVaccination` table, ordering the results by location and date.

**Task 10: Comparing Total Vaccinations with Population**

This query joins data from the `coviddeath1` and `covidvaccination` tables to compare total vaccinations with population for each location and date where the continent is not null. It orders the results by continent, date, and location.

**Task 11: Calculating Rolling Total of People Vaccinated**

This query calculates the rolling total of people vaccinated by summing the new_vaccinations column over partitions defined by location and ordering the results by date and location.

**Task 12: Using Common Table Expression (CTE) for Rolling People Vaccinated**

This query uses a Common Table Expression (CTE) to calculate the rolling total of people vaccinated and the percentage of people vaccinated based on population. It orders the results by location.

**Task 13: Creating and Using a Temporary Table for Percentage Population Vaccinated**

This task demonstrates the creation and use of a temporary table to calculate and store the percentage of the population vaccinated. It orders the results by location and calculates the percentage.

**Task 14: Creating a View for Percentage Population Vaccinated**

This query creates a view named `percentagepopulationvaccinated` to store data for later visualization. It calculates the rolling total of people vaccinated and the percentage based on population.

I am currently working on full presentation on Power BI. 
Thank you for reading
