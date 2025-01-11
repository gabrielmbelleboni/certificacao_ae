select 
    stateprovinceid as state_province_id
    , stateprovincecode as state_province_code
    , countryregioncode as country_region_code
    , isonlystateprovinceflag as is_only_state_province
    , name as state_province_name
    , territoryid as territory_id
    , rowguid as row_guid
    , modifieddate as modified_date
from {{ source('adventure_works', 'stateprovince') }}
