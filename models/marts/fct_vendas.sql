-- Tabela de Fato de Vendas
-- Objetivo: Consolidar os dados de vendas a partir dos detalhes de pedidos e cabeçalhos de pedidos

with sales_order_header as (
    select 
        sales_order_id,  -- Certificando-se de usar o nome correto (sales_order_id) conforme renomeado
        revision_number,
        order_date,
        due_date,
        ship_date,
        order_status,
        online_order_flag,
        purchase_order_number,
        account_number,
        customer_id,
        sales_person_id,
        territory_id,
        bill_to_address_id,
        ship_to_address_id,
        ship_method_id,
        credit_card_id,
        credit_card_approval_code,
        currency_rate_id,
        subtotal,
        tax_amount,  -- Usando o nome correto da coluna
        freight,
        total_due,  -- Usando o nome correto da coluna
        comment,
        row_guid,
        modified_date
    from FEA24_9.dbt_gbelleboni_aw.stg_sales_order_header
),

sales_order_detail as (
    select *
    from FEA24_9.dbt_gbelleboni_aw.stg_sales_order_detail
),

consolidated_sales as (
    select 
        sales_order_header.sales_order_id,  -- Garantindo o uso de sales_order_id correto
        sales_order_header.customer_id,
        sales_order_header.sales_person_id,
        sales_order_header.order_date,
        sales_order_header.due_date,
        sales_order_header.ship_date,
        sales_order_header.order_status,
        sales_order_header.online_order_flag,
        sales_order_header.purchase_order_number,
        sales_order_header.account_number,
        sales_order_detail.product_id,
        sales_order_detail.special_offer_id,
        sales_order_detail.order_quantity,
        sales_order_detail.unit_price,
        sales_order_detail.unit_price_discount,
        (sales_order_detail.unit_price * sales_order_detail.order_quantity) as gross_revenue,
        (sales_order_detail.unit_price * sales_order_detail.order_quantity * (1 - sales_order_detail.unit_price_discount)) as net_revenue,
        sales_order_header.subtotal,
        sales_order_header.tax_amount as tax_amount,  -- Usando tax_amount
        sales_order_header.freight,
        sales_order_header.total_due as total_due,  -- Usando total_due
        sales_order_header.comment,
        sales_order_header.row_guid,
        sales_order_header.modified_date
    from sales_order_header
    join sales_order_detail
        on sales_order_header.sales_order_id = sales_order_detail.sales_order_id
)

select *
from consolidated_sales;
