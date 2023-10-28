-- create a join table

SELECT * FROM Absenteeism_at_work a
LEFT JOIN Compensation c
ON a.ID = c.ID
LEFT JOIN Reasons r
ON a.Reason_for_absence =r.Number;

-- find the healthiest employees for the bonus

SELECT * FROM Absenteeism_at_work 
WHERE Social_smoker = 0 AND Social_drinker = 0 AND Body_mass_index < 25
AND Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work)

-- compensation rate increase for non-smokres/ budget $983,221 so 0.68 increase per hour/ $1 414,4 per year

SELECT COUNT(*) AS nonsmokers FROM Absenteeism_at_work
WHERE Social_smoker = 0

-- optymize this query

SELECT 
a.ID,
r.Reason,
Month_of_absence,
Body_mass_index,
CASE WHEN Body_mass_index < 18.5 THEN 'Underweight'
	 WHEN Body_mass_index BETWEEN 18.5 AND 25 THEN 'Healthy weight'
	 WHEN Body_mass_index BETWEEN 25 AND 30 THEN 'Overweight'
	 WHEN Body_mass_index > 30 THEN 'Obese'
	 ELSE 'Unknown' END AS BMI_Category,
CASE WHEN a.Month_of_absence IN (12,1,2) THEN 'Winter'
	 WHEN a.Month_of_absence IN (3,4,5) THEN 'Spring'
	 WHEN a.Month_of_absence IN (6,7,8) THEN 'Summer'
	 WHEN a.Month_of_absence IN (9,10,11) THEN 'Fall'
	 ELSE 'Unknown' END AS Season_Names,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
FROM Absenteeism_at_work a
LEFT JOIN Compensation c
ON a.ID = c.ID
LEFT JOIN Reasons r
ON a.Reason_for_absence =r.Number;
