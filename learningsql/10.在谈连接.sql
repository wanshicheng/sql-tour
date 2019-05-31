USE bank;
# 外连接

SELECT account_id, cust_id
FROM account;

SELECT cust_id
FROM customer;

SELECT a.account_id, c.cust_id
FROM account a INNER JOIN customer c
ON a.`cust_id` = c.`cust_id`;


