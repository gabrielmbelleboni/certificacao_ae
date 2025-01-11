select 
    businessentityid as business_entity_id
    , persontype as person_type
    , namestyle as name_style
    , title as person_title
    , firstname as first_name
    , middlename as middle_name
    , lastname as last_name
    --, suffix
    --, emailpromotion
    --, additionalcontactinfo
    --, demographics
    --, rowguid
    --, modifieddate
from {{ source('adventure_works', 'person') }}
