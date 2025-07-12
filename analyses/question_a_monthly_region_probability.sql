{{ config(tags=['analysis', 'question_a']) }}

select 
    witness_month,
    month_name,
    region,
    sightings_count,
    probability_percentage,
    region_rank
from {{ ref('monthly_region_probability') }}
where region_rank = 1
order by witness_month;