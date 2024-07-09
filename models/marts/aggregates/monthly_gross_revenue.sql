select 
    date_trunc(fct_order_items.order_date, MONTH) as order_month,
    sum(fct_order_items.NET_ITEM_SALES_AMOUNT) as gross_revenue
from `sales-demo-project-314714`.`dbt_isobral_bigquery`.`fct_order_items`
group by order_month
