-- Staging = light clean-up over ONE source (Pagila's customer table).
with source as (

    select * from {{ source('pagila', 'customer') }}

)

select
    customer_id,
    first_name,
    last_name,
    email,
    activebool as is_active,
    create_date::timestamp as created_at,
    last_update::timestamp as last_updated_at
from source