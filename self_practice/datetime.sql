
-- TODO : Creating a Date Time table

-- CREATE TABLE users(
--     name VARCHAR(50),
--     col1 DATE,
--     col2 TIME,
--     col3 DATETIME
-- );


-- TODO : Insert into users

-- INSERT INTO users(name, col1, col2, col3)
-- VALUES(
--     'hitesh', '2020-08-14', '10:24:22', '2020-08-14 10:24:22'
-- );

-- TODO : You can also use NOW() method in col3

-- INSERT INTO users(name, col1, col2, col3)
-- VALUES(
--     'harshal', '1999-01-30', '10:06:23', NOW()
-- );


-- TODO : Retrieving data

-- SELECT name, MONTH(col3) FROM users;

-- SELECT name, DATE_FORMAT(col3, '%m->%d->%Y') FROM users;