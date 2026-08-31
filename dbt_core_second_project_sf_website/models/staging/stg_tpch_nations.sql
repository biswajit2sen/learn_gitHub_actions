{{
    config(
        materialized='incremental',
        unique_key='n_nationkey',
        incremental_strategy = 'merge',
        on_schema_change = 'append_new_column'
    )
}}

with source
as
(
    select * from {{ref('nations')}}
),
renamed as (

    select
    
        n_nationkey as n_nationkey,
        n_name as n_name,
        n_regionkey as n_regionkey,
        last_updated_date as last_updated_date

    from source

)
select * from renamed

{% if is_incremental() %}
where LAST_UPDATED_DATE > (select max(LAST_UPDATED_DATE) from {{this}})
{% endif %}