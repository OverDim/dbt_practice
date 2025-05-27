{{

config(materialized='table')

}}
      select
        {{ adapter.quote("aircraft_code") }},
        {{ adapter.quote("seat_no") }},
        {{ adapter.quote("fare_conditions") }}

      from {{ source('demo_src', 'seats') }}

    