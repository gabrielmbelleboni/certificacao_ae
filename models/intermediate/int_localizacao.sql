-- Modelo Intermediate para consolidar os dados de localização
-- Objetivo: Combinar dados de endereço, estado, e país em uma tabela única

with address as (
    select *
    from {{ ref('stg_address') }}
),

state_province as (
    select *
    from {{ ref('stg_state_province') }}
),

country_region as (
    select *
    from {{ ref('stg_country_region') }}
),

joined as (
    select 
        address.address_id,
        address.address_line_1,
        address.address_line_2,
        address.city,
        address.state_province_id, -- Corrigido para refletir o padrão snake_case
        state_province.state_province_name,
        state_province.state_province_code,
        state_province.country_region_code,
        country_region.country_region_name
    from address
    join state_province
        on address.state_province_id = state_province.state_province_id
    join country_region
        on state_province.country_region_code = country_region.country_region_code
)

select *
from joined
