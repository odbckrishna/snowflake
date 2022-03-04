create or replace storage integration gcs_covid_data
  type = external_stage
  storage_provider = gcs
  enabled = true
  storage_allowed_locations = ('gcs://covidlsa');
  
DESC INTEGRATION gcs_covid_data;

create or replace file format covid_cases_file
type = csv field_delimiter = ',' skip_header = 1 null_if = ('NULL', 'null') empty_field_as_null = true;

desc file format my_csv_format;

create or replace stage gcs_data_movement
  storage_integration = gcs_covid_data
  url = 'gcs://covidlsa'
  file_format = covid_cases_file;

create or replace table covid_cases as 
select 
t.$1 as Date,
current_timestamp as Timestamp,
t.$3 as Daily_Confirmed,
t.$4 as Number_of_cases,
t.$5 as Daily_Recovered,
t.$6 as Total_Recovered,
t.$7 as Daily_Deceased,
t.$8 as Total_Deceased
from @gcs_data_movement/ t;


select * from covid_cases ;
