-- models/marts/dim_customers.sql
dbt build --select state:modified+ --defer --state ./prod-manifest