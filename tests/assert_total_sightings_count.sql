-- Verify we have the expected total number of sightings across all regions

select count(*) as actual_count
from {{ ref('fact_sightings') }}
having count(*) != 13590  -- Expected total from Excel analysis