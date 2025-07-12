{{ config(materialized='table') }}

with monthly_appearance_stats as (
    select
        witness_month,
        case witness_month
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
        count(*) as total_sightings,
        sum(case when has_weapon = true then 1 else 0 end) as armed_sightings,
        sum(case when has_hat = true then 1 else 0 end) as hat_sightings,
        sum(case when has_jacket = true then 1 else 0 end) as jacket_sightings,
        sum(case when has_weapon = true and has_jacket = true and has_hat = false then 1 else 0 end) as armed_jacket_no_hat,
        round(avg(case when has_weapon = true then 1.0 else 0.0 end) * 100, 2) as armed_percentage,
        round(avg(case when has_hat = true then 1.0 else 0.0 end) * 100, 2) as hat_percentage,
        round(avg(case when has_jacket = true then 1.0 else 0.0 end) * 100, 2) as jacket_percentage,
        round(avg(case when has_weapon = true and has_jacket = true and has_hat = false then 1.0 else 0.0 end) * 100, 2) as armed_jacket_no_hat_percentage
    from {{ ref('fact_sightings') }}
    group by witness_month
)

select * from monthly_appearance_stats
order by witness_month