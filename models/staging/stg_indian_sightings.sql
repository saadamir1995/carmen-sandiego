{{ config(materialized='view') }}

select
    date_witness::date as date_witness,
    date_agent::date as date_agent,
    witness,
    agent,
    latitude::decimal(10,5) as latitude,
    longitude::decimal(10,5) as longitude,
    city,
    country,
    region_hq as city_agent,
    {{ standardize_boolean('has_weapon') }} as has_weapon,
    {{ standardize_boolean('has_hat') }} as has_hat,
    {{ standardize_boolean('has_jacket') }} as has_jacket,
    behavior,
    'INDIAN' as region
from {{ ref('indian') }}
where date_witness is not null
  and witness is not null
  and agent is not null