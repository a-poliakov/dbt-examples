{% macro init_s3_sources() -%}

 {% set sources = [
        'DROP TABLE IF EXISTS raw_covid_cases'
        , 'CREATE TABLE IF NOT EXISTS raw_covid_cases
        (
                date_rep       Date,
                day          UInt32,
                month       UInt32,
                year     UInt32,
                cases         UInt32,
                deaths       UInt32,
                geo_id    String
        )
        ENGINE = S3(\'https://storage.yandexcloud.net/otus-dwh/tpch-dbgen-1g/customer.csv\', \'CSV\')
        SETTINGS
            format_custom_field_delimiter=\',\'
            ,format_custom_escaping_rule=\'CSV\'
            ,format_custom_row_after_delimiter=\'|\n\'
        '
    ] %}

    {% for src in sources %}
        {% set statement = run_query(src) %}
    {% endfor %}

{{ print('Initialized source tables – TPCH (S3)') }}

{%- endmacro %}
