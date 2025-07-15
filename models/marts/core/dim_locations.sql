{{ config(materialized='table') }}

with location_data as (
    select distinct
        city,
        country,
        latitude,
        longitude,
        region
    from {{ ref('int_all_sightings') }}
    where city is not null 
      and country is not null
)

select
    row_number() over (order by country, city, region) as location_id,
    city,
    country,
    latitude,
    longitude,
    region
from location_data