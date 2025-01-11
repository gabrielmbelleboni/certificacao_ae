-- Modelo intermediário para consolidar os dados dos clientes
-- Objetivo: Combinar os dados dos clientes e de localização em uma única tabela

with source_customers as (
    select *
    from {{ ref('stg_person') }}
),

source_location as (
    select *
    from {{ ref('int_localizacao') }}
)

select 
    source_customers.business_entity_id as customer_id,
    source_customers.first_name,
    source_customers.middle_name,
    source_customers.last_name,
    source_customers.person_type,
    source_customers.name_style,
    source_location.address_id,
    source_location.city,
    source_location.state_province_name,
    source_location.state_province_code,
    source_location.country_region_name,
    source_location.country_region_code,
    source_customers.modified_date as person_modified_date
from source_customers
left join source_location
    on source_customers.business_entity_id = source_location.address_id
