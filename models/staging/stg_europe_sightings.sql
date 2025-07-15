{{ config(materialized='view') }}

select
    date_witness::date as date_witness,
    date_filed::date as date_agent,
    witness,
    agent,
    lat_::decimal(10,5) as latitude,
    long_::decimal(10,5) as longitude,
    city,
    country,
    region_hq as city_agent,
    {{ standardize_boolean('"armed?"') }} as has_weapon,
    {{ standardize_boolean('"chapeau?"') }} as has_hat,
    {{ standardize_boolean('"coat?"') }} as has_jacket,
    observed_action as behavior,
    'EUROPE' as region
from {{ ref('europe') }}
where date_witness is not null
  and witness is not null
  and agent is not null