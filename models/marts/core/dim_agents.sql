{{ config(materialized='table') }}

with agent_data as (
    select distinct
        agent,
        city_agent,
        region
    from {{ ref('int_all_sightings') }}
    where agent is not null
)

select
    row_number() over (order by agent, region) as agent_id,
    agent as agent_name,
    city_agent,
    region,
    count(*) over (partition by agent) as total_reports_filed
from agent_data