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

## 📊 Business Questions Answered (20 Queries)

1. Which crime type occurs most frequently?
2. Which city has the highest number of reported crimes?
3. How many crimes were reported each year?
4. What is the gender distribution of victims?
5. Which weapon is used most often?
6. What time of day do most crimes occur?
7. What is the case resolution rate by city?
8. What is the average victim age per crime domain?
9. Which cities have above average crime count?
10. How many crimes involved each weapon per crime domain?
11. Which age group is most targeted?
12. Which city has the most unsolved cases?

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
- Window Functions — RANK(), LAG(), SUM() OVER()
- CTEs (Common Table Expressions)
- Subqueries
- DATEDIFF, DATEPART, DATENAME
- TRY_CONVERT for date handling
- Aggregate Functions — COUNT, AVG, MIN, MAX, SUM

---

## 📁 Repository Structure

---

## 🙋‍♀️ About Me
Third-year Economics Honours student at Hans Raj College, University of Delhi.
📧 [divyanshisai.ds@gmail.com]
🔗 [Linkedin](https://www.linkedin.com/in/divyanshisaini23/)
