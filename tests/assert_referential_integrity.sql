-- Verify all foreign keys have valid references

{{ config(severity='error') }}

with orphaned_records as (
    select 'fact_sightings missing agent' as issue, count(*) as count
    from {{ ref('fact_sightings') }} f
    left join {{ ref('dim_agents') }} a on f.agent_id = a.agent_id
    where f.agent_id is not null and a.agent_id is null
    
    union all
    
    select 'fact_sightings missing witness' as issue, count(*) as count
    from {{ ref('fact_sightings') }} f
    left join {{ ref('dim_witnesses') }} w on f.witness_id = w.witness_id
    where f.witness_id is not null and w.witness_id is null
    
    union all
    
    select 'fact_sightings missing location' as issue, count(*) as count
    from {{ ref('fact_sightings') }} f
    left join {{ ref('dim_locations') }} l on f.location_id = l.location_id
    where f.location_id is not null and l.location_id is null
)

select * from orphaned_records
where count > 0