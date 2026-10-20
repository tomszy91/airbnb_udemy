{% macro learn_logging() %}
    {# {{ log("Call 1") }} #}
    {{ log("Call 2", info=True) }}
{% endmacro %}