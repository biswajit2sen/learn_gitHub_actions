{{
    config(
        materialized='incremental',
        unique_key='N_NATIONKEY',
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
    
        n_nationkey as nation_key,
        n_name as name,
        n_regionkey as region_key,
        last_updated_date as last_updated_date

    from source

)
select * from renamed

{% if is_incremental() %}
where LAST_UPDATED_DATE > (select max(LAST_UPDATED_DATE) from {{this}})
{% endif %}