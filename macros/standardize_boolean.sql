-- Macro to standardize boolean values across different regional formats

{% macro standardize_boolean(column_name) %}
    case 
        when lower({{ column_name }}::text) in ('true', 't', '1', 'yes', 'y') then true
        when lower({{ column_name }}::text) in ('false', 'f', '0', 'no', 'n') then false
        else null
    end
{% endmacro %}
