select 
    addressid as address_id
    , addressline1 as address_line_1
    , addressline2 as address_line_2
    , city
    , modifieddate as modified_date
    , postalcode as postal_code
    --, rowguid
    --, spatiallocation
    --, stateprovinceid
from {{ source('adventure_works', 'address') }}
