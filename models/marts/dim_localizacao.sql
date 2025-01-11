-- Tabela de Dimensão para Localização
-- Objetivo: Fornecer informações sobre a localização (cidade, estado, país) para análise

with source_location as (
    select *
    from {{ ref('int_localizacao') }}
)

select *
from source_location
