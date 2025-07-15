-- Ensure all source data flows correctly through the pipeline
{{ config(severity='error') }}

with source_totals as (
    select 
        'EUROPE' as region,
        (select count(*) from {{ ref('europe') }}) as source_count,
        (select count(*) from {{ ref('stg_europe_sightings') }}) as staging_count,
        (select count(*) from {{ ref('fact_sightings') }} where region = 'EUROPE') as fact_count
    
    union all
    
    select 
        'ASIA' as region,
        (select count(*) from {{ ref('asia') }}) as source_count,
        (select count(*) from {{ ref('stg_asia_sightings') }}) as staging_count,
        (select count(*) from {{ ref('fact_sightings') }} where region = 'ASIA') as fact_count
    
    union all
    
    select 
        'AFRICA' as region,
        (select count(*) from {{ ref('africa') }}) as source_count,
        (select count(*) from {{ ref('stg_africa_sightings') }}) as staging_count,
        (select count(*) from {{ ref('fact_sightings') }} where region = 'AFRICA') as fact_count
    
    union all
    
    select 
        'AMERICA' as region,
        (select count(*) from {{ ref('america') }}) as source_count,
        (select count(*) from {{ ref('stg_america_sightings') }}) as staging_count,
        (select count(*) from {{ ref('fact_sightings') }} where region = 'AMERICA') as fact_count
    
    union all
    
    select 
        'AUSTRALIA' as region,
        (select count(*) from {{ ref('australia') }}) as source_count,
        (select count(*) from {{ ref('stg_australia_sightings') }}) as staging_count,
        (select count(*) from {{ ref('fact_sightings') }} where region = 'AUSTRALIA') as fact_count
    
    union all
    
    select 
        'ATLANTIC' as region,
        (select count(*) from {{ ref('atlantic') }}) as source_count,
        (select count(*) from {{ ref('stg_atlantic_sightings') }}) as staging_count,
        (select count(*) from {{ ref('fact_sightings') }} where region = 'ATLANTIC') as fact_count
    
    union all
    
    select 
        'INDIAN' as region,
        (select count(*) from {{ ref('indian') }}) as source_count,
        (select count(*) from {{ ref('stg_indian_sightings') }}) as staging_count,
        (select count(*) from {{ ref('fact_sightings') }} where region = 'INDIAN') as fact_count
    
    union all
    
    select 
        'PACIFIC' as region,
        (select count(*) from {{ ref('pacific') }}) as source_count,
        (select count(*) from {{ ref('stg_pacific_sightings') }}) as staging_count,
        (select count(*) from {{ ref('fact_sightings') }} where region = 'PACIFIC') as fact_count
)

select 
    region,
    source_count,
    staging_count,
    fact_count,
    source_count - staging_count as source_staging_diff,
    staging_count - fact_count as staging_fact_diff
from source_totals
where source_count != staging_count 
   or staging_count != fact_count