-- Hospitals and Patients SQL query

-- Are average scores for hospital quality or hospital procedurarl variability correlated with patient survey responses?

-- Pull the survey responses for the top 10 hospitals and the hospitals completing the
-- top 10 most variable procedures to determine if there is any correlation.

-- Survey Results for top 10 Hospitals
SELECT hospital_id, hospital_name,
    HCAHPS_Base_Score, -- max 80
    HCAHPS_Consistency_Score -- max 20
FROM survey_edit
WHERE (hospital_id = 450851 OR hospital_id = 050111 OR hospital_id = 310031
     OR hospital_id = 670071 OR hospital_id = 050723 OR hospital_id = 150165
     OR hospital_id = 150175 OR hospital_id = 050732 OR hospital_id = 050561
     OR hospital_id = 170186)
LIMIT 10;


-- Survey Results for all hospitals participating in top 10 variable procedures
SELECT procedures_detail.procedure_id,
    COUNT(survey_edit.HCAHPS_Base_Score) AS No_S,
    COUNT(procedures_detail.care_hospital_id) AS No_H,
    round(avg(cast(survey_edit.HCAHPS_Base_Score AS INT)),2) AS Survey_Score,
    round(avg(cast(survey_edit.HCAHPS_Consistency_Score AS INT)),2) AS Survey_Consistency_Score,
    procedures_detail.measure_name -- placed at end because it is a long string
FROM procedures_detail
LEFT OUTER JOIN survey_edit
ON procedures_detail.care_hospital_id = survey_edit.hospital_id
GROUP BY procedures_detail.procedure_id, procedures_detail.measure_name
HAVING (procedures_detail.procedure_id = 'OP_20' OR procedures_detail.procedure_id = 'ED_2b'
    OR procedures_detail.procedure_id = 'OP_23' OR procedures_detail.procedure_id = 'STK_4'
    OR procedures_detail.procedure_id = 'VTE_5' OR procedures_detail.procedure_id = 'VTE_1'
    OR procedures_detail.procedure_id = 'STK_8' OR procedures_detail.procedure_id = 'IMM_2'
    OR procedures_detail.procedure_id = 'HF_1' OR procedures_detail.procedure_id = 'STK_1')

ORDER BY Survey_Score DESC, Survey_Consistency_Score DESC
LIMIT 10;
