-- Question A: For each month, which agency region is Carmen Sandiego most likely to be found?
{{ config(tags=['analysis', 'question_a']) }}

select 
    witness_month,
    month_name,
    region as most_likely_region,
    probability_percentage,
    sightings_count
from {{ ref('monthly_region_probability') }}
where region_rank = 1
order by witness_month