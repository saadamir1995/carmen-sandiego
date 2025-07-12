-- Ensure agent filing date is never before witness date (logical impossibility)

select count(*) as illogical_dates
from {{ ref('fact_sightings') }}
where date_agent < date_witness
having count(*) > 0