{{ config(materialized='table') }}

with top_3_behaviors as (
    select behavior
    from {{ ref('top_behaviors') }}
    where behavior_rank <= 3
),

monthly_behavior_stats as (
    select
        f.witness_month,
        case f.witness_month
            when 1 then 'January'
            when 2 then 'February'
            when 3 then 'March'
            when 4 then 'April'
            when 5 then 'May'
            when 6 then 'June'
            when 7 then 'July'
            when 8 then 'August'
            when 9 then 'September'
            when 10 then 'October'
            when 11 then 'November'
            when 12 then 'December'
        end as month_name,
        count(*) as total_monthly_sightings,
        sum(case when f.behavior in (select behavior from top_3_behaviors) then 1 else 0 end) as top_3_behavior_sightings,
        round(
            sum(case when f.behavior in (select behavior from top_3_behaviors) then 1 else 0 end) * 100.0 / count(*), 
            2
        ) as top_3_behavior_percentage
    from {{ ref('fact_sightings') }} f
    where f.behavior is not null
    group by f.witness_month
)

select * from monthly_behavior_stats
order by witness_month