create database `Student Depression Dataset`;
use `Student Depression Dataset`;


select * from Student;

ALTER TABLE Student
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;


-- Total records
SELECT COUNT(*) AS total_records
FROM Student;

-- Check duplicate IDs
SELECT id, COUNT(*) AS duplicate_count
FROM Student
GROUP BY id
HAVING COUNT(*) > 1;

-- Validate Gender values
SELECT gender, COUNT(*)
FROM Student
GROUP BY gender;

-- Validate Depression values
SELECT depression, COUNT(*)
FROM Student
GROUP BY depression;


SELECT
    gender,
    depression,
    COUNT(*) AS total_students
FROM Student
GROUP BY gender, depression
ORDER BY gender, depression;


SELECT
    gender,
    depression,
    COUNT(*) AS students,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY gender),
        2
    ) AS percentage
FROM Student
GROUP BY gender, depression
ORDER BY gender, depression;

-- Check whether depression is stored as 0 and 1

SELECT
    depression,
    COUNT(*) AS total_students
FROM Student
GROUP BY depression;



-- Display all sleep duration categories

SELECT
    sleep_duration,
    COUNT(*) AS total_students
FROM Student
GROUP BY sleep_duration
ORDER BY total_students DESC;



-- Check the unique dietary habit values

SELECT
    dietary_habits,
    COUNT(*) AS total_students
FROM Student
GROUP BY dietary_habits;


-- Check whether family history contains only Yes and No
SELECT
    family_history,
    COUNT(*) AS total_students
FROM Student
GROUP BY family_history;


-- Count NULL values in every column

SELECT
    SUM(gender IS NULL) AS gender_null,
    SUM(age IS NULL) AS age_null,
    SUM(academic_pressure IS NULL) AS academic_pressure_null,
    SUM(study_satisfaction IS NULL) AS study_satisfaction_null,
    SUM(sleep_duration IS NULL) AS sleep_duration_null,
    SUM(dietary_habits IS NULL) AS dietary_habits_null,
    SUM(suicidal_thoughts IS NULL) AS suicidal_thoughts_null,
    SUM(study_hours IS NULL) AS study_hours_null,
    SUM(financial_stress IS NULL) AS financial_stress_null,
    SUM(family_history IS NULL) AS family_history_null,
    SUM(depression IS NULL) AS depression_null
FROM Student;


-- Detect impossible values in numeric columns

SELECT *
FROM Student
WHERE age <= 0
   OR academic_pressure NOT BETWEEN 0 AND 5
   OR study_satisfaction NOT BETWEEN 0 AND 5
   OR study_hours < 0
   OR financial_stress NOT BETWEEN 0 AND 5;
   
   
   
   ## exploratory_analysis


USE student_depression_db;


-- 1. Total Number of Students
-- Count all records in the dataset.


SELECT COUNT(*) AS total_students
FROM Student;



-- 2. Depression Distribution
-- Count depressed and non-depressed students.


SELECT
    depression,
    COUNT(*) AS total_students
FROM Student
GROUP BY depression;



-- 3. Gender Distribution
-- Count male and female students.


SELECT
    gender,
    COUNT(*) AS total_students
FROM Student
GROUP BY gender;



-- 4. Depression by Gender
-- Compare depression status across gender.


SELECT
    gender,
    depression,
    COUNT(*) AS total_students
FROM Student
GROUP BY gender, depression
ORDER BY gender, depression;



-- 5. Depression Percentage Within Gender
-- Calculate depression percentage separately for each gender.


SELECT
    gender,
    depression,
    COUNT(*) AS students,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(PARTITION BY gender),
        2
    ) AS percentage
FROM Student
GROUP BY gender, depression
ORDER BY gender, depression;



-- 6. Age Distribution
-- Find the number of students at each age.


SELECT
    age,
    COUNT(*) AS total_students
FROM Student
GROUP BY age
ORDER BY age;



-- 7. Average Age of Students
-- Calculate the average student age.


SELECT
    ROUND(AVG(age),1) AS average_age
FROM Student;



-- 8. Academic Pressure Distribution
-- Count students according to academic pressure level.


SELECT
    academic_pressure,
    COUNT(*) AS total_students
FROM Student
GROUP BY academic_pressure
ORDER BY academic_pressure;



-- 9. Study Satisfaction Distribution
-- Analyze study satisfaction ratings.


SELECT
    study_satisfaction,
    COUNT(*) AS total_students
FROM Student
GROUP BY study_satisfaction
ORDER BY study_satisfaction;



-- 10. Sleep Duration Distribution
-- Find the most common sleep duration.


SELECT
    sleep_duration,
    COUNT(*) AS total_students
FROM Student
GROUP BY sleep_duration
ORDER BY total_students DESC;



-- 11. Dietary Habits Distribution
-- Count students by dietary habits.


SELECT
    dietary_habits,
    COUNT(*) AS total_students
FROM Student
GROUP BY dietary_habits
ORDER BY total_students DESC;



-- 12. Financial Stress Distribution
-- Count students at each financial stress level.


SELECT
    financial_stress,
    COUNT(*) AS total_students
FROM Student
GROUP BY financial_stress
ORDER BY financial_stress;



-- 13. Study Hours Distribution
-- Analyze study hours among students.


SELECT
    study_hours,
    COUNT(*) AS total_students
FROM Student
GROUP BY study_hours
ORDER BY study_hours;



-- 14. Family History Distribution
-- Count students with and without family history.


SELECT
    family_history,
    COUNT(*) AS total_students
FROM Student
GROUP BY family_history;



-- 15. Suicidal Thoughts Distribution
-- Count students who reported suicidal thoughts.


SELECT
    suicidal_thoughts,
    COUNT(*) AS total_students
FROM Student
GROUP BY suicidal_thoughts;



-- 16. Depression by Academic Pressure
-- Analyze depression across academic pressure levels.


SELECT
    academic_pressure,
    depression,
    COUNT(*) AS total_students
FROM Student
GROUP BY academic_pressure, depression
ORDER BY academic_pressure;



-- 17. Depression by Sleep Duration
-- Compare depression across sleep categories.


SELECT
    sleep_duration,
    depression,
    COUNT(*) AS total_students
FROM Student
GROUP BY sleep_duration, depression
ORDER BY sleep_duration;



-- 18. Depression by Dietary Habits
-- Analyze depression according to diet quality.


SELECT
    dietary_habits,
    depression,
    COUNT(*) AS total_students
FROM Student
GROUP BY dietary_habits, depression
ORDER BY dietary_habits;



-- 19. Depression by Financial Stress
-- Compare depression at each financial stress level.


SELECT
    financial_stress,
    depression,
    COUNT(*) AS total_students
FROM Student
GROUP BY financial_stress, depression
ORDER BY financial_stress;



-- 20. Depression by Family History
-- Analyze impact of family mental illness history.


SELECT
    family_history,
    depression,
    COUNT(*) AS total_students
FROM Student
GROUP BY family_history, depression
ORDER BY family_history;
   
   


