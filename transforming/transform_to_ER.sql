
-- This script creates tables as select from the original imported tables from the hive_base_ddl.sql script

-- Drop extra ""'s from all fields in Hospital Table
DROP TABLE hospital_edit;

CREATE TABLE hospital_edit
   AS
SELECT substr(hospital_id, 2, length(hospital_id) - 2) AS hospital_id,
    substr(hospital_name, 2, length(hospital_name) - 2) AS hospital_name,
    substr(address, 2, length(address) - 2) AS address,
    substr(city, 2, length(city) - 2) AS city,
    substr(state, 2, length(state) - 2) AS state,
    substr(zip_code, 2, length(zip_code) - 2) AS zip_code,
    substr(county_name, 2, length(county_name) - 2) AS county_name,
    substr(phone_number, 2, length(phone_number) - 2) AS phone_number,
    substr(hospital_type, 2, length(hospital_type) - 2) AS hospital_type,
    substr(hospital_ownership, 2, length(hospital_ownership) - 2) AS hospital_ownership,
    substr(emergency_services, 2, length(emergency_services) - 2) AS emergency_services
FROM hospitals;




-- Drop extra ""'s from all fields in Survey Table and keep only final scores
DROP TABLE survey_edit;

CREATE TABLE survey_edit
   AS
SELECT substr(hospital_id, 2, length(hospital_id) - 2) AS hospital_id,
    substr(hospital_name, 2, length(hospital_name) - 2) AS hospital_name,
    substr(HCAHPS_Base_Score, 2, length(HCAHPS_Base_Score) - 2) AS HCAHPS_Base_Score,
    substr(HCAHPS_Consistency_Score, 2, length(HCAHPS_Consistency_Score) - 2) AS HCAHPS_Consistency_Score
FROM surveys;




-- Combine Measures, Readmissions and Care Data together into one table (to match ER)
-- Take this opportunity to remove extra quotes from all data by using substr()
-- Build a temporary table to combine procedures&care tables, then join this temporary
-- table with readmissions. Not sure if I can join 3 tables together in one call?
-- Couldn't get that to work.

DROP TABLE procedures_detail_temp;

CREATE TABLE procedures_detail_temp
    -- STORED AS TEXTFILE
    -- LOCATION '/user/w205/hospital_compare/readmissions'
   AS
SELECT
    substr(procedures.procedure_id, 2, length(procedures.procedure_id) - 2) AS procedure_id,
    substr(procedures.measure_name, 2, length(procedures.measure_name) - 2) AS measure_name,
    substr(procedures.measure_start_quarter, 2, length(procedures.measure_start_quarter) - 2) AS measure_start_quarter,
    substr(procedures.measure_start, 2, length(procedures.measure_start) - 2) AS measure_start,
    substr(procedures.measure_end_quarter, 2, length(procedures.measure_end_quarter) - 2) AS measure_end_quarter,
    substr(procedures.measure_end, 2, length(procedures.measure_end) - 2) AS measure_end,
    substr(care.hospital_id, 2, length(care.hospital_id) - 2) AS care_hospital_id,
    substr(care.condition, 2, length(care.condition) - 2) AS care_condition,
    substr(care.score, 2, length(care.score) - 2) AS care_score,
    substr(care.sample, 2, length(care.sample) - 2) AS care_sample,
    substr(care.footnote, 2, length(care.footnote) - 2) AS care_footnote
FROM procedures
LEFT OUTER JOIN care
ON procedures.procedure_id = care.procedure_id;


DROP TABLE procedures_detail;

CREATE TABLE procedures_detail
   AS
SELECT procedures_detail_temp.*,
    substr(readmissions.hospital_id, 2, length(readmissions.hospital_id) - 2) AS readmissions_hospital_id,
    substr(readmissions.condition, 2, length(readmissions.condition) - 2) AS readmissions_condition,
    substr(readmissions.national_comparison, 2, length(readmissions.national_comparison) - 2) AS readmissions_national_comparison,
    substr(readmissions.denominator, 2, length(readmissions.denominator) - 2) AS readmissions_denominator,
    substr(readmissions.score, 2, length(readmissions.score) - 2) AS readmissions_score,
    substr(readmissions.lower_est, 2, length(readmissions.lower_est) - 2) AS readmissions_lower_est,
    substr(readmissions.higher_est, 2, length(readmissions.higher_est) - 2) AS readmissions_higher_est,
    substr(readmissions.footnote, 2, length(readmissions.footnote) - 2) AS readmissions_footnote
FROM procedures_detail_temp
LEFT OUTER JOIN readmissions
ON procedures_detail_temp.procedure_id = readmissions.procedure_id;

DROP TABLE procedures_detail_temp;
