-- Verify all 8 regions are represented in the final dataset

select count(distinct region) as region_count
from {{ ref('fact_sightings') }}
having count(distinct region) != 8

