SELECT *
FROM {{ ref('orders') }}
WHERE order_date > current_date