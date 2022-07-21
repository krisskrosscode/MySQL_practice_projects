USE lco_users;

-- TODO : Give Full name of all students

-- SELECT stu_fname, stu_lname FROM students; 

-- SELECT CONCAT(stu_fname,' ',  stu_lname) AS full_name FROM students;

-- TODO : Give full name and login count of all users

-- SELECT CONCAT(stu_fname, ' ',  stu_lname) AS full_name, login_count FROM students; 


-- TODO : Replace 'a'  with '@' in firstname

-- SELECT REPLACE(stu_fname, 'a', '@') AS repalced_a FROM students; 


-- TODO : SUBSTRING -> Get me a list of email, if email > 7 chars, truncate it with ...

-- SELECT CONCAT(SUBSTRING(email, 1, 7), '...') AS email_truncated FROM students;

-- TODO : LENGTH of all registerd emails + (REVERSE of emails)

-- SELECT LENGTH(email), email, REVERSE(email) FROM students;

-- TODO : Get first_name in uppercase and last name in lower case

-- SELECT UPPER(stu_fname) AS fname_upper, LOWER(stu_lname) AS lname_lower FROM students;

-- TODO : how many users are there on the website -> DISTINCT + COUNT 

-- SELECT COUNT(DISTINCT(email)) AS total_unique_students FROM students;

-- NOTE : 
    -- you cannot use SELECT DISTINCT COUNT(email) ... 
    -- since the queries are executed in an inside out manner


-- TODO : arrange all users based on login count -- ORDER BY

-- SELECT DISTINCT(stu_fname), login_count FROM students
-- ORDER BY login_count DESC;

-- TODO : arrange all users based on course count -- ORDER BY

-- SELECT DISTINCT(stu_fname), course_count FROM students
-- ORDER BY course_count DESC;

-- TODO : LIMIT

-- SELECT DISTINCT stu_fname, login_count FROM students
-- ORDER BY login_count DESC
-- LIMIT 2, 5; -- start from position 2 and give 5 results (index starts from 0)


-- TODO : pattern matching

-- SELECT stu_fname, email FROM students
-- WHERE stu_fname LIKE 'm%';

-- escape character is \ : suppose you want to search a pattern 'm\' , you should type 'm\\'
-- suppose you want to search a pattern with single quotes inside you should search 'm\''

-- TODO : find how many users signed up each month

-- SELECT signup_month, COUNT(stu_fname)  FROM students
-- GROUP BY signup_month
-- ORDER BY signup_month;

-- TODO : MAX MIN -> get max/min login count 

-- SELECT stu_fname, email, login_count AS min_login_count FROM students
-- WHERE login_count = (SELECT MIN(login_count) FROM students);

-- SELECT stu_fname, email, login_count AS max_login_count FROM students
-- WHERE login_count = (SELECT MAX(login_count) FROM students);

-- TODO : Find students with minimum course_count

-- SELECT stu_fname, email, course_count AS min_course_count FROM students
-- WHERE course_count = (SELECT MIN(course_count) FROM students);

-- TODO : GROUP BY - MIN MAX

-- SELECT login_count, signup_month FROM students
-- GROUP BY signup_month
-- ORDER BY signup_month;


-- TODO : lowest login count in 7th and 10th month

-- SELECT login_count, signup_month, email FROM students
-- WHERE signup_month = 7 OR signup_month = 10
-- GROUP BY login_count;

-- TODO : Total no. of login and avg no. of courses taken by user by month

-- SELECT login_count, signup_month FROM students
-- WHERE signup_month = 7;

-- SELECT signup_month, SUM(login_count) as month_total FROM students
-- GROUP BY signup_month;

-- TODO : AND | OR 

    -- TODO : Find users with login count of at least 20 and enrolled 
    -- TODO : in at least 5 courses

    -- SELECT email, login_count, course_count FROM students 
    -- WHERE login_count >= 20 AND course_count >= 5
    -- ORDER BY login_count, course_count;

    -- TODO : Find the users who signed up in 7th and 10th month

    -- SELECT email, signup_month, login_count FROM students
    -- WHERE signup_month = 7 OR signup_month = 10;

    -- TODO : RANGE | find users who signed up between months 7 and 10 (both inclusive)

            -- of course you can do it the easy way
    -- SELECT email,signup_month FROM students
    -- WHERE signup_month >=7 AND signup_month<=10
    -- ORDER BY signup_month;
            
            -- using BETWEEN clause 
    -- SELECT email, signup_month FROM students
    -- WHERE signup_month BETWEEN 7 and 10;

    -- TODO : CASE WHEN THEN

    SELECT stu_fname, email, signup_month,
        CASE
            WHEN signup_month BETWEEN 7 AND 10 THEN 'Early Bird'
            WHEN signup_month BETWEEN 11 AND 12 THEN 'Regular user'
            ELSE '###'
        END
        AS category
    FROM students;