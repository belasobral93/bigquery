{{
    config(
        materialized='incremental',
        unique_key='order_id',
        on_schema_change='sync_all_columns',
        partition_by={'field': 'order_date', 'data_type': 'DATE'},
        cluster_by=['customer_id', 'status']
    )
}}

select
    order_id,
    customer_id,
    status,
    order_date,
    modified_at,
    platform
from {{ ref('raw_orders') }} as raw

{% if is_incremental() %}
    where
        raw.modified_at > (select max(this.modified_at) from {{ this }} as this)
{% endif %}
