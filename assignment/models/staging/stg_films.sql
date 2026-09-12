-- One cleaned row per film in the catalogue.
with source as (

    select * from {{ source('pagila', 'film') }}

)

select
    film_id,
    title,
    description,
    rental_rate,
    replacement_cost,
    length as length_minutes,
    rating::text as rating   -- Pagila stores this as an enum; cast to text
from source
