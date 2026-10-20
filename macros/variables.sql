{% macro learn_variables() %}

    {% set your_name_jinja = "Anzej_jinja" %}
    {{ log("Hello jinja user " ~ your_name_jinja, info=True) }}

    {{ log("Hello dbt user " ~ var("user_name", "NO USERNAME") ~ "!", info=True) }}

{% endmacro %}