{% snapshot cust_snapshot %}
{{
    config(
        target_schema='snapshots',
        unique_key='id',
        strategy='timestamp',
        updated_at='updated_at'
    )
}}
Select * from {{ ref('stg_tpch_orders') }}
{% endsnapshot %}