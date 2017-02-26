-- Best States SQL query

-- What states are models of high-quality care?

-- Tables to use: procedures_detail, hospital_edit

-- Selection Criteria:

-- Grouping by State, we want to see the highest average scores across all of their procedures
-- from every hospital within that state. Not just the average of all hospitals!

-- The number of different procedures for each state isn't as valuable of a metric at the state level
-- simply due to population density and funding that may not be available for complex procedures in that state.
-- This constraint was not included.

-- An additional constraint on total score variance was not used here, as in the majority of states
-- the variance appears to be near 100, suggesting there is at least one hospital with very poor ratings
-- in that state, despite the high overall average we are seeing.

-- Scores relating to the emergency department were excluded from aggregation, as they went beyond the standard 0-100
-- scale.

-- Focusing on only procedure care scores, not readmission scores as these are difficult
-- to compare to one another because high procedure care scores are good while low
-- readmissions scores (score / denominator) are good. A multi-filter could have occured
-- between these two metrics, however it was decided not to pursue this for this assignment.

-- Had to convert all of our number columns to INT before aggregating, used the cast() function.

SELECT hospital_edit.state,
    COUNT(hospital_edit.hospital_id),
    SUM(cast(procedures_detail.care_score AS INT)) AS Total_Score,
    round(avg(cast(procedures_detail.care_score AS INT)),2) AS Avg_Score,
    max(cast(procedures_detail.care_score AS INT)) - min(cast(procedures_detail.care_score AS INT)) AS Var_Score,
    COUNT(cast(procedures_detail.care_score AS INT)) AS Count_Score
FROM hospital_edit
LEFT OUTER JOIN procedures_detail
ON hospital_edit.hospital_id = procedures_detail.care_hospital_id
WHERE cast(procedures_detail.care_score AS INT) <= 100 -- Excludes Emergency Room Scores > 100
GROUP BY hospital_edit.state
ORDER BY Avg_Score DESC
LIMIT 10;
