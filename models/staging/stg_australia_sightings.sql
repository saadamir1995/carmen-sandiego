{{ config(materialized='view') }}

select
    witnessed::date as date_witness,
    reported::date as date_agent,
    observer as witness,
    field_chap as agent,
    lat::decimal(10,5) as latitude,
    long::decimal(10,5) as longitude,
    place as city,
    nation as country,
    interpol_spot as city_agent,
    {{ standardize_boolean('has_weapon') }} as has_weapon,
    {{ standardize_boolean('has_hat') }} as has_hat,
    {{ standardize_boolean('has_jacket') }} as has_jacket,
    state_of_mind as behavior,
    'AUSTRALIA' as region
from {{ ref('australia') }}
where witnessed is not null
  and observer is not null
  and field_chap is not null