# Crimes in India (2020-2024) Analysis using SQL 
![Crimes Logo](https://raw.githubusercontent.com/divyanshisaids-cell/Crimes_in_India_sql_project/refs/heads/main/crime-in-india-166185841216x9.avif)

## Overview
This project analyzes a real-world crime dataset containing 40,160 records across 29 Indian cities using SQL Server. The goal is to uncover patterns in criminal activity, victim demographics, case resolution rates, and police deployment efficiency through structured SQL queries.

---

## 🗃️ Dataset
- **Source:** Kaggle — [India Crime Dataset](https://www.kaggle.com/datasets/sudhanvahg/indian-crimes-dataset)
- **Size:** 40,160 rows | 14 columns
- **Cities Covered:** 29 Indian cities, including Delhi, Mumbai, Bangalore, Hyderabad, Kolkata and more
- **Time Period:** 2020 onwards

---

## 🛠️ Tools Used
- SQL Server Management Studio (SSMS)
- T-SQL (Microsoft SQL Server)
- Excel (for result visualization)

---

## 📂 Schema

```sql
CREATE TABLE Crimes
(
    Report_Number        INT,
    Date_Reported        NVARCHAR(50),
    Date_of_Occurrence   NVARCHAR(50),
    Time_of_Occurrence   NVARCHAR(10),
    City                 NVARCHAR(50),
    Crime_Code           INT,
    Crime_Description    NVARCHAR(100),
    Victim_Age           INT,
    Victim_Gender        NVARCHAR(10),
    Weapon_Used          NVARCHAR(50),
    Crime_Domain         NVARCHAR(50),
    Police_Deployed      INT,
    Case_Closed          NVARCHAR(5),
    Date_Case_Closed     NVARCHAR(50)
);
```

## 📊 Business Questions Answered (12 Queries)

1. Which crime type occurs most frequently?
   ```sql
   SELECT Crime_Description,
   COUNT(Crime_Description) as totalno_crimes
   FROM dbo.crimes
   GROUP BY Crime_Description 
   ORDER BY COUNT(Crime_Description) DESC
   
2. Which city has the highest number of reported crimes?
   ```sql
   SELECT City,
   COUNT(City) as Total_crimes
   FROM dbo.crimes
   GROUP BY City
   ORDER BY COUNT(City) DESC
   
3. How many crimes were reported each year?
   ```sql
   SELECT YEAR(CONVERT(DATETIME2, Date_Reported, 105)) as Totalyears,
   COUNT(*) as totalcrimes
   FROM dbo.crimes
   GROUP BY YEAR(CONVERT(DATETIME2, Date_Reported, 105))
   ORDER BY YEAR(CONVERT(DATETIME2, Date_Reported, 105))
   
4. What is the gender distribution of victims?
   ```sql
   SELECT Victim_Gender,
   COUNT(*) AS Total_victims
   FROM dbo.crimes
   GROUP BY Victim_Gender
   
5. Which weapon is used most often?
   ```sql
   SELECT Weapon_Used,
   Count(*) as total_weapons
   FROM dbo.crimes
   GROUP BY Weapon_Used
   ORDER BY Count(*) DESC
   
6. What time of day do most crimes occur?
   ```sql
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
   
7. What is the case resolution rate by city?
   ```sql
   SELECT City,
   COUNT(*) total_cases,
   SUM(CASE WHEN Case_Closed = 'Yes' THEN 1 ELSE 0 END) AS Case_resolved,
   ROUND(100 * SUM(CASE WHEN Case_Closed = 'Yes' THEN 1 ELSE 0 END) /COUNT(*), 2) as Resolution_rate
   FROM dbo.crimes
   GROUP BY City
   ORDER BY Resolution_rate desc
   
8. What is the average victim age per crime domain?
   ```sql
   SELECT Crime_Domain,
   AVG(Victim_Age) as AVG_AGE
   FROM dbo.crimes
   GROUP BY Crime_Domain
   
9. Which cities have above average crime count?
   ```sql
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
   
10. How many crimes involved each weapon per crime domain?
    ```sql
    SELECT Crime_Domain,
    Weapon_Used,
    COUNT(Weapon_Used) AS no_of_weapons
    FROM dbo.crimes
    GROUP BY Crime_Domain, Weapon_Used
    ORDER BY Crime_Domain , COUNT(Weapon_Used) DESC

11. Which age group is most targeted?
    ```sql
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
    
12. Which city has the most unsolved cases?
    ```sql
    SELECT City,
    COUNT(*) AS Total_crimes,
    SUM(CASE WHEN Case_Closed = 'No' THEN 1 else 0 END) AS Unsolved_cases
    FROM dbo.crimes
    GROUP BY City
    ORDER BY Unsolved_cases DESC
    
---

## 💡 Key Insights
- **Delhi** recorded the highest number of crimes across all years.
- **Violent Crime** dominates as the most common crime domain
- Most crimes occur during **Night hours**
- Case resolution rates vary significantly across cities
- **Senior 60+** is the most targeted age group

---

##  SQL Concepts Used
- GROUP BY, ORDER BY, HAVING
- CASE WHEN for categorization
- Window Functions
- CTEs (Common Table Expressions)
- Subqueries
- DATEDIFF, DATEPART, DATENAME
- TRY_CONVERT for date handling
- Aggregate Functions — COUNT, AVG, MIN, MAX, SUM, ROUND

---

## 🙋‍♀️ About Me
Third-year Economics Honours student at Hans Raj College, University of Delhi.
📧 [divyanshisai.ds@gmail.com]

🔗 [Linkedin](https://www.linkedin.com/in/divyanshisaini23/)
