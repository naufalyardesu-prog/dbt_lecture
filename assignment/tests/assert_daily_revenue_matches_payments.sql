with mart as (

    select
        sum(total_revenue) as mart_total_revenue,
        sum(total_payments) as mart_total_payments
    from {{ ref('mart_daily_revenue') }}

),

payments as (

    select
        sum(amount) as payments_total_revenue,
        count(payment_id) as payments_total_payments
    from {{ ref('stg_payments') }}

)

select
    mart.mart_total_revenue,
    payments.payments_total_revenue,
    mart.mart_total_payments,
    payments.payments_total_payments

from mart
cross join payments

where
    mart.mart_total_revenue != payments.payments_total_revenue
    or
    mart.mart_total_payments != payments.payments_total_payments