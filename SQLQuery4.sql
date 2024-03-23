--Select *
--from CovidDeaths


--Select *
--from CovidVaccinations
--order by 3,4

--Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--from CovidDeaths
--where location like '%states'
--order by 1,2

--Select Location, date, population,total_cases,  (total_cases/population)*100 as DeathPercentage
--from CovidDeaths
----where location like '%states'
--order by 1,2


--Select Location,  population, max (total_cases) as Highestinfectioncount,  Max((total_cases/population)) *100 as Percentagepopoulationinfected
--from CovidDeaths
--group by location,population
--order by Percentagepopoulationinfected desc


 --Select  SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Deathpercentage
 --from  CovidDeaths
 --where continent is not null
 --order by 1,2

-- with PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
-- as
-- (
-- Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations ,
-- SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location,dea.date) as RollingPeopleVaccinated
-- from CovidDeaths dea
-- join CovidVaccinations vac
-- on dea.location=vac.location
-- and  dea.date=vac.date
-- where dea.continent is not null
-- )
--select*, (RollingPeopleVaccinated/population)*100
--from PopvsVac


CREATE VIEW PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations ,
 SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location,dea.date) as RollingPeopleVaccinated
 from CovidDeaths dea
 join CovidVaccinations vac
 on dea.location=vac.location
 and  dea.date=vac.date
where dea.continent is not null

SELECT*
FROM PercentPopulationVaccinated