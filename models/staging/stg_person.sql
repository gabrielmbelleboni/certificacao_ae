-- Modelo de staging para a tabela Person
-- Objetivo: Limpar e padronizar os dados da tabela raw_adventure_works.person

select 
    businessentityid as business_entity_id,
    persontype as person_type,
    namestyle as name_style,
    title as person_title,
    firstname as first_name,
    middlename as middle_name,
    lastname as last_name,
    suffix,
    emailpromotion as email_promotion,
    additionalcontactinfo as additional_contact_info,
    demographics,
    rowguid as row_guid,
    modifieddate as modified_date
from {{ source('adventure_works', 'person') }}
