# not necessary to run, stored as reference
# if run, ensure you are in the MIDS_W205_E1/ git repository folder

# Load Data Lake into Hadoop
cd loading_and_modelling/
chmod +x load_data_lake.sh
./load_data_lake.sh

# Build Base Tables in Hive
chmod +x hive_base_ddl.sql
hive -f hive_base_ddl.sql

# Transform to ER Model
cd ..
cd transforming/
chmod +x transform_to_ER.sql
hive -f transform_to_ER.sql
