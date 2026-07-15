
-- TODO: 
-- This query will return a table with two columns: State and Delivery_Difference. 
-- The first one will have the letters that identify the states, 
-- and the second one the average difference between the estimated delivery date 
-- and the date when the items were actually delivered to the customer.

-- HINTS:
-- 1. You can use the julianday function to convert a date to a number.
-- 2. You can use the CAST function to convert a number to an integer.
-- 3. You can use the STRFT-IME function to convert a order_delivered_customer_date to a string removing hours, minutes and seconds.
-- 4. order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL

SELECT oc.customer_state as State,
CAST(ABS(AVG(julianday(strftime('%Y-%m-%d',oo.order_delivered_customer_date)) - julianday(strftime('%Y-%m-%d',oo.order_estimated_delivery_date)))) AS INTEGER) AS  Delivery_Difference
FROM olist_orders oo JOIN olist_customers oc ON oo.customer_id = oc.customer_id 
WHERE oo.order_status = 'delivered' AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY State ORDER BY Delivery_Difference ASC;
