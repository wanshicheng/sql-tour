# 3-1
SELECT emp_id, fname, lname
FROM employee
ORDER BY 2, 3;

# 5-1
SELECT e.`emp_id`, e.`fname`, e.`lname`, b.`name`
FROM employee e INNER JOIN branch b
ON e.`assigned_branch_id` = b.`branch_id`