# Data loading using named staging.

Step 1 : Create Target table  
Step 2 : Create Staging object.
Step 3 : Place the sample file at local system
Step 4 : Execute the put statement to move the file from local to Staging area.
Step 5 : Execute the COPY statment to move the staging to Target object.
Step 6 : Validation.


Step 1 

Create target table using below DDL


create or replace table demo_db.public.sample_name_stage_emp_data (
         first_name string ,
         last_name string ,
         email string ,
         streetaddress string ,
         city string ,
         start_date string
);

Step 2

Create Staging object using sql command.

create or replace stage demo_db.public.sample_name_stage;

Step 3

Create a sample file with below content or copy the sample file to windows location.

first_name,last_name,email,streetaddress,city,start_date
sai,krishna,sai.krishna@dummy.com,street,london,asd
saa,fsgfishna,sai.krishna@dummy.com,street,london,asd
sab,fewishna,sai.krishna@dummy.com,street,london,asd
sac,adishna,sai.krishna@dummy.com,street,london,sas
sad,zxishna,sai.krishna@dummy.com,street,london,sas
sae,zrishna,sai.krishna@dummy.com,street,london,sas


Step 4 : 

Execute the PUT Statment to move the file from local to staging location.

put file://C://snowflake//sample.csv @demo_db.public.sample_name_stage/emp_fileset;

Step 5 : 

execute the copy command to move the file from staging to target table.

copy into demo_db.public.sample_name_stage_emp_data
from @demo_db.public.sample_name_stage/emp_fileset
file_format = (skip_header = 1);

Step 6 : 

Validate the data.
select * from demo_db.public.sample_name_stage_emp_data;
+------------+-----------+-----------------------+---------------+--------+------------+
| FIRST_NAME | LAST_NAME | EMAIL                 | STREETADDRESS | CITY   | START_DATE |
|------------+-----------+-----------------------+---------------+--------+------------|
| sai        | krishna   | sai.krishna@dummy.com | street        | london | asd        |
| saa        | fsgfishna | sai.krishna@dummy.com | street        | london | asd        |
| sab        | fewishna  | sai.krishna@dummy.com | street        | london | asd        |
| sac        | adishna   | sai.krishna@dummy.com | street        | london | sas        |
| sad        | zxishna   | sai.krishna@dummy.com | street        | london | sas        |
| sae        | zrishna   | sai.krishna@dummy.com | street        | london | sas        |
+------------+-----------+-----------------------+---------------+--------+------------+
