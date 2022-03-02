# unload the data from table to local file.

Step 1 : Create a temp table at demo db 
Step 2 : Create a staging for the unload object 
Step 3 : using GET command to unload the data to a file.
Step 4 : Validation

Step 1 :
Run the below command to create the sample table
create or replace table demo_db.public.unload_region as select * from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1000"."REGION";

Step 2 : 

run the below command to create the staging for the table object.

copy into @%unload_region
from unload_region
file_format = (type = csv field_optionally_enclosed_by='"');

Step 3 : 
run the below command to upload the data from staging layer to local file.

get @demo_db.public.%unload_region file://C://snowflake//;

this will give you the below information,
+-------------------+------+------------+---------+
| file              | size | status     | message |
|-------------------+------+------------+---------|
| data_0_0_0.csv.gz |  261 | DOWNLOADED |         |
+-------------------+------+------------+---------+

Step 4 : 

validate the file at described location  "C:/snowflake/" a gzip file will be created extract it and verifiy the file.
