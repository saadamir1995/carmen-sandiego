{{ config(materialized='table') }}

with monthly_region_counts as (
    select
        witness_month,
        region,
        count(*) as sightings_count
    from {{ ref('fact_sightings') }}
    group by witness_month, region
),

monthly_totals as (
    select
        witness_month,
        sum(sightings_count) as total_monthly_sightings
    from monthly_region_counts
    group by witness_month
)

select
    mrc.witness_month,
    case mrc.witness_month
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
    mrc.region,
    mrc.sightings_count,
    mt.total_monthly_sightings,
    round(mrc.sightings_count::decimal / mt.total_monthly_sightings * 100, 2) as probability_percentage,
    rank() over (partition by mrc.witness_month order by mrc.sightings_count desc) as region_rank
from monthly_region_counts mrc
join monthly_totals mt on mrc.witness_month = mt.witness_month
order by mrc.witness_month, mrc.sightings_count desc