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


#关联子查询
	#在跟新或删除语句中经常会用到

