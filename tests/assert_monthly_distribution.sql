-- Verify data is reasonably distributed across months (no missing months)

select 
    witness_month,
    count(*) as sightings
from {{ ref('fact_sightings') }}
group by witness_month
having count(*) < 500  -- Flag months with suspiciously low activity
order by witness_month