"""
{{
    config(
        materialized='incremental',
        unique_key='id',
        incremental_strategy='merge',
        merge_updated_columns=['first_name','last_name','email','phone']
    )
}}

with source as (
    select * from {{ ref('stg_tpch_orders') }}
)

select * from source

{% if is_incremental() %}
where updated_at > (select max(updated_at) from {{ this }})
{% endif %}
"""