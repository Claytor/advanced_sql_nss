-- ========================================
-- Purchase Income by Dealership
-- ========================================

-- Write a query that shows the total purchase sales income per dealership.
-- This will be useful later, so I'll make it a view
CREATE VIEW total_purchase_income_per_dealership AS
	SELECT 
		d.business_name AS "Dealership",
		'$' || TO_CHAR(SUM(s.price), 'FM99,999,999.00') AS "Total Sales Income"
	FROM sales s
	LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
	WHERE sales_type_id = 1
	GROUP BY d.business_name;

-- Write a query that shows the purchase sales income per dealership for all of 2020.
SELECT 
	d.business_name AS "Dealership",
	'$' || TO_CHAR(SUM(s.price), 'FM99,999,999.00') AS "2020 Purchase Sales Income"
FROM sales s
LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE sales_type_id = 1 
	AND EXTRACT(YEAR FROM purchase_date) = 2020
GROUP BY d.business_name;

-- ========================================
-- Lease Income by Dealership
-- ========================================

-- Write a query that shows the total lease income per dealership.
-- This will be useful later, so I'll make it a view
CREATE VIEW total_lease_income_per_dealership AS
	SELECT 
		d.business_name AS "Dealership",
		'$' || TO_CHAR(SUM(s.price), 'FM9,999,999.00') AS "Total Lease Income"
	FROM sales s
	LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
	WHERE sales_type_id = 2 
	GROUP BY d.business_name;

-- Write a query that shows the lease income per dealership for Jan of 2020.
SELECT 
	d.business_name AS "Dealership",
	'$' || TO_CHAR(SUM(s.price), 'FM999,999.00') AS "January 2020 Lease Income"
FROM sales s
LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE sales_type_id = 2 
	AND EXTRACT(YEAR FROM purchase_date) = 2020
	AND EXTRACT(MONTH FROM purchase_date) = 1
GROUP BY d.business_name;

-- Write a query that shows the lease income per dealership for all of 2019.
SELECT 
	d.business_name AS "Dealership",
	'$' || TO_CHAR(SUM(s.price), 'FM999,999.00') AS "2019 Lease Income"
FROM sales s
LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE sales_type_id = 2 
	AND EXTRACT(YEAR FROM purchase_date) = 2019
GROUP BY d.business_name;

-- ========================================
-- Total Income by Employee
-- ========================================

-- Write a query that shows the total income (purchase and lease) per employee.
-- This will be useful later, so I'll make it a view
CREATE VIEW total_combined_income_per_employee AS
	SELECT 
		e.first_name ||' '|| e.last_name AS "Employee",
		'$' || TO_CHAR(SUM(s.price), 'FM999,999.00') AS "Total Combined Sales & Lease Income"
	FROM sales s
	LEFT JOIN employees e ON s.employee_id = e.employee_id
	WHERE sales_type_id IN (1,2) 
	GROUP BY e.last_name, e.first_name
	ORDER BY e.last_name
	;