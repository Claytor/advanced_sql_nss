/* Simple query to test if database 
is loaded correctly */

/* Select all records from sales table
where the customer paid more than $70,000
with a bank card */

SELECT *
FROM sales
WHERE payment_method = 'bankcard'
	AND price > 70000