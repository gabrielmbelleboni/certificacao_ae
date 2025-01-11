-- Modelo de staging para a tabela State Province
-- Objetivo: Limpar e padronizar os dados da tabela raw_adventure_works.stateprovince

select 
    stateprovinceid as state_province_id,
    stateprovincecode as state_province_code,
    countryregioncode as country_region_code,
    isonlystateprovinceflag as is_only_state_province_flag,
    name as state_province_name,
    territoryid as territory_id,
    rowguid as row_guid,
    modifieddate as modified_date
from {{ source('adventure_works', 'stateprovince') }}
