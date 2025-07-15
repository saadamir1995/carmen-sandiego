-- Ensure globally unique sighting IDs across all regions
{{ config(severity='error') }}

select 
    sighting_id, 
    count(*) as duplicate_count
from {{ ref('fact_sightings') }}
group by sighting_id
having count(*) > 1