-- SHOW DATABASES;

-- CREATE TABLE customers(
--     customer_id INT NOT NULL AUTO_INCREMENT,
--     name VARCHAR(30) NOT NULL,
--     email VARCHAR(40) DEFAULT 'No e-mail provided',
--     amount INT,
--     PRIMARY KEY(customer_id)
-- );

-- INSERT INTO customers(name, email, amount)
-- VALUES ('hitesh', 'hitesh@lco.dev', 35),
--         ('George', 'geo@lco.dev', 45),
--         ('hitesh', 'hitesh@gmail.com', 88),
--         ('lina', 'lina@gmail.com', 78),
--         ('Jimmy', 'jimmy@yahoo.co.in', 54),
--         ('lina', 'lina@yahoo.co.in', 35),
--         ('hitesh', 'hitesh@yahoo.co.in', 56);

-- SELECT name FROM customers;
-- SELECT email FROM customers;

-- SELECT amount AS purchases FROM customers;

-- todo: update tasks

-- SELECT * FROM customers
-- WHERE name = 'Jimmy';


-- UPDATE customers SET email = 'jimmy@yahoo.com'
-- WHERE name = 'jimmy';


-- UPDATE customers 
-- SET amount = 38
-- WHERE name = 'lina' AND amount = 35;

-- UPDATE customers
-- SET email = 'lina@gmail.com'
-- WHERE name = 'lina';

-- SELECT * FROM customers
-- WHERE name = 'george';

-- DELETE FROM customers
-- WHERE name = 'george';


-- SELECT * FROM customers WHERE name = 'hitesh';

DELETE FROM customers
WHERE name = 'lina';



