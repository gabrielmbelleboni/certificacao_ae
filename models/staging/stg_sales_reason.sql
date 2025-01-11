-- Modelo de staging para a tabela Sales Reason
-- Objetivo: Limpar e padronizar os dados da tabela raw_adventure_works.salesreason

select 
    salesreasonid as sales_reason_id,
    name as sales_reason_name,
    reasontype as reason_type,
    modifieddate as modified_date
from {{ source('adventure_works', 'salesreason') }}
