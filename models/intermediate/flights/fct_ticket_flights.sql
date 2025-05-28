{{
  config(
    materialized = 'table',
    on_confriguration_change = 'apply'
    )
}}
      select
        "ticket_no",
        "flight_id",
        "fare_conditions",
        "amount"

      from {{ ref('stg_flights__facts__ticket_flights') }}