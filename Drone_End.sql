use delivery_system;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_main`()
BEGIN

select dd.Drone_ID
from order_item as oi inner join customer_has_custshipping_address as chca on oi.Customer_Cust_ID = chca.Cust_ID
inner join custshipping_address as ca on chca.ShippingAddress_ID = ca.ShippingAddress_ID
inner join warehouse as w on w.Zip_Code = ca.Zip_Code
inner join drone_details as dd on dd.warehouse_ID = w.warehouse_ID
inner join drone_type as dt on dt.Drone_Type_ID = dd.Drone_Type_ID
where dd.Drone_Status="Available" AND oi.Package_weight<=dt.Drone_Capacity group by oi.OrderItem_ID;
END$$



SELECT `pay`.`INVOICE_ID`,
    `pay`.`ORDERITEM_ID`,
    `pay`.`PRODUCT_UNITPRICE`,
    `pay`.`MODEL_NUMBER`,
    `pay`.`PROD_MODEL_NAME`,
    `pay`.`SERIAL_NO`,
    `pay`.`ORDERITEM_STATUS`,
    `pay`.`ORDER_DATE`,
    `pay`.`CUST_NAME`,
    `pay`.`CARD_NAME`,
    `pay`.`CARD_NO`,
    `pay`.`TYPE`,
    `pay`.`AMOUNT`,

    `pay`.`INVOICE_STATUS`,
    `pay`.`PAID_DATE`
FROM `delivery_system`.`pay`;

DELIMITER ;


use delivery_system;

CALL `delivery_system`.`sp_main`();

select * from pay;
