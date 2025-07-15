{{ config(materialized='table') }}

with agent_data as (
    select 
        agent,
        region,
        -- Take the first city_agent for each agent/region combination
        min(city_agent) as city_agent,
        count(*) as total_reports_filed
    from {{ ref('int_all_sightings') }}
    where agent is not null
    group by agent, region
)

select
    row_number() over (order by agent, region) as agent_id,
    agent as agent_name,
    city_agent,
    region,
    total_reports_filed
from agent_data