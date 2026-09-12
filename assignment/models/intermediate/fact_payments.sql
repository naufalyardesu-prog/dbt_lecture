with payments as (

    select * from {{ ref('stg_payments') }}

),

customers as (

    select
        customer_id,
        {{ full_name('first_name', 'last_name') }} as customer_name
    from {{ ref('stg_customers') }}

),

rentals as (

    select
        rental_id,
        inventory_id,
        customer_id
    from {{ ref('stg_rentals') }}

),

inventory as (

    select
        inventory_id,
        film_id,
        store_id
    from {{ ref('stg_inventory') }}

),

films as (

    select
        film_id,
        title
    from {{ ref('stg_films') }}

)

select
    p.payment_id,
    p.paid_at,
    p.paid_at::date as paid_date,
    p.customer_id,
    c.customer_name,
    p.staff_id,
    i.store_id,
    p.rental_id,
    i.film_id,
    f.title as film_title,
    p.amount

from payments p

left join customers c
    on p.customer_id = c.customer_id

left join rentals r
    on p.rental_id = r.rental_id

left join inventory i
    on r.inventory_id = i.inventory_id

left join films f
    on i.film_id = f.film_id