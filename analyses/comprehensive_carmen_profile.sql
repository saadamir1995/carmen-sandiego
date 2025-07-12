{{ config(tags=['analysis', 'profile']) }}

with carmen_overview as (
    select
        count(*) as total_sightings,
        count(distinct location_id) as unique_locations,
        count(distinct agent_id) as agents_involved,
        count(distinct witness_id) as witnesses_involved,
        min(date_witness) as first_known_sighting,
        max(date_witness) as last_known_sighting,
        round(avg(reporting_delay_days), 1) as avg_reporting_delay,
        
        -- Equipment analysis
        round(avg(case when has_weapon then 1.0 else 0.0 end) * 100, 1) as armed_percentage,
        round(avg(case when has_hat then 1.0 else 0.0 end) * 100, 1) as hat_percentage,
        round(avg(case when has_jacket then 1.0 else 0.0 end) * 100, 1) as jacket_percentage,
        
        -- Regional distribution
        count(case when region = 'EUROPE' then 1 end) as europe_sightings,
        count(case when region = 'ASIA' then 1 end) as asia_sightings,
        count(case when region = 'AMERICA' then 1 end) as america_sightings,
        count(case when region = 'AFRICA' then 1 end) as africa_sightings,
        count(case when region = 'AUSTRALIA' then 1 end) as australia_sightings,
        count(case when region = 'ATLANTIC' then 1 end) as atlantic_sightings,
        count(case when region = 'INDIAN' then 1 end) as indian_sightings,
        count(case when region = 'PACIFIC' then 1 end) as pacific_sightings
        
    from {{ ref('fact_sightings') }}
),

top_locations as (
    select 
        l.country,
        l.city,
        count(*) as sighting_count
    from {{ ref('fact_sightings') }} f
    join {{ ref('dim_locations') }} l on f.location_id = l.location_id
    group by l.country, l.city
    order by sighting_count desc
    limit 10
)

select 
    'CARMEN SANDIEGO INTELLIGENCE PROFILE' as report_type,
    co.*,
    
    -- Calculate active years
    extract(year from co.last_known_sighting) - extract(year from co.first_known_sighting) + 1 as years_active,
    
    -- Most active region
    case 
        when co.europe_sightings >= greatest(co.asia_sightings, co.america_sightings, co.africa_sightings) then 'EUROPE'
        when co.asia_sightings >= greatest(co.america_sightings, co.africa_sightings) then 'ASIA'
        when co.america_sightings >= co.africa_sightings then 'AMERICA'
        else 'AFRICA'
    end as primary_region
    
from carmen_overview co;