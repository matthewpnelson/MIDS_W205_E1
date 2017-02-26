-- Hospital Variability SQL query

-- Which procedures have the greatest variability between hospitals?

-- Tables to use: procedures_detail, hospital_edit

-- Selection Criteria:
-- Grouping by Procedure, we want to see the highest variability in scores across
-- hospitals (there is only one score per procedure per hospital so we do not need to
-- aggregate at the hospital level first).

-- Results were secondarily ordered by Avg_Score, to bring to the top the procedures which
-- have some very high performers but the majority of hospitals struggle with. This highlights
-- procedures which could be the focus for additional training to increase average scores.

-- Scores relating to the emergency department were excluded from aggregation, as they went beyond the standard 0-100
-- scale.

-- Focusing on only procedure care scores, not readmission scores as these are difficult
-- to compare to one another because high procedure care scores are good while low
-- readmissions scores (score / denominator) are good. A multi-filter could have occured
-- between these two metrics, however it was decided not to pursue this for this assignment.

-- Had to convert all of our number columns to INT before aggregating, used the cast() function.

SELECT procedures_detail.procedure_id,
    COUNT(hospital_edit.hospital_id) AS No_H,
    round(avg(cast(procedures_detail.care_score AS INT)),2) AS Avg_Score,
    max(cast(procedures_detail.care_score AS INT)) - min(cast(procedures_detail.care_score AS INT)) AS Var_Score,
    COUNT(cast(procedures_detail.care_score AS INT)) AS Count_Score,
    procedures_detail.measure_name -- placed at end because it is a long string
FROM hospital_edit
LEFT OUTER JOIN procedures_detail
ON hospital_edit.hospital_id = procedures_detail.care_hospital_id
WHERE cast(procedures_detail.care_score AS INT) <= 100 -- Excludes Emergency Room Scores > 100
GROUP BY procedures_detail.procedure_id, procedures_detail.measure_name
ORDER BY Var_Score DESC, Avg_Score ASC
LIMIT 10;
