-- Modelo de staging para a tabela Country Region
-- Objetivo: Limpar e padronizar os dados da tabela raw_adventure_works.countryregion

select 
    countryregioncode as country_region_code,
    name as country_region_name,
    modifieddate as modified_date
from {{ source('adventure_works', 'countryregion') }}
