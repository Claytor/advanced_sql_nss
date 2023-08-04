/* WHERE CLAUSE Practice*/

-- customers from texas: 132
SELECT
	c.last_name,
	c.first_name,
	c.city,
	c.state
FROM
	customers c
WHERE c.state = 'TX';

-- customers from houston, tx: 31
SELECT
	c.last_name,
	c.first_name,
	c.city,
	c.state
FROM
	customers c
WHERE c.state = 'TX' and c.city = 'Houston';

-- customers from texas or tennessee: 152
SELECT
	c.last_name,
	c.first_name,
	c.city,
	c.state
FROM
	customers c
WHERE c.state = 'TX' or c.state = 'TN';

-- customers from texas, tennessee, or california: 281
SELECT
	c.last_name,
	c.first_name,
	c.city,
	c.state
FROM
	customers c
WHERE c.state IN ('TX', 'TN', 'CA');

-- customers from states starting with 'c': 176
SELECT
	c.last_name,
	c.first_name,
	c.city,
	c.state
FROM
	customers c
WHERE c.state LIKE 'C%';

-- customers whose last name is greater than 5 characters and first name is lessthan or equal to 7 characters: 341
SELECT
	c.last_name,
	c.first_name,
	c.city,
	c.state
FROM
	customers c
WHERE LENGTH(c.last_name) > 5 AND LENGTH(c.first_name) <= 5;

-- customers whose company name has between 10 and 20 characters (10 >= x > 20): 622

SELECT
	c.last_name,
	c.first_name,
	c.company_name
FROM
	customers c
WHERE LENGTH(c.company_name) BETWEEN 10 and 20;

-- customers whose company name is null: 2 
SELECT
	c.last_name,
	c.first_name,
	c.company_name
FROM
	customers c
WHERE c.company_name IS NULL;

-- sales records where the sale was a lease: 2,516 sales
-- note: leas is sales_type_id = 2
SELECT
	*
FROM
	sales s
WHERE
	s.sales_type_id = 2;

-- lases where the purchase date is within the last 5 years:  662 Sales
SELECT
	*
FROM
	sales s
WHERE
	s.purchase_date BETWEEN '2018-08-04' AND '2023-08-04';
	
-- sales wehre the deposit was above $5,000 or the customer paid with an american express card: 3,742 sales
SELECT
	*
FROM
	sales s
WHERE
	s.payment_method = 'americanexpress' or s.deposit > 5000;
	
-- employees whose first name start with 'm' or ends with 'd': 122 employees
SELECT
	e.employee_id,
	e.last_name,
	e.first_name
FROM
	employees e
WHERE
	e.first_name LIKE 'M%' OR e.first_name LIKE '%d';

--employees whose phone numbers have the 604 area code: 3 employees
SELECT
	e.employee_id,
	e.last_name,
	e.first_name,
	e.phone
FROM
	employees e
WHERE
	e.phone LIKE '604%';