-- storage integration creation

create or replace storage integration hm_customers_storage
  type = external_stage
  storage_provider = gcs
  enabled = true
  storage_allowed_locations = ('gcs://hm-fashion-recommendation-parquet/customers');
  
desc integration  hm_customers_storage;

-- file format creation
create or replace file format hm_parquet
  TYPE = 'PARQUET'
  COMPRESSION = 'AUTO'
  BINARY_AS_TEXT = TRUE;

-- stage creation
Create or replace stage hm_customers_stage
  storage_integration = hm_customers_storage
  url = 'gcs://hm-fashion-recommendation-parquet/customers'
  file_format = hm_parquet;
  
-- sample data select 
select 
$1 from @demo_db.public.hm_customers_stage
(file_format => hm_parquet)


--flating on sql
select 
$1:Active as Active,
$1:FN as FN,
$1:age as age,
$1:club_member_status as club_member_status,
$1:customer_id as customer_id,
$1:fashion_news_frequency as fashion_news_frequency,
$1:postal_code as postal_code
from @demo_db.public.hm_customers_stage
(file_format => hm_parquet);


-- create view on top of gcp data 
create or replace view vw_hm_customers as 
select 
$1:Active as Active,
$1:FN as FN,
$1:age as age,
$1:club_member_status as club_member_status,
$1:customer_id as customer_id,
$1:fashion_news_frequency as fashion_news_frequency,
$1:postal_code as postal_code
from @demo_db.public.hm_customers_stage
(file_format => hm_parquet);

-- move data from gcp to snowflake
create or replace table tbl_hm_customers as 
select 
$1:Active as Active,
$1:FN as FN,
$1:age as age,
$1:club_member_status as club_member_status,
$1:customer_id as customer_id,
$1:fashion_news_frequency as fashion_news_frequency,
$1:postal_code as postal_code
from @demo_db.public.hm_customers_stage
(file_format => hm_parquet) 
