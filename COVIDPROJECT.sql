--/*
--CovidDeaths Breakdowns
--*/

select *
from Covidanalysisproject..coviddeath1
where continent is not null
order by 3,4


select location, date, total_cases, total_deaths, new_cases, population
from Covidanalysisproject..coviddeath1
where continent is not null
order by 1,2

--/*
--Searching for Total cases vs total death
--showing percentage of people that are likely to die after contacting covid
--*/

select *
from Covidanalysisproject..coviddeath1
order by 3,4


select location, date, total_cases, total_deaths, (cast (total_deaths as numeric))/ (cast (total_cases as numeric)) *100 DeathPercentage
from Covidanalysisproject..coviddeath1
where location like '%state%'
and continent is not null
order by 1,2


select location, date, total_cases, total_deaths, (cast (total_deaths as numeric))/ (cast (total_cases as numeric))*100 DeathPercentage
from Covidanalysisproject..coviddeath1
where location like '%Nigeria%'
and continent is not null
order by 1,2


--/*
--Searching for Total cases vs population
--showing percentage of people that contacted covid
--*/

select location, date, total_cases, population, (total_cases/population)*100 DeathPercentage
from Covidanalysisproject..coviddeath1
where location like '%Nigeria%'
and continent is not null
order by 1,2


select location, date, total_cases, population, (total_cases/population)*100 DeathPercentage
from Covidanalysisproject..coviddeath1
where location like '%kenya%'
and continent is not null
order by 1,2

select location, date, total_cases, population, (total_cases/population)*100 DeathPercentage
from Covidanalysisproject..coviddeath1
where location like '%Angola%'
and continent is not null
order by 1,2


--/*
--Showing countries with highest covid cases compared to population
--*/

select location, population, max(total_cases) as HighestinfectedCounts,  max(total_cases/population)*100 PercentagePopulationinfected
from Covidanalysisproject..coviddeath1
where continent is not null
Group by location, population
order by PercentagePopulationinfected desc

--/*
--Showing countries with highest death covid cases per population
--*/

select location,  max(cast(total_deaths as int)) AS TotalDeathCount
from Covidanalysisproject..coviddeath1
where continent is not null
Group by location
order by TotalDeathCount desc


--/*
--Breaking things down by continent
--*/

select continent,  max(cast(total_deaths as int)) AS TotalDeathCount
from Covidanalysisproject..coviddeath1
where continent is not null
Group by continent
order by TotalDeathCount desc

--/*
--Global Numbers
--*/

select date, sum(new_cases) as Total_cases, sum(cast (new_deaths as int)) as total_deaths
--, sum(cast (new_deaths as int))/ sum(new_cases) *100 DeathPercentage
from CovidAnalysisProject..coviddeath1
--where location like '%state%'
where continent is not null
group by date
order by 1,2


select sum(new_cases) as Total_cases, sum(cast (new_deaths as int)) as total_deaths
, sum(cast (new_deaths as int))/ sum(new_cases) *100 DeathPercentage
from Covidanalysisproject..coviddeath1
--where location like '%state%'
where continent is not null
order by 1,2

 --Global cases

/*
CovidDeaths Breakdowns
*/

select *
from  Covidanalysisproject..CovidVaccination
order by 1,2

/*
Looking for total vaccinations vs population
*/

select dea.continent, dea.date, dea.location, dea.population, vac.new_vaccinations
from CovidAnalysisProject..coviddeath1 dea
join  CovidAnalysisProject..covidvaccination vac
on dea.location= vac.location
and dea.date=vac.date
where dea.continent is not null
order by 1,2,3

select dea.continent, dea.date, dea.location, dea.population, vac.new_vaccinations
from CovidAnalysisProject..coviddeath1 dea
join  CovidAnalysisProject..covidvaccination vac
on dea.location= vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

select dea.continent, dea.date, dea.location, dea.population, vac.new_vaccinations,
SUM (cast( vac.new_vaccinations as bigint)) over ( partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
--,(rollingpeoplevaccinated*100)
from CovidAnalysisProject..coviddeath1 dea
join  CovidAnalysisProject..covidvaccination vac
on dea.location= vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

--USE CTE
with popvsvac ( continent, date, location, population, new_vaccinations, Rollingpeoplevaccinated)
as
(select dea.continent, dea.date, dea.location, dea.population, vac.new_vaccinations,
SUM (cast(vac.new_vaccinations as bigint )) over ( partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
--,(rollingpeoplevaccinated/population)*100
from CovidAnalysisProject..coviddeath1 dea
join  CovidAnalysisProject..covidvaccination vac
on dea.location= vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2,3
)
select * ,(Rollingpeoplevaccinated/population)
from popvsvac


--TEMP TABLE

DROP TABLE IF EXISTS #percentagepopulationvaccinated
Create Table #percentagepopulationvaccinated
(
continent nvarchar(255),
location nvarchar(255),
Date datetime,
population numeric,
new_vaccinations bigint,
rollingpeoplevaccinated numeric
)
Insert into #percentagepopulationvaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM (cast(vac.new_vaccinations as bigint )) over ( partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
--,(rollingpeoplevaccinated/population)*100
from CovidAnalysisProject..coviddeath1 dea
join  CovidAnalysisProject..covidvaccination vac
on dea.location= vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2,3

select * ,(Rollingpeoplevaccinated/population)*100
from #percentagepopulationvaccinated


--Creating view to store data for later visualization

Create view percentagepopulationvaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM (cast(vac.new_vaccinations as bigint )) over ( partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
--,(rollingpeoplevaccinated/population)*100
from CovidAnalysisProject..coviddeath1 dea
join  CovidAnalysisProject..covidvaccination vac
on dea.location= vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2,3

select*
from percentagepopulationvaccinated

--Thank you