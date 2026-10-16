{% macro select_positive_values(model, column_name) %}
    select * 
    from {{ model }}
    where {{ column_name }} > 0
{% endmacro %}

{% # dbt show --inline '{{ select_positive_values(ref("int_airbnb__listings_cleaned"), "minimum_nights") }}' # %}