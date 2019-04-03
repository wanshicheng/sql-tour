# create database sina default character set utf8mb4 collate utf8mb4_unicode_ci;

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
# 去除重复行，默认为 ALL，
# DISTINCT 影响性能，需要减少使用
SELECT DISTINCT cust_id
FROM account;

# 3种类型的表
# 永久表（使用 create table 语句创建的表）
# 临时表（子查询所返回的表）
SELECT e.emp_id, e.fname, e.lname
FROM (SELECT emp_id, fname, lname, start_date, title
	FROM employee) e; 
	#术语：外围查询	
# 虚拟表（使用 create view 子句所创建的视图）
	# 存储在数据字典种的查询，像一个表，实际无任何数据
CREATE VIEW employee_vw AS
SELECT emp_id, fname, lname,
YEAR(start_date) start_year
FROM employee;

SELECT * 
FROM employee_vw;

# 表连接
SELECT employee.emp_id, employee.fname,
employee.lname, department.name dept_name
FROM employee INNER JOIN department
ON employee.dept_id = department.dept_id;

# where 子句
SELECT emp_id, fname, lname, start_date, title
FROM employee
WHERE title = 'Head Teller';

# 使用的表的时间比书中少5年
SELECT emp_id, fname, lname, start_date, title
FROM employee
WHERE title = 'Head Teller'
AND start_date > '2002-01-01';

SELECT emp_id, fname, lname, start_date, title
FROM employee
WHERE title = 'Head Teller'
OR start_date > '2002-01-01';

SELECT emp_id, fname, lname, start_date, title
FROM employee
WHERE (title = 'Head Teller' AND start_date > '2002-01-01')
OR (title = 'Teller' AND start_date > '2003-01-01');

# group by 和 having 子句
	#group by:对数据进行分组
	#having: 对数据进行过滤
SELECT d.name, COUNT(e.emp_id) num_empoyees
FROM department d INNER JOIN employee e
ON d.dept_id = e.dept_id
GROUP BY d.name;

SELECT d.name, COUNT(e.emp_id) num_empoyees
FROM department d INNER JOIN employee e
ON d.dept_id = e.dept_id
GROUP BY d.name
HAVING COUNT(e.emp_id) > 2;

# order by 子句
SELECT open_emp_id, product_cd
FROM account;

SELECT open_emp_id, product_cd
FROM account
ORDER BY open_branch_id;

SELECT open_emp_id, product_cd
FROM account
ORDER BY open_branch_id, product_cd;

SELECT account_id, product_cd, open_date, avail_balance
FROM account
ORDER BY avail_balance DESC;

	# 根据表达式排序
	# RIGHT() 提取 fed_id 列的最后三个字符
SELECT cust_id, cust_type_cd, city, state, fed_id
FROM customer
ORDER BY RIGHT(fed_id, 3); 
	# 根据数字占位符排序
	# 根据 第2个和第5个列排序
SELECT emp_id, title, start_date, fname, lname
FROM employee
ORDER BY 2, 5 DESC; 

# 第 4 章
	#P69 正则表达式
	# null ### 重要#######################################################
		# 表达式可以为null，但不能等于null
		# 两个null值彼此不能判断为相等

# 第 5 章
DESC employee;
DESC department;
	# 笛卡儿积 交叉连接
SELECT e.fname, e.lname, d.name
FROM employee e JOIN department d;
	# 内连接 ：#############################################################
	# 如果一个表中的dept_id列中的列存在某个值
	# 但该值在另一张表的dept_id列中不存在
	# 在结果集中将会排除包含该值的行
SELECT e.fname, e.lname, d.name
FROM employee e JOIN department d
ON e.dept_id = d.dept_id;
	# 外连接：
	# 如果要包含其中某个表的所有行
	# 而不考虑每行是否在另一个表中存在匹配
	# 那么可以考虑使用外连接
	
	#最好显示指定连接类型，服务器默认使用内连接
SELECT e.fname, e.lname, d.name
FROM employee e INNER JOIN department d
ON e.dept_id = d.dept_id;
	
	# 两个表的列名相同可以使用 USING()
SELECT e.fname, e.lname, d.name
FROM employee e INNER JOIN department d
USING(dept_id);

	# ANSI 连接语法 P80
	# 其优点
	
	# 连接3个或更多表
	# 包含3个表和两种连接类型
SELECT a.account_id, c.fed_id
FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id
WHERE c.cust_type_cd = 'B';


SELECT a.`account_id`, c.`fed_id`, e.fname, e.lname
FROM account a INNER JOIN customer c
ON a.`cust_id` = c.`cust_id`
INNER JOIN employee e
ON a.`open_emp_id` = e.`superior_emp_id`
WHERE c.`cust_type_cd` = 'B';

# 交换前两张表结果完全一样
SELECT a.`account_id`, c.`fed_id`, e.fname, e.lname
FROM customer c INNER JOIN account a 
ON a.`cust_id` = c.`cust_id`
INNER JOIN employee e
ON a.`open_emp_id` = e.`superior_emp_id`
WHERE c.`cust_type_cd` = 'B';

	# P84 连接顺序的重要性
	
	# 将子查询结果作为查询表 P84 ###错误##################################################################
SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM acount a INNER JOIN
(SELECT emp_id, assigned_branch_id
FROM employee
WHERE start_date < '2002-01-01'
AND (title = 'Teller' OR title = 'Head Teller')) e
ON a.open_emp_id = e.emp_id
INNER ON 
(SELECT branch_id
FROM branch
WHERE NAME = 'Woburn Branch') b
ON e.assigned_branch_id = b.branch_id;


	# 不等连接
SELECT e.`emp_id`, e.`fname`, e.`lname`, e.`start_date`
FROM employee e INNER JOIN product p
ON e.`start_date` >= p.`date_offered`
AND e.`start_date` <= p.`date_retired`
WHERE p.`name` = 'no-fee checking';



# 其它
# ANSI 标准



# 内建函数官方文档




