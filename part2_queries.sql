--1.Show the possible values of the year column in the country_stats table sorted by most recent year first.
SELECT DISTINCT year FROM country_stats ORDER BY year DESC;
-- 2. Show the names of the first 5 countries in the database when sorted in alphabetical order by name.
SELECT name FROM countries ORDER BY name LIMIT 5;
-- 3. Adjust the previous query to show both the country name and the gdp from 2018, but this time show the top 5 countries by gdp.
SELECT countries.name, country_stats.gdp AS gdp
FROM countries
INNER JOIN country_stats on countries.country_id = country_stats.country_id
WHERE country_stats.year=2018
ORDER BY gdp DESC LIMIT 5;
-- 4. How many countries are associated with each region id?
SELECT countries.region_id, count(countries.region_id) AS country_count FROM countries
GROUP BY countries.region_id ORDER BY country_count DESC;
-- 5. What is the average area of countries in each region id?
SELECT countries.region_id, FlOOR(AVG(countries.area)+0.5) AS avg_area FROM countries
GROUP BY countries.region_id ORDER BY avg_area;
-- 6. Use the same query as above, but only show the groups with an average country area less than 1000
SELECT countries.region_id, FlOOR(AVG(countries.area)+0.5) AS avg_area FROM countries
GROUP BY countries.region_id HAVING FlOOR(AVG(countries.area)+0.5)<1000 ORDER BY avg_area;
-- 7. Create a report displaying the name and population of every continent in the database from the year 2018 in millions.
SELECT continents.name, ROUND(SUM(country_stats.population)/ROUND(1000000,2),2) AS tot_pop 
FROM continents
INNER JOIN regions on continents.continent_id = regions.continent_id
INNER JOIN countries on regions.region_id = countries.region_id
INNER JOIN country_stats on countries.country_id = country_stats.country_id
WHERE country_stats.year=2018 GROUP BY continents.name ORDER BY tot_pop DESC;
-- 8. List the names of all of the countries that do not have a language.
SELECT countries.name FROM countries
LEFT JOIN country_languages on countries.country_id = country_languages.country_id
WHERE country_languages.country_id is null;
-- 9. Show the country name and number of associated languages of the top 10 countries with most languages
SELECT countries.name, count(country_languages.country_id) AS lang_count FROM countries
INNER JOIN country_languages on countries.country_id = country_languages.country_id
GROUP BY countries.name ORDER BY lang_count DESC, countries.name LIMIT 10;
-- 10. Repeat your previous query, but display a comma separated list of spoken languages
--rather than a count (use the aggregate function for strings, string_agg. A single example row (note that results before and above have been omitted for formatting):
SELECT countries.name, string_agg(languages.language,',') AS string_agg FROM countries
INNER JOIN country_languages on countries.country_id = country_languages.country_id
INNER JOIN languages on country_languages.language_id = languages.language_id
GROUP BY countries.name ORDER BY count(country_languages.country_id) DESC,countries.name LIMIT 10;
-- 11. What's the average number of languages in every country in a region in the dataset? Show both the region's name and the average.
WITH temp AS (
	SELECT countries.country_id, count(country_languages.country_id) as count_avg FROM countries
	LEFT JOIN country_languages on countries.country_id = country_languages.country_id
	GROUP BY countries.country_id
)
SELECT regions.name, ROUND(AVG(count_avg),1) as avg_lang_count_per_country
FROM temp
INNER JOIN countries on temp.country_id = countries.country_id
INNER JOIN regions on countries.region_id = regions.region_id
GROUP BY regions.name
ORDER BY avg_lang_count_per_country DESC;
-- 12. Show the country name and its "national day" for the country with the most recent national day and the country with the oldest national day.
SELECT countries.name, countries.national_day
FROM countries WHERE countries.national_day = (SELECT MAX(countries.national_day) FROM countries) 
OR countries.national_day = (SELECT MIN(countries.national_day) FROM countries)
ORDER BY countries.national_day DESC;
	