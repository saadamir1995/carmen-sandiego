-- Ensure no sighting dates are in the future

select count(*) as future_sightings
from {{ ref('fact_sightings') }}
where date_witness > current_date
having count(*) > 0