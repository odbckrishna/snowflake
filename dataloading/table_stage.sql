# Internal table Stage Sample.
/*
Sample file attached.


below are the steps we need to perform.

step 1 : Copy the file sample file at system.
Step 2 : Target Table creation at snowflake.
Step 3 : upload the file using the PUT command.
Step 4 : push the file from staging to Table location using COPY command.
Step 5 : Validation.
*/
Step 1 
below are the sample rows, you can download the file or copy below content and prepare the new sample file at C:\snowflake file at your system.

file name : sample.csv

first_name,last_name,email,streetaddress,city,start_date
sai,krishna,sai.krishna@dummy.com,street,london,asd
saa,fsgfishna,sai.krishna@dummy.com,street,london,asd
sab,fewishna,sai.krishna@dummy.com,street,london,asd
sac,adishna,sai.krishna@dummy.com,street,london,sas
sad,zxishna,sai.krishna@dummy.com,street,london,sas
sae,zrishna,sai.krishna@dummy.com,street,london,sas

Step 2 
create or replace table demo_db.public.emp_basic_1 (
         first_name string ,
         last_name string ,
         email string ,
         streetaddress string ,
         city string ,
         start_date string
);

Step 3 
make sure file got placed on below location 
log in to the snow sql and move to the DEMO_DB and PUBLIC Schema and run the below command via snowsql

put file://C://snowflake//sample.csv @%EMP_BASIC_1;

validate the table stage.
list @%EMP_BASIC_1;
+---------------+------+----------------------------------+------------------------------+
| name          | size | md5                              | last_modified                |
|---------------+------+----------------------------------+------------------------------|
| sample.csv.gz |  160 | 0a5df71cf65860e902aad374a16ce166 | Wed, 2 Mar 2022 23:05:02 GMT |
+---------------+------+----------------------------------+------------------------------+

Step 4
Push the file from staging to target table.
Command : 

copy into demo_db.public.emp_basic_1
from @demo_db.public.%emp_basic_1
file_format = (type = csv field_optionally_enclosed_by='"' skip_header=1) ;


Step 5

Validation 
>select * from demo_db.public.emp_basic_1;
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
7 Row(s) produced. Time Elapsed: 0.344s
