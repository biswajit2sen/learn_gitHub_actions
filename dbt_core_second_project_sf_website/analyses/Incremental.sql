{{
    config(
        materialized = 'incremental',
        unique_key = 'id',
        incremental_strategy = 'merge'
    )
}}
with source_data as
(
    select * from {{ ref('stg_orders') }}
)
select * from source_data
{% if is_incremental() %}
where updated_at > (select max(updated_at) from {{ this }})
{% endif %}