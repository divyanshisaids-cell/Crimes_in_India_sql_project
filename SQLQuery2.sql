-- Crimes in India 2020-2024 Project

SELECT *
FROM dbo.crimes

-- 1. Which crime type occurs most frequently?
SELECT Crime_Description,
COUNT(Crime_Description) as totalno_crimes
FROM dbo.crimes
GROUP BY Crime_Description 
ORDER BY COUNT(Crime_Description) DESC

-- 2. Which city has the highest number of reported crimes?
SELECT City,
COUNT(City) as Total_crimes
FROM dbo.crimes
GROUP BY City
ORDER BY COUNT(City) DESC

-- 3. How many crimes were reported each year?
SELECT YEAR(CONVERT(DATETIME2, Date_Reported, 105)) as Totalyears,
COUNT(*) as totalcrimes
FROM dbo.crimes
GROUP BY YEAR(CONVERT(DATETIME2, Date_Reported, 105))
ORDER BY YEAR(CONVERT(DATETIME2, Date_Reported, 105))

-- 4. What is the gender distribution of victims?
SELECT Victim_Gender,
COUNT(*) AS Total_victims
FROM dbo.crimes
GROUP BY Victim_Gender

-- 5. Which weapon is used most often?
SELECT Weapon_Used,
Count(*) as total_weapons
FROM dbo.crimes
GROUP BY Weapon_Used
ORDER BY Count(*) DESC

-- 6. What time of day do most crimes occur?
SELECT 
CASE WHEN DATEPART(HOUR,CONVERT(DATETIME2,Time_of_Occurrence,105)) BETWEEN 4 AND 11 THEN 'Morning'
     WHEN DATEPART(HOUR,CONVERT(DATETIME2,Time_of_Occurrence,105)) BETWEEN 12 AND 16 THEN 'Afternoon'
     WHEN DATEPART(HOUR,CONVERT(DATETIME2,Time_of_Occurrence,105)) BETWEEN 17 AND 20 THEN 'Evening'
     ELSE 'Night'
END AS 'Time_of_Day',
COUNT(*) AS Total_crimes
FROM dbo.crimes
GROUP BY CASE WHEN DATEPART(HOUR,CONVERT(DATETIME2,Time_of_Occurrence,105)) BETWEEN 4 AND 11 THEN 'Morning'
     WHEN DATEPART(HOUR,CONVERT(DATETIME2,Time_of_Occurrence,105)) BETWEEN 12 AND 16 THEN 'Afternoon'
     WHEN DATEPART(HOUR,CONVERT(DATETIME2,Time_of_Occurrence,105)) BETWEEN 17 AND 20 THEN 'Evening'
     ELSE 'Night'
END
ORDER BY COUNT(*) DESC

-- 7. What is the case resolution rate by city?
SELECT City,
COUNT(*) total_cases,
SUM(CASE WHEN Case_Closed = 'Yes' THEN 1 ELSE 0 END) AS Case_resolved,
ROUND(100 * SUM(CASE WHEN Case_Closed = 'Yes' THEN 1 ELSE 0 END) /COUNT(*), 2) as Resolution_rate
FROM dbo.crimes
GROUP BY City
ORDER BY Resolution_rate desc

-- 8. What is the average victim age per crime domain?
SELECT Crime_Domain,
AVG(Victim_Age) as AVG_AGE
FROM dbo.crimes
GROUP BY Crime_Domain

-- 9. Which cities have above average crime count?
SELECT City,
COUNT(City) AS total_crimes
FROM dbo.crimes
GROUP BY City
HAVING COUNT(City) >   (SELECT AVG(city_count) 
                               FROM
                                (SELECT COUNT(City) as city_count
                                 FROM dbo.crimes
                                 GROUP BY City
                                 ) AS City_totals)
ORDER BY total_crimes DESC

-- 10. How many crimes involved each weapon per crime domain?
SELECT Crime_Domain,
Weapon_Used,
COUNT(Weapon_Used) AS no_of_weapons
FROM dbo.crimes
GROUP BY Crime_Domain, Weapon_Used
ORDER BY Crime_Domain , COUNT(Weapon_Used) DESC

-- 11. Which age group is most targeted by crime?
SELECT
CASE WHEN Victim_Age BETWEEN 0 AND 17 THEN 'Minor Age'
     WHEN Victim_Age BETWEEN 18 AND 30 THEN 'Young Adult'
     WHEN Victim_Age BETWEEN 31 AND 45 THEN 'Adult'
     WHEN Victim_Age BETWEEN 46 AND 60 THEN 'Middle Aged'
     ELSE '60+'
END AS Age_group,
COUNT(*) AS Total_crimes
FROM dbo.crimes
GROUP BY 
    CASE WHEN Victim_Age BETWEEN 0 AND 17 THEN 'Minor Age'
         WHEN Victim_Age BETWEEN 18 AND 30 THEN 'Young Adult'
         WHEN Victim_Age BETWEEN 31 AND 45 THEN 'Adult'
         WHEN Victim_Age BETWEEN 46 AND 60 THEN 'Middle Aged'
         ELSE '60+'
    END
ORDER BY Total_crimes DESC

-- 12.Which city has the most unsolved cases?
SELECT City,
COUNT(*) AS Total_crimes,
SUM(CASE WHEN Case_Closed = 'No' THEN 1 else 0 END) AS Unsolved_cases
FROM dbo.crimes
GROUP BY City
ORDER BY Unsolved_cases DESC

