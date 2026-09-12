with films as (

    select * from {{ ref('dim_films') }}

),

payments as (

    select
        film_id,
        sum(amount) as total_revenue
    from {{ ref('fact_payments') }}
    group by film_id

)

select
    f.film_id,
    f.title,
    f.category,
    f.rental_rate,
    f.inventory_count,
    f.times_rented,
    coalesce(p.total_revenue, 0) as total_revenue

from films f

left join payments p
    on f.film_id = p.film_id