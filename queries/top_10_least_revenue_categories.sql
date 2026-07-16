-- This query will return a table with the top 10 least revenue categories 
-- in English, the number of orders and their total revenue. 
-- It will have different columns: 
--      Category, that will contain the top 10 least revenue categories; 
--      Num_order, with the total amount of orders of each category; 
--      Revenue, with the total revenue of each category.

-- HINT: 
-- All orders should have a delivered status and the Category and actual delivery date should be not null.
-- For simplicity, if there are orders with multiple product categories, consider the full order's payment_value in the summation of revenue of each category
SELECT pcnt.product_category_name_english as Category, COUNT(DISTINCT oo.order_id) AS Num_order,
SUM(oop.payment_value) AS Revenue
FROM olist_order_payments oop JOIN olist_order_items ooi ON oop.order_id = ooi.order_id  
JOIN olist_products op ON ooi.product_id = op.product_id 
JOIN olist_orders oo ON oop.order_id = oo.order_id 
JOIN product_category_name_translation pcnt ON op.product_category_name = pcnt.product_category_name 
WHERE oo.order_status ='delivered' AND Category IS NOT NULL AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY Category 
ORDER BY Revenue ASC LIMIT 10;