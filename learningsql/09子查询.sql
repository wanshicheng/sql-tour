USE bank;
# 结果集
	# 单列单行
	# 单列多行
	# 多列多行

# 非关联子查询
	# 单独执行而不需要引用包含语句中的任何内容
	# 标量子查询：返回的是一个单行单列的列表
			# 可以用于常用运算符的任意一边
			# 常用运算符 =、<>、<、>、<=、>=
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE account_id = (SELECT MAX(account_id) FROM account);

SELECT MAX(account_id) FROM account;

SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE account_id = 29;


SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE open_emp_id <> (SELECT e.emp_id
FROM employee e INNER JOIN branch b
ON e.`assigned_branch_id` = b.`branch_id`
WHERE e.`title` = 'Head Teller' AND b.`city`= 'Woburn');
	# 如果在等式条件下使用子查询
	# 而子查询又返回多行结果，将会出错
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE open_emp_id <> (SELECT e.emp_id
FROM employee e INNER JOIN branch b
ON e.`assigned_branch_id` = b.`branch_id`
WHERE e.`title` = 'Teller' AND b.`city`= 'Woburn');

# 单独运行子查询，会返回多行

SELECT e.emp_id
FROM employee e INNER JOIN branch b
ON e.`assigned_branch_id` = b.`branch_id`
WHERE e.`title` = 'Teller' AND b.`city`= 'Woburn';

# 多行单列子查询
	# in 和 not in 运算符
	# 检查一个值集中能否包含某一个值
SELECT branch_id, NAME, city
FROM branch
WHERE NAME IN ('Headquarters', 'Quincy Branch');

SELECT branch_id, NAME, city
FROM branch
WHERE NAME = 'Headquarters' OR NAME =  'Quincy Branch';


SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id IN (SELECT superior_emp_id
FROM employee);

SELECT superior_emp_id
FROM employee;

SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id NOT IN (SELECT superior_emp_id
FROM employee
WHERE superior_emp_id IS NOT NULL);

	# all 运算符
	# 将某单值与集合中的每个值进行比较
	# 即与常用运算符（=、<>、<、>、<=、>=）配合使用
SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id <> ALL (SELECT superior_emp_id
FROM employee
WHERE superior_emp_id IS NOT NULL);	


SELECT account_id, cust_id, product_cd, avail_balance
FROM account
WHERE avail_balance < ALL (SELECT a.avail_balance
FROM account a INNER JOIN individual i
ON a.cust_id = i.cust_id
WHERE i.fname = 'Frank' AND i.lname = 'Tucher');

SELECT a.avail_balance
FROM account a INNER JOIN individual i
ON a.cust_id = i.cust_id
WHERE i.fname = 'Frank' AND i.lname = 'Tucker';

	# any 运算符
	# 使用 =any 与使用in等效
SELECT account_id, cust_id, product_cd, avail_balance
FROM account
WHERE avail_balance > ANY (SELECT a.avail_balance
FROM account a INNER JOIN individual i
ON a.`cust_id` = i.`cust_id`
WHERE i.fname = 'Frank' AND i.lname = 'Tucker');

	# 多列子查询
		#一个多重单列子查询的例子
SELECT account_id, product_cd, cust_id
FROM account
WHERE open_branch_id = (SELECT branch_id
FROM branch
WHERE NAME = 'Woburn Branch')
AND open_emp_id IN (SELECT emp_id
FROM employee
WHERE title = 'Teller' OR title = 'Head Teller');


#关联子查询
	#在跟新或删除语句中经常会用到
	
	
SELECT RAND(1);	
SELECT RAND(2);	
