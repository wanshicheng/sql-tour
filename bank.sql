USE bank;

SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS=1;

DESC person;

INSERT INTO person
(person_id, fname, lname, gender, birth_date)
VALUE (NULL, 'William', 'Turner', 'M', '1972-05-27');

SELECT person_id, fname, lname, gender, birth_date
FROM person;

SELECT person_id, fname, lname, gender, birth_date
FROM person
WHERE person_id = 1;

SELECT person_id, fname, lname, gender, birth_date
FROM person
WHERE lname = 'Turner';

SELECT * FROM person;

INSERT INTO favorite_food (person_id, food)
VALUE (1, 'pizza');

INSERT INTO favorite_food (person_id, food)
VALUE (1, 'cookies');

INSERT INTO favorite_food (person_id, food)
VALUE (1, 'nachos');

SELECT food 
FROM favorite_food
WHERE person_id = 1
ORDER BY food;

# ALTER TABLE `person` CHANGE `coutry` `country` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL;

INSERT INTO person
(person_id, fname, lname, gender, birth_date, street, city, state, country, postal_code)
VALUE (NULL, 'Susan', 'Smith', 'F', '1975-11-02',
'23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

SELECT person_id, fname, lname, birth_date
FROM person;

#P30 输出XML

UPDATE person
SET street = '1225 Tremont St.',
city = 'Boston',
state = 'MA',
country = 'USA',
postal_code = '02138'
WHERE person_id = 1;

# 修改多个数据
# where person_id < 10

DELETE FROM person
WHERE person_id = 2;

#P32 导致错误的语句

SHOW TABLES;

# 修改数据库的名字？？ CREATE DATABASE bank / DROP DATABASE learning_sql

DROP TABLE favorite_food;
DROP TABLE person;

DESC customer;

# 《High Performance MySQL》

SELECT emp_id, fname, lname
FROM employee
WHERE lname = 'Bkadfl';

SELECT fname, lname
FROM employee;

# select 子句
SELECT *
FROM department;

SELECT dept_id, NAME
FROM department;


SELECT NAME
FROM department;

# 在查询语句中使用列名、字符、表达式和内建函数
SELECT emp_id,
'ACTIVE',
emp_id * 3.14159,
UPPER(lname)
FROM employee;

SELECT VERSION(),
USER(),
DATABASE();

# 别名
SELECT emp_id,
'ACTIVE' STATUS,
emp_id * 3.14159 empid_x_pi,
UPPER(lname) last_name_upper
FROM employee;

SELECT emp_id,
'ACTIVE' AS STATUS,
emp_id * 3.14159 AS empid_x_pi,
UPPER(lname) AS last_name_upper
FROM employee;

SELECT cust_id
FROM account;
# 去除重复行
SELECT DISTINCT cust_id
FROM account;
