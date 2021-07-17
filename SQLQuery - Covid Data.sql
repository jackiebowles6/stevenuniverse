-- Looking the verify the data upload

SELECT *
FROM CovidPortfolioProject..CovidVaccinations

SELECT *
FROM CovidPortfolioProject..CovidDeaths

SELECT SUM(cast(total_deaths as int))
FROM CovidPortfolioProject..CovidDeaths
WHERE continent like '%north america%'



-- Select data that we are going to be looking at.

Select cd.location, cd.date, cd.total_cases, cd.new_cases, cd.total_deaths, cv.population
FROM CovidPortfolioProject..CovidDeaths AS cd
JOIN CovidPortfolioProject..CovidVaccinations AS cv
ON cv.iso_code = cd.iso_code

-- Looking at Total Cases vs. Total Deaths

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidPortfolioProject..CovidDeaths AS cd
WHERE location like '%states%'
order by 1,2

-- Looking at Countries with Highest Infection Rate compared to Population
Select cd.location, cv.population, MAX(cd.total_cases) as HighestInfectionCount, MAX((cd.total_cases/cv.population))*100 as PercentPopulationInfected
FROM CovidPortfolioProject..CovidDeaths AS cd
JOIN CovidPortfolioProject..CovidVaccinations AS cv
ON cv.iso_code = cd.iso_code
--WHERE location like '%states%'
GROUP BY cd.location, cv.population
order by PercentPopulationInfected desc

-- Showing Countries with Highest Death Count per Population
Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM CovidPortfolioProject..CovidDeaths AS cd
WHERE continent is not null
GROUP BY location
order by TotalDeathCount desc

--Breaking Down by Continent

-- Showing continents with the highest death count per population
Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM CovidPortfolioProject..CovidDeaths AS cd
WHERE continent is not null
GROUP BY continent
order by TotalDeathCount desc

-- Global Numbers
Select SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM CovidPortfolioProject..CovidDeaths AS cd
WHERE continent is not null
--GROUP BY date
order by 1,2

-- Looking at Total Population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, vac.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingCountPeopleVaccinated
--can also do SUM(CONVERT(int,vac.new_vaccinations) OVER (PARTITION BY dea.location)
FROM CovidPortfolioProject..CovidDeaths dea
JOIN CovidPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3

-- USE CTE to create temp table

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingCountPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, vac.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingCountPeopleVaccinated
--can also do SUM(CONVERT(int,vac.new_vaccinations) OVER (PARTITION BY dea.location)
--, (RollingCountPeopleVaccinated/population)*100
FROM CovidPortfolioProject..CovidDeaths dea
JOIN CovidPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
---ORDER BY 2,3
)
SELECT *, (RollingCountPeopleVaccinated/Population)*100
FROM PopvsVac

-- Another TEMP table
DROP table if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingCountPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, vac.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingCountPeopleVaccinated
FROM CovidPortfolioProject..CovidDeaths dea
JOIN CovidPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
---ORDER BY 2,3

SELECT *, (RollingCountPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated

-- VIEWS for Later Tableau Use

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, vac.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingCountPeopleVaccinated
FROM CovidPortfolioProject..CovidDeaths dea
JOIN CovidPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
---ORDER BY 2,3

SELECT *
FROM PercentPopulationVaccinated