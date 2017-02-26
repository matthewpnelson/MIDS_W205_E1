
# Load Data Lake, Build Base Tables in Hive, Transform to ER Model
#cd MIDS-W205_A1/ assume already in this folder
git checkout *
git pull origin master
cd exercise_1/loading_and_modelling/
chmod +x load_data_lake.sh
./ load_data_lake.sh
chmod +x hive_base_ddl.sql
hive -f hive_base_ddl.sql
cd ..
cd transforming/
chmod +x transform_to_ER.sql
hive -f transform_to_ER.sql


# boot up Spark SQL
/data/spark15/bin/spark-sql
