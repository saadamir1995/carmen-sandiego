-- Ensure essential fields are never NULL
{{ config(severity='error') }}

with completeness_check as (
    select 
        'date_witness' as field_name,
        count(*) as total_records,
        count(date_witness) as non_null_records,
        count(*) - count(date_witness) as null_count
    from {{ ref('fact_sightings') }}
    
    union all
    
    select 
        'witness_id' as field_name,
        count(*) as total_records,
        count(witness_id) as non_null_records,
        count(*) - count(witness_id) as null_count
    from {{ ref('fact_sightings') }}
    
    union all
    
    select 
        'agent_id' as field_name,
        count(*) as total_records,
        count(agent_id) as non_null_records,
        count(*) - count(agent_id) as null_count
    from {{ ref('fact_sightings') }}
    
    union all
    
    select 
        'region' as field_name,
        count(*) as total_records,
        count(region) as non_null_records,
        count(*) - count(region) as null_count
    from {{ ref('fact_sightings') }}
)

select * from completeness_check
where null_count > 0