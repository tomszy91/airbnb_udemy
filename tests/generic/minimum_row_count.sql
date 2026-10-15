{% test minimum_row_count(model, min_row_count) %}
{{ config(severity = 'warn') }}
    select
        count(*) as count
    from
        {{ model }}
    having
        count(*) < {{ min_row_count }}
{% endtest %}