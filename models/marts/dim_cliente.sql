-- Tabela de Dimensão para Clientes
-- Objetivo: Fornecer informações descritivas sobre os clientes para análise

with source_customers as (
    select *
    from {{ ref('int_cliente') }}
)

select *
from source_customers
