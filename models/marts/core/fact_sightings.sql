{{ config(materialized='table') }}

with sightings_with_keys as (
    select
        s.*,
        a.agent_id,
        w.witness_id,
        l.location_id
    from {{ ref('int_all_sightings') }} s
    left join {{ ref('dim_agents') }} a 
        on s.agent = a.agent_name 
        and s.region = a.region
    left join {{ ref('dim_witnesses') }} w 
        on s.witness = w.witness_name 
        and s.region = w.region
    left join {{ ref('dim_locations') }} l 
        on s.city = l.city 
        and s.country = l.country
        and s.region = l.region
)

select
    global_sighting_id as sighting_id,
    date_witness,
    date_agent,
    witness_id,
    agent_id,
    location_id,
    has_weapon,
    has_hat,
    has_jacket,
    behavior,
    region,
    year_month,
    witness_year,
    witness_month,
    agent_year,
    agent_month,
    reporting_delay_days
from sightings_with_keys
