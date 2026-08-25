# Analyzing Hospital Patient Records with SQL

## 📌 Project Overview
This project uses **SQL code** to look at hospital database records. I wrote scripts to study data from 4 different tables that track patient visits, personal details, and medical codes. The queries quickly calculate the total number of patients, separate them by gender, and group them into age percentages.

---

## 🔬 The Database Tables Used
The code runs across 4 tables in the hospital system:
* `patientsz`: Stores basic details like patient ID, gender, and age.
* `admissionsz`: Logs when patients entered or left the hospital.
* `diagnoses_icdz` & `d_icd_diagnosesz`: Stores official medical codes for different diseases.

---

## 💻 The SQL Queries I Wrote

### 1. Counting Patients by Gender
This query counts the total number of male and female patients registered in the database:
```sql
SELECT gender, COUNT(subject_id) AS numberofpatients 
FROM `patientsz`
GROUP BY gender;
```

### 2. Grouping Patients by Age Brackets
This query automatically groups patients into age buckets (like 'under 30' or '50-59') and sorts them in order:
```sql
SELECT CASE 
           WHEN anchor_age < 30 THEN 'under 30'
           WHEN anchor_age < 40 THEN '30-49'
           WHEN anchor_age < 50 THEN '40-49'
           WHEN anchor_age < 60 THEN '50-59'
           WHEN anchor_age < 70 THEN '60-69'
           ELSE '70+'
       END AS agegroup,
       COUNT(*) AS patients 
FROM `patientsz`
GROUP BY agegroup
ORDER BY 
    CASE
        WHEN agegroup = 'under 30' THEN 1
        WHEN agegroup = '30-49' THEN 2
        WHEN agegroup = '40-49' THEN 3
        WHEN agegroup = '50-59' THEN 4
        WHEN agegroup = '60-69' THEN 5
        WHEN agegroup = '70+' THEN 6
    END;
```

### 3. Calculating Age Percentages
This query calculates the exact percentage of the total patient population that falls into each age group:
```sql
SELECT CASE
           WHEN anchor_age < 30 THEN 'under 30'
           WHEN anchor_age < 40 THEN '30-49'
           WHEN anchor_age < 50 THEN '40-49'
           WHEN anchor_age < 60 THEN '50-59'
           WHEN anchor_age < 70 THEN '60-69'
           WHEN anchor_age > 70 THEN '70+'
       END AS agegroup,
       CONCAT(ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM patientsz), 2), '%') AS percentageAge
FROM `patientsz`
GROUP BY agegroup;
```

---

## 📂 Files in This Project
* `clinical_patient_queries.sql`: The text file containing my raw SQL code.
* `README.md`: Summary page.
