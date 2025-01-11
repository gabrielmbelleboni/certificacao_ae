-- Modelo de staging para a tabela Address
-- Objetivo: Limpar e padronizar os dados da tabela raw_adventure_works.address

select 
    addressid as address_id,
    addressline1 as address_line_1,
    addressline2 as address_line_2,
    city,
    cast(postalcode as integer) as postal_code,
    modifieddate as modified_date
from {{ source('adventure_works', 'address') }}
