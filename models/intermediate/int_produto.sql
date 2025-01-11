-- Modelo intermediário para consolidar os dados dos produtos
-- Objetivo: Organizar e padronizar os dados dos produtos em uma tabela única

with source_produto as (
    select *
    from {{ ref('stg_product') }}
)

select 
    source_produto.product_id,
    source_produto.product_name,
    source_produto.product_number,
    source_produto.make_flag,
    source_produto.finished_goods_flag,
    source_produto.product_color,
    source_produto.standard_cost,
    source_produto.list_price,
    source_produto.product_size,
    source_produto.product_weight,
    source_produto.product_line,
    source_produto.product_class,
    source_produto.product_style,
    source_produto.product_subcategory_id,
    source_produto.product_model_id,
    source_produto.sell_start_date,
    source_produto.sell_end_date,
    source_produto.discontinued_date
from source_produto
