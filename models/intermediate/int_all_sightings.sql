{{ config(materialized='view') }}

with all_sightings as (
    select * from {{ ref('stg_europe_sightings') }}
    union all
    select * from {{ ref('stg_asia_sightings') }}
    union all
    select * from {{ ref('stg_africa_sightings') }}
    union all
    select * from {{ ref('stg_america_sightings') }}
    union all
    select * from {{ ref('stg_australia_sightings') }}
    union all
    select * from {{ ref('stg_atlantic_sightings') }}
    union all
    select * from {{ ref('stg_indian_sightings') }}
    union all
    select * from {{ ref('stg_pacific_sightings') }}
),

enriched_sightings as (
    select
        date_witness,
        date_agent,
        witness,
        agent,
        latitude,
        longitude,
        city,
        country,
        city_agent,
        has_weapon,
        has_hat,
        has_jacket,
        behavior,
        region,
        extract(year from date_witness) as witness_year,
        extract(month from date_witness) as witness_month,
        to_char(date_witness, 'YYYY-MM') as year_month,
        extract(year from date_agent) as agent_year,
        extract(month from date_agent) as agent_month,
        date_agent - date_witness as reporting_delay_days
    from all_sightings
)

select * from enriched_sightings