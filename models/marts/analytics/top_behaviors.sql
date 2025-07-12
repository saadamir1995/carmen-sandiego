{{ config(materialized='table') }}

with behavior_counts as (
    select
        behavior,
        count(*) as occurrence_count,
        count(*) * 100.0 / sum(count(*)) over () as percentage
    from {{ ref('fact_sightings') }}
    where behavior is not null
    group by behavior
),

ranked_behaviors as (
    select
        *,
        rank() over (order by occurrence_count desc) as behavior_rank
    from behavior_counts
)

select
    behavior_rank,
    behavior,
    occurrence_count,
    round(percentage, 2) as percentage
from ranked_behaviors
order by behavior_rank
limit 10