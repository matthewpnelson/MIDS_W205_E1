-- Best Hospitals SQL query

-- What hospitals are models of high-quality care? That is, which hospitals have the most consistently high scores for a variety of procedures.

-- Tables to use: procedures_detail, hospital_edit

-- Selection Criteria:
-- Grouping by Hospital, we want to see the highest average scores across all of their procedures.

-- Also want to consider how many procedures they do, as a hospital could be very good at a small
-- number of procedures by way of specialty. We are more interested in general excellence.

-- An additional constraint is applied to keep the total variance between max and min scores
-- to be below 20, as a very high average score doesn't mean consistency if there is at least one
-- procedure that has been performed poorly at the hospital.

-- Scores relating to the emergency department were excluded from aggregation, as they went beyond the standard 0-100
-- scale.

-- Focusing on only procedure care scores, not readmission scores as these are difficult
-- to compare to one another because high procedure care scores are good while low
-- readmissions scores (score / denominator) are good. A multi-filter could have occured
-- between these two metrics, however it was decided not to pursue this for this assignment.

-- Had to convert all of our number columns to INT before aggregating, used the cast() function.

SELECT hospital_edit.hospital_id, hospital_edit.hospital_name,
    SUM(cast(procedures_detail.care_score AS INT)) AS Total_Score,
    round(avg(cast(procedures_detail.care_score AS INT)),2) AS Avg_Score,
    max(cast(procedures_detail.care_score AS INT)) - min(cast(procedures_detail.care_score AS INT)) AS Var_Score,
    COUNT(cast(procedures_detail.care_score AS INT)) AS Count_Score
FROM hospital_edit
LEFT OUTER JOIN procedures_detail
ON hospital_edit.hospital_id = procedures_detail.care_hospital_id
WHERE cast(procedures_detail.care_score AS INT) <= 100 -- Excludes Emergency Room Scores > 100
GROUP BY hospital_edit.hospital_name, hospital_edit.hospital_id
-- Restrict High Performers to those with at least more than 10 Procedures
HAVING COUNT(cast(procedures_detail.care_score AS INT)) >= 10 AND
    max(cast(procedures_detail.care_score AS INT)) - min(cast(procedures_detail.care_score AS INT)) <=20
ORDER BY Avg_Score DESC
LIMIT 10;
