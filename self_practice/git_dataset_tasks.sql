-- TODO : Find all order_id, customer_name, date when the order was placed
    -- by default JOIN means INNER JOIN

-- SELECT orders.OrderID, customers.CustomerName, orders.OrderDate
-- FROM orders
-- INNER JOIN customers ON orders.CustomerID = customers.CustomerID
-- LIMIT 10;

-- TODO : join 3 tables : get order_id, cust_name and shipper for that order

-- SELECT orders.OrderID, customers.CustomerName, orders.OrderDate, shippers.ShipperName
-- FROM (
-- (orders INNER JOIN customers ON orders.CustomerID = customers.CustomerID)
--         INNER JOIN shippers ON orders.ShipperID = shippers.ShipperID)
-- LIMIT 10;

-- TODO : Get all customersName and their orderID
    -- NOTE: there will be some customers who haven't placed an order yet so their orderIDs will be NULL values
-- SELECT customers.CustomerName, orders.OrderID
-- FROM customers 
-- LEFT JOIN orders ON customers.CustomerID = orders.CustomerID;


-- TODO : UNION -> combine 2 queries

SELECT city FROM customers
UNION 
SELECT city FROM suppliers;