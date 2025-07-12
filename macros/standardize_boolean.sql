-- macros/standardize_boolean.sql
-- Macro to standardize boolean values across different regional formats

{% macro standardize_boolean(column_name) %}
    case 
        when lower({{ column_name }}::text) in ('true', 't', '1', 'yes', 'y') then true
        when lower({{ column_name }}::text) in ('false', 'f', '0', 'no', 'n') then false
        else null
    end
{% endmacro %}

-- macros/generate_alias_name.sql
-- Custom alias generation for better model naming

{% macro generate_alias_name(custom_alias_name=none, node=none) -%}

    {%- if custom_alias_name is none -%}

        {{ node.name }}

    {%- else -%}

        {{ custom_alias_name | trim }}

    {%- endif -%}

{%- endmacro %}

-- macros/get_region_mapping.sql
-- Macro to provide region-specific column mappings

{% macro get_region_mapping(region) %}
  {% if region == 'EUROPE' %}
    {%- set mapping = {
      'date_witness': 'date_witness',
      'date_agent': 'date_filed',
      'witness': 'witness',
      'agent': 'agent',
      'latitude': 'lat_',
      'longitude': 'long_',
      'city': 'city',
      'country': 'country',
      'city_agent': 'region_hq',
      'has_weapon': '"armed?"',
      'has_hat': '"chapeau?"',
      'has_jacket': '"coat?"',
      'behavior': 'observed_action'
    } -%}
  {% elif region == 'ASIA' %}
    {%- set mapping = {
      'date_witness': 'sighting',
      'date_agent': '"报道"',
      'witness': 'citizen',
      'agent': 'officer',
      'latitude': '"纬度"',
      'longitude': '"经度"',
      'city': 'city',
      'country': 'nation',
      'city_agent': 'city_interpol',
      'has_weapon': 'has_weapon',
      'has_hat': 'has_hat',
      'has_jacket': 'has_jacket',
      'behavior': 'behavior'
    } -%}
  {% elif region == 'AUSTRALIA' %}
    {%- set mapping = {
      'date_witness': 'witnessed',
      'date_agent': 'reported',
      'witness': 'observer',
      'agent': 'field_chap',
      'latitude': 'lat',
      'longitude': 'long',
      'city': 'place',
      'country': 'nation',
      'city_agent': 'interpol_spot',
      'has_weapon': 'has_weapon',
      'has_hat': 'has_hat',
      'has_jacket': 'has_jacket',
      'behavior': 'state_of_mind'
    } -%}
  {% elif region == 'PACIFIC' %}
    {%- set mapping = {
      'date_witness': 'sight_on',
      'date_agent': 'file_on',
      'witness': 'sighter',
      'agent': 'filer',
      'latitude': 'lat',
      'longitude': 'long',
      'city': 'town',
      'country': 'nation',
      'city_agent': 'report_office',
      'has_weapon': 'has_weapon',
      'has_hat': 'has_hat',
      'has_jacket': 'has_jacket',
      'behavior': 'behavior'
    } -%}
  {% else %}
    {%- set mapping = {
      'date_witness': 'date_witness',
      'date_agent': 'date_agent',
      'witness': 'witness',
      'agent': 'agent',
      'latitude': 'latitude',
      'longitude': 'longitude',
      'city': 'city',
      'country': 'country',
      'city_agent': 'region_hq',
      'has_weapon': 'has_weapon',
      'has_hat': 'has_hat',
      'has_jacket': 'has_jacket',
      'behavior': 'behavior'
    } -%}
  {% endif %}

  {{ return(mapping) }}
{% endmacro %}