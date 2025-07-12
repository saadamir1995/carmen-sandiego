{{ config(tags=['analysis', 'question_b']) }}

select 
    witness_month,
    month_name,
    total_sightings,
    armed_jacket_no_hat,
    armed_jacket_no_hat_percentage,
    armed_percentage,
    jacket_percentage,
    hat_percentage
from {{ ref('monthly_appearance_probability') }}
order by witness_month;