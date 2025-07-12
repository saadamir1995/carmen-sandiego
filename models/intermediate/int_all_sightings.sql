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
        row_number() over (order by date_witness, region, witness) as global_sighting_id,
        *,
        extract(year from date_witness) as witness_year,
        extract(month from date_witness) as witness_month,
        to_char(date_witness, 'YYYY-MM') as year_month,
        extract(year from date_agent) as agent_year,
        extract(month from date_agent) as agent_month,
        date_agent - date_witness as reporting_delay_days
    from all_sightings
)

select * from enriched_sightings