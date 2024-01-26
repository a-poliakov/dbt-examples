{{
    config (
      engine='MergeTree()',
      order_by='date_rep'
    )
}}

with cases as (
    select * from ref('stg_covid_cases')
), country_codes as (
select country, alpha_2code from {{sources('raw_covid', 'ref_country_codes')}}
),
collected as (
select cases.date_rep as report_date, cases.cases, cases.deaths, country_codes.country
from cases join country_codes on cases.geo_id = country_codes.alpha_2code
)

select * from collected
