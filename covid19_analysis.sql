
--Covid 19 Data Exploration 
--Data source used from January 1,2020 to February 8,2022 : https://ourworldindata.org/covid-deaths



-- total casesvs total deaths in a country
SELECT location, population, dt_date, total_cases, total_deaths, 
		(CAST (total_deaths AS float) / CAST (total_cases AS float))*100  AS percent_population_infected
FROM covidanalysis.CovidDeaths
WHERE location LIKE "%italy%"
ORDER BY 1,2;



--countries with highest infection rate
SELECT 
	location, 
	population,
	MAX(total_cases) AS highest_infection_count,
	MAX(CAST (total_cases AS float) / population) *100 AS percent_population_infected
FROM covidanalysis.CovidDeaths
GROUP BY location, population
ORDER BY percent_population_infected DESC;



--countries with highest death count per population
SELECT 
	location, 
	MAX(CAST(total_deaths AS int)) AS total_death_count
FROM covidanalysis.CovidDeaths
WHERE continent != ''
GROUP BY location
ORDER BY total_death_count DESC;



-- continetns with highest death count per population
SELECT 
	continent, 
	MAX(CAST(total_deaths AS int)) AS total_death_count
FROM covidanalysis.CovidDeaths
WHERE continent != ''
GROUP BY continent
ORDER BY total_death_count DESC;



-- global death percentage on some day
SELECT 
	dt_date,
	sum(CAST( new_cases AS float)) AS total_cases_reported,
	sum(CAST( new_deaths AS float)) AS total_deaths,
	(sum(CAST( new_deaths AS float)) / sum(CAST( new_cases AS float)) )*100 AS death_percentage
FROM covidanalysis.CovidDeaths
WHERE continent != ''
GROUP BY dt_date
ORDER BY 1,2;



-- vaccinations on some day
SELECT 
	dth.continent,
	dth.location,
	dth.dt_date,
	dth.population,
	vac.new_vaccinations
FROM covidanalysis.CovidDeaths as dth
JOIN covidanalysis.CovidVaccinations AS vac
	ON dth.location = vac.location   --having same location in both tables
	AND dth.dt_date = vac.dt_date    -- on the same day
WHERE dth.continent != ''


