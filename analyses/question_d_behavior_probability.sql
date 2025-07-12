{{ config(tags=['analysis', 'question_d']) }}

select 
    witness_month,
    month_name,
    total_monthly_sightings,
    top_3_behavior_sightings,
    top_3_behavior_percentage,
    case 
        when top_3_behavior_percentage > 52 then 'HIGH'
        when top_3_behavior_percentage > 50 then 'MEDIUM'
        else 'LOW'
    end as behavior_consistency_level
from {{ ref('monthly_behavior_probability') }}
order by witness_month;