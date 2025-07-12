-- Check for suspicious behavior patterns or data quality issues

select 
    behavior,
    count(*) as occurrence_count
from {{ ref('fact_sightings') }}
where behavior is not null
  and length(trim(behavior)) > 0
group by behavior
having count(*) = 1  -- Single occurrence behaviors might be data entry errors
order by occurrence_count