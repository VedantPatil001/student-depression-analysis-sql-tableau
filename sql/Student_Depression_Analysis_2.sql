

USE student_depression_db;


-- 1. Depression Rate by Academic Pressure
-- Calculate the percentage of depressed students at each
-- academic pressure level.


SELECT
    academic_pressure,
    ROUND(
        AVG(CASE WHEN depression = 1 THEN 1 ELSE 0 END) * 100,
        2
    ) AS depression_rate
FROM Student
GROUP BY academic_pressure
ORDER BY academic_pressure;



-- 2. Depression Rate by Sleep Duration
-- Identify which sleep category has the highest depression rate.


SELECT
    sleep_duration,
    ROUND(
        AVG(CASE WHEN depression = 1 THEN 1 ELSE 0 END) * 100,
        2
    ) AS depression_rate
FROM Student
GROUP BY sleep_duration
ORDER BY depression_rate DESC;



-- 3. Depression Rate by Dietary Habits
-- Compare healthy, moderate and unhealthy eating habits.


SELECT
    dietary_habits,
    ROUND(
        AVG(CASE WHEN depression = 1 THEN 1 ELSE 0 END) * 100,
        2
    ) AS depression_rate
FROM Student
GROUP BY dietary_habits
ORDER BY depression_rate DESC;



-- 4. Depression Rate by Financial Stress
-- Analyze the relationship between financial stress and depression.


SELECT
    financial_stress,
    ROUND(
        AVG(CASE WHEN depression = 1 THEN 1 ELSE 0 END) * 100,
        2
    ) AS depression_rate
FROM Student
GROUP BY financial_stress
ORDER BY financial_stress;



-- 5. Students with High Study Hours
-- Display students studying more than 10 hours.


SELECT
    id,
    gender,
    age,
    study_hours
FROM Student
WHERE study_hours > 10
ORDER BY study_hours DESC;



-- 6. Age Group Analysis using CASE
-- Divide students into age groups.


SELECT
    CASE
        WHEN age BETWEEN 18 AND 20 THEN '18-20'
        WHEN age BETWEEN 21 AND 23 THEN '21-23'
        ELSE '24+'
    END AS age_group,
    COUNT(*) AS total_students
FROM Student
GROUP BY age_group
ORDER BY age_group;



-- 7. Depression Rate by Age Group
-- Compare depression percentage across age groups.


SELECT
    CASE
        WHEN age BETWEEN 18 AND 20 THEN '18-20'
        WHEN age BETWEEN 21 AND 23 THEN '21-23'
        ELSE '24+'
    END AS age_group,
    ROUND(
        AVG(CASE WHEN depression = 1 THEN 1 ELSE 0 END) * 100,
        2
    ) AS depression_rate
FROM Student
GROUP BY age_group
ORDER BY depression_rate DESC;



-- 8. High-Risk Academic Pressure Groups
-- Display only pressure levels having more than 1000 students.


SELECT
    academic_pressure,
    COUNT(*) AS total_students
FROM Student
GROUP BY academic_pressure
HAVING COUNT(*) > 1000
ORDER BY total_students DESC;



-- 9. Average Study Hours by Depression Status
-- Compare study hours of depressed vs non-depressed students.


SELECT
    depression,
    ROUND(AVG(study_hours),2) AS avg_study_hours
FROM Student
GROUP BY depression;



-- 10. Average Academic Pressure by Gender
-- Compare academic pressure between male and female students.


SELECT
    gender,
    ROUND(AVG(academic_pressure),2) AS avg_pressure
FROM Student
GROUP BY gender;



-- 11. CTE : Depression Percentage by Gender
-- Use Common Table Expression for reporting.


WITH gender_summary AS
(
    SELECT
        gender,
        COUNT(*) AS total_students,
        SUM(CASE WHEN depression = 1 THEN 1 ELSE 0 END) AS depressed_students
    FROM Student
    GROUP BY gender
)

SELECT
    gender,
    total_students,
    depressed_students,
    ROUND(depressed_students * 100.0 / total_students,2) AS depression_percentage
FROM gender_summary;



-- 12. ROW_NUMBER()
-- Rank students by study hours.


SELECT
    id,
    gender,
    study_hours,
    ROW_NUMBER() OVER(ORDER BY study_hours DESC) AS row_num
FROM Student;



-- 13. RANK()
-- Rank students by study hours (with gaps).


SELECT
    id,
    gender,
    study_hours,
    RANK() OVER(ORDER BY study_hours DESC) AS rank_number
FROM Student;



-- 14. DENSE_RANK()
-- Rank students without gaps.


SELECT
    id,
    gender,
    study_hours,
    DENSE_RANK() OVER(ORDER BY study_hours DESC) AS dense_rank
FROM Student;



-- 15. Top 5 Students with Highest Study Hours
-- Use DENSE_RANK to retrieve top performers.


WITH ranked_students AS
(
    SELECT
        id,
        gender,
        age,
        study_hours,
        DENSE_RANK() OVER(ORDER BY study_hours DESC) AS rnk
    FROM Student
)

SELECT *
FROM ranked_students
WHERE rnk <= 5;



-- 16. Gender-wise Ranking
-- Rank study hours separately for each gender.


SELECT
    gender,
    id,
    study_hours,
    DENSE_RANK() OVER(
        PARTITION BY gender
        ORDER BY study_hours DESC
    ) AS gender_rank
FROM Student;



-- 17. Highest Financial Stress Group
-- Identify the stress level with the maximum students.


SELECT
    financial_stress,
    COUNT(*) AS total_students
FROM Student
GROUP BY financial_stress
ORDER BY total_students DESC
LIMIT 1;



-- 18. Students with Depression and Family History
-- Count high-risk students.


SELECT COUNT(*) AS high_risk_students
FROM Student
WHERE depression = 1
AND family_history = 'Yes';



-- 19. Students Sleeping Less Than 5 Hours
-- Analyze depression among short sleepers.


SELECT
    depression,
    COUNT(*) AS total_students
FROM Student
WHERE sleep_duration = 'Less than 5 hours'
GROUP BY depression;



-- 20. Final Business Summary
-- Overall KPIs for dashboard creation.


SELECT
    COUNT(*) AS total_students,
    ROUND(AVG(age),1) AS average_age,
    ROUND(AVG(study_hours),1) AS average_study_hours,
    ROUND(AVG(CASE WHEN depression=1 THEN 1 ELSE 0 END)*100,2) AS depression_rate
FROM Student;