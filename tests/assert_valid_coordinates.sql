-- Verify latitude and longitude are within valid ranges

select count(*) as invalid_coordinates
from {{ ref('fact_sightings') }} f
join {{ ref('dim_locations') }} l on f.location_id = l.location_id
where l.latitude < -90 
   or l.latitude > 90
   or l.longitude < -180 
   or l.longitude > 180
having count(*) > 0