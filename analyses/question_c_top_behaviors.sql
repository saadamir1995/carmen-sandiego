-- Question C: What are the three most occurring behaviors of Ms. Sandiego?
{{ config(tags=['analysis', 'question_c']) }}

select 
    behavior_rank,
    behavior,
    occurrence_count,
    percentage,
    case 
        when behavior_rank <= 3 then 'TOP 3'
        else 'Other'
    end as category
from {{ ref('top_behaviors') }}
order by behavior_rank