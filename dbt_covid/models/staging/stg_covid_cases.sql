{{
    config (
      engine='MergeTree()',
      order_by='date_rep'
    )
}}


select * from {{sources('raw_covid', 'raw_covid_cases')}}
