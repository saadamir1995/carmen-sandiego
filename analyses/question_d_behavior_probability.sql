-- Question D: For each month, what is the probability Ms. Sandiego exhibits one of her three most occurring behaviors?
{{ config(tags=['analysis', 'question_d']) }}

select 
    witness_month,
    month_name,
    total_monthly_sightings,
    top_3_behavior_sightings,
    top_3_behavior_percentage
from {{ ref('monthly_behavior_probability') }}
order by witness_month