{{ config(materialized='view') }}

select
    sighting::date as date_witness,
    "报道"::date as date_agent,
    citizen as witness,
    officer as agent,
    "纬度"::decimal(10,5) as latitude,
    "经度"::decimal(10,5) as longitude,
    city,
    nation as country,
    city_interpol as city_agent,
    {{ standardize_boolean('has_weapon') }} as has_weapon,
    {{ standardize_boolean('has_hat') }} as has_hat,
    {{ standardize_boolean('has_jacket') }} as has_jacket,
    behavior,
    'ASIA' as region
from {{ ref('asia') }}
where sighting is not null
  and citizen is not null
  and officer is not null