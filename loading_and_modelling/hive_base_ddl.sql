--Create Hospitals Table

DROP TABLE hospitals;

CREATE EXTERNAL TABLE hospitals(hospital_id STRING,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county_name STRING,
    phone_number STRING,
    hospital_type STRING,
    hospital_ownership STRING,
    emergency_services STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "'",
    "escapeChar" = "\\"
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals';


--Create Effective Care Table
DROP TABLE care;

CREATE EXTERNAL TABLE care(
    hospital_id STRING,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county_name STRING,
    phone_number STRING,
    condition STRING,
    procedure_id STRING,
    measure_name STRING,
    score INT,-- INT
    sample STRING,-- INT
    footnote STRING,
    measure_start DATE,
    measure_end DATE)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "'",
    "escapeChar" = "\\"
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';


--Create Readmissions Table
DROP TABLE readmissions;

CREATE EXTERNAL TABLE readmissions(
    hospital_id STRING,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county_name STRING,
    phone_number STRING,
    measure_name STRING,
    procedure_id STRING,
    condition STRING,
    national_comparison STRING,
    denominator STRING,
    score INT, -- INT
    lower_est STRING,-- INT
    higher_est STRING,-- INT
    footnote STRING,
    measure_start DATE,
    measure_end DATE)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "'",
    "escapeChar" = "\\"
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';


--Create Measures/Procedures Table
DROP TABLE procedures;

CREATE EXTERNAL TABLE procedures(
    measure_name STRING,
    procedure_id STRING,
    measure_start_quarter STRING,
    measure_start DATE,
    measure_end_quarter STRING,
    measure_end DATE)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "'",
    "escapeChar" = "\\"
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures';


--Create Surveys Table
DROP TABLE surveys;

CREATE EXTERNAL TABLE surveys(
    hospital_id STRING,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county_name STRING,
    Communication_with_Nurses_Achievement_Points STRING,
    Communication_with_Nurses_Improvement_Points STRING,
    Communication_with_Nurses_Dimension_Score STRING,
    Communication_with_Doctors_Achievement_Points STRING,
    Communication_with_Doctors_Improvement_Points STRING,
    Communication_with_Doctors_Dimension_Score STRING,
    Responsiveness_of_Hospital_Staff_Achievement_Points STRING,
    Responsiveness_of_Hospital_Staff_Improvement_Points STRING,
    Responsiveness_of_Hospital_Staff_Dimension_Score STRING,
    Pain_Management_Achievement_Points STRING,
    Pain_Management_Improvement_Points STRING,
    Pain_Management_Dimension_Score STRING,
    Communication_about_Medicines_Achievement_Points STRING,
    Communication_about_Medicines_Improvement_Points STRING,
    Communication_about_Medicines_Dimension_Score STRING,
    Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points STRING,
    Cleanliness_and_Quietness_of_Hospital_Environment_Improvement_Points STRING,
    Cleanliness_and_Quietness_of_Hospital_Environment_Dimension_Score STRING,
    Discharge_Information_Achievement_Points STRING,
    Discharge_Information_Improvement_Points STRING,
    Discharge_Information_Dimension_Score STRING,
    Overall_Rating_of_Hospital_Achievement_Points STRING,
    Overall_Rating_of_Hospital_Improvement_Points STRING,
    Overall_Rating_of_Hospital_Dimension_Score STRING,
    HCAHPS_Base_Score STRING,-- INT
    HCAHPS_Consistency_Score STRING)-- INT
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "'",
    "escapeChar" = "\\"
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/survey_responses';
