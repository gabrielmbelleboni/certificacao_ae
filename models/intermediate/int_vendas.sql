-- Tabela de Fato de Vendas
-- Objetivo: Consolidar os dados de vendas a partir dos detalhes de pedidos e cabeçalhos de pedidos

with sales_order_header as (
    select 
        sales_order_id,  -- ID do pedido
        revision_number,  -- Número de revisão do pedido
        order_date,       -- Data do pedido
        due_date,         -- Data de vencimento
        ship_date,        -- Data de envio
        order_status,     -- Status do pedido
        online_order_flag, -- Flag para indicar pedido online
        purchase_order_number, -- Número da ordem de compra
        account_number,   -- Número da conta
        customer_id,      -- ID do cliente
        sales_person_id,  -- ID do vendedor
        territory_id,     -- ID da região
        bill_to_address_id, -- ID do endereço de cobrança
        ship_to_address_id, -- ID do endereço de entrega
        ship_method_id,   -- ID do método de envio
        credit_card_id,   -- ID do cartão de crédito
        credit_card_approval_code, -- Código de aprovação do cartão de crédito
        currency_rate_id, -- ID da taxa de câmbio
        subtotal,         -- Subtotal do pedido
        tax_amount,       -- Valor do imposto
        freight,          -- Custo de envio
        total_due,        -- Total a pagar
        comment,          -- Comentário do pedido
        row_guid,         -- GUID da linha
        modified_date     -- Data de modificação
    from {{ ref('stg_sales_order_header') }}  -- Referência para a tabela de staging
),

sales_order_detail as (
    select 
        sales_order_id,  -- ID do pedido
        product_id,      -- ID do produto
        special_offer_id, -- ID da oferta especial
        order_quantity,  -- Quantidade do pedido
        unit_price,      -- Preço unitário
        unit_price_discount -- Desconto aplicado no preço unitário
    from {{ ref('stg_sales_order_detail') }}  -- Referência para a tabela de detalhes do pedido
),

consolidated_sales as (
    select 
        sales_order_header.sales_order_id,  -- ID do pedido
        sales_order_header.customer_id,     -- ID do cliente
        sales_order_header.sales_person_id, -- ID do vendedor
        sales_order_header.order_date,      -- Data do pedido
        sales_order_header.due_date,        -- Data de vencimento
        sales_order_header.ship_date,       -- Data de envio
        sales_order_header.order_status,    -- Status do pedido
        sales_order_header.online_order_flag, -- Flag para indicar se é pedido online
        sales_order_header.purchase_order_number, -- Número da ordem de compra
        sales_order_header.account_number,  -- Número da conta
        sales_order_detail.product_id,      -- ID do produto
        sales_order_detail.special_offer_id, -- ID da oferta especial
        sales_order_detail.order_quantity,  -- Quantidade do pedido
        sales_order_detail.unit_price,      -- Preço unitário
        sales_order_detail.unit_price_discount, -- Desconto aplicado no preço unitário
        (sales_order_detail.unit_price * sales_order_detail.order_quantity) as gross_revenue,  -- Receita bruta
        (sales_order_detail.unit_price * sales_order_detail.order_quantity * (1 - sales_order_detail.unit_price_discount)) as net_revenue,  -- Receita líquida
        sales_order_header.subtotal,        -- Subtotal do pedido
        sales_order_header.tax_amount,      -- Valor do imposto
        sales_order_header.freight,         -- Custo de envio
        sales_order_header.total_due,       -- Total a pagar
        sales_order_header.comment,         -- Comentário
        sales_order_header.row_guid,        -- GUID da linha
        sales_order_header.modified_date    -- Data de modificação
    from sales_order_header
    join sales_order_detail
        on sales_order_header.sales_order_id = sales_order_detail.sales_order_id  -- Junção entre cabeçalhos e detalhes do pedido
)

select *
from consolidated_sales
