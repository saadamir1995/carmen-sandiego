{{ config(materialized='table') }}

with witness_data as (
    select distinct
        witness,
        region
    from {{ ref('int_all_sightings') }}
    where witness is not null
)

select
    row_number() over (order by witness, region) as witness_id,
    witness as witness_name,
    region,
    count(*) over (partition by witness) as total_sightings_reported
from witness_data