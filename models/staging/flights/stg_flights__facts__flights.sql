{{

config(
    materialized='incremental',
    incremental_strategy = 'merge',
    unique_key = ['flight_id'],
    merge_update_columns = ['*'],
    on_schema_change = 'sync_all_columns'
    )

}}
      select
        "flight_id",
        "flight_no",
        "scheduled_departure",
        "scheduled_arrival",
        "departure_airport",
        "arrival_airport",
        "status",
        "aircraft_code",
        "actual_departure",
        "actual_arrival"

      from {{ source('demo_src', 'flights') }}
      WHERE
    -- Инкрементальная фильтрация: берем только последние N дней
        scheduled_departure >= (select max(scheduled_departure) from {{ source('demo_src', 'flights') }}) - INTERVAL '100 days'

{% if is_incremental() %}
    AND scheduled_departure > (SELECT MAX(scheduled_departure) FROM {{ this }})
{% endif %}
    