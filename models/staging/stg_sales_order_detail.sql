-- Modelo de staging para a tabela Sales Order Detail
-- Objetivo: Limpar e padronizar os dados da tabela raw_adventure_works.salesorderdetail

select 
    salesorderid as sales_order_id,
    salesorderdetailid as sales_order_detail_id,
    carriertrackingnumber as carrier_tracking_number,
    orderqty as order_quantity,
    productid as product_id,
    specialofferid as special_offer_id,
    unitprice as unit_price,
    unitpricediscount as unit_price_discount,
    rowguid as row_guid,
    modifieddate as modified_date
from {{ source('adventure_works', 'salesorderdetail') }}
