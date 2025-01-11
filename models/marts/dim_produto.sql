-- Tabela de Dimensão para Produtos
-- Objetivo: Fornecer informações detalhadas sobre os produtos para análise

with source_produto as (
    select *
    from {{ ref('int_produto') }}
)

select *
from source_produto
