-- Ensure all foreign keys in fact table have corresponding dimension records

with integrity_check as (
    select 
        sum(case when a.agent_id is null then 1 else 0 end) as orphaned_agents,
        sum(case when w.witness_id is null then 1 else 0 end) as orphaned_witnesses,
        sum(case when l.location_id is null then 1 else 0 end) as orphaned_locations
    from {{ ref('fact_sightings') }} f
    left join {{ ref('dim_agents') }} a on f.agent_id = a.agent_id
    left join {{ ref('dim_witnesses') }} w on f.witness_id = w.witness_id  
    left join {{ ref('dim_locations') }} l on f.location_id = l.location_id
)

select *
from integrity_check
where orphaned_agents > 0 
   or orphaned_witnesses > 0 
   or orphaned_locations > 0