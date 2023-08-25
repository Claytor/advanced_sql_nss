-- ========================================
-- CARNIVAL REPORTS
-- ========================================

-- In this series of reports, we're attempting to draw insights into Carnival's operations and performances.
-- These metrics will help the business make data-driven decisions.

-- ========================================
-- EMPLOYEE REPORTS
-- ========================================

-- Best Sellers Report
-- These queries help determine the top performers, both in terms of employees and dealerships. 

-- 1. Who are the top 5 employees for generating sales income?
SELECT
	e.first_name ||' '|| e.last_name "Employee",
	'$' || TO_CHAR(SUM(s.price), 'FM999,999.00') AS "Total Revenue"
FROM sales s
LEFT JOIN employees e 
	ON s.employee_id = e.employee_id
WHERE s.sale_returned = FALSE
GROUP BY e.first_name, e.last_name
ORDER BY "Total Revenue" DESC
LIMIT 5
;
-- 2. Who are the top 5 dealerships for generating sales income?
SELECT
	d.business_name as "Dealership",
	'$' || TO_CHAR(SUM(s.price), 'FM999,999,999.00') AS "Dealership Revenue"
FROM sales s
LEFT JOIN dealerships d 
	ON s.dealership_id = d.dealership_id
WHERE s.sale_returned = FALSE
GROUP BY d.business_name
ORDER BY "Dealership Revenue" DESC
LIMIT 5
;

-- 3. Which vehicle model generated the most sales income?
WITH model AS
(	SELECT
		v.vehicle_id,
		vt.model
	FROM vehicles v
	LEFT JOIN vehicletypes AS vt
		ON v.vehicle_type_id = vt.vehicle_type_id 
)
SELECT
	m.model as "Model",
	'$' || TO_CHAR(SUM(s.price), 'FM999,999,999.00') AS "Model Revenue"
FROM sales s
LEFT JOIN model m
	ON s.vehicle_id = m.vehicle_id
WHERE s.sale_returned = FALSE
GROUP BY m.model
ORDER BY SUM(s.price) DESC
LIMIT 5
;
-- 4. Which employees generate the most income per dealership?
-- Query will rank employees within each dealership based on the income they generate.
WITH top_sellers AS
(
	SELECT
		s.dealership_id,
		e.first_name ||' '|| e.last_name AS top_seller,
		SUM(s.price) AS transactions,
		ROW_NUMBER() OVER(PARTITION BY s.dealership_id ORDER BY SUM(s.price) DESC) AS rank
	FROM sales s
	LEFT JOIN employees e ON s.employee_id = e.employee_id
	WHERE s.sale_returned = FALSE
	GROUP BY s.dealership_id, s.employee_id, e.first_name, e.last_name
)

SELECT
	d.business_name AS "Dealership",
	ts.top_seller AS "Top Seller",
	ts.transactions AS "Gross Sales"
FROM top_sellers ts
LEFT JOIN dealerships d
	ON ts.dealership_id = d.dealership_id
WHERE ts.rank = 1
ORDER BY d.business_name
;
-- ========================================
-- VEHICLE REPORTS
-- ========================================

-- Inventory Report
-- These queries shed light on the current state of the vehicle inventory, categorized by different parameters.

-- 5. In our Vehicle inventory, show the count of each Model that is in stock.
SELECT
	vt.model AS "Vehicle Model",
	COUNT(v.vehicle_id) AS "Inventory"
FROM vehicles v
LEFT JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
WHERE v.is_sold = FALSE
GROUP BY vt.model
ORDER BY COUNT(v.vehicle_id) DESC
;
-- 6. In our Vehicle inventory, show the count of each Make that is in stock.
SELECT
	vt.make AS "Vehicle Make",
	COUNT(v.vehicle_id) AS "Inventory"
FROM vehicles v
LEFT JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
WHERE v.is_sold = FALSE
GROUP BY vt.make
ORDER BY COUNT(v.vehicle_id) DESC
;

-- 7. In our Vehicle inventory, show the count of each BodyType that is in stock.
SELECT
	vt.body_type AS "Body Types",
	COUNT(v.vehicle_id) AS "Inventory"
FROM vehicles v
LEFT JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
WHERE v.is_sold = FALSE
GROUP BY vt.body_type
ORDER BY COUNT(v.vehicle_id) DESC
;
-- ========================================
-- PURCHASING POWER REPORT
-- ========================================
-- This report attempts to understand customer behavior across different US states.

-- 8. Which US state's customers have the highest average purchase price for a vehicle?
SELECT
	c.state AS "Customer Home State",
	ROUND(AVG(s.price),2) AS "Average Purchase Price"
FROM sales s
LEFT JOIN customers c ON s.customer_id = c.customer_id
LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE s.sales_type_id = 1
GROUP BY c.state
ORDER BY AVG(s.price) DESC
LIMIT 1
;
-- 9. Now using the data determined above, which 5 states have the customers with the highest average purchase price for a vehicle?

SELECT
	c.state AS "Customer Home State",
	ROUND(AVG(s.price),2) AS "Average Purchase Price"
FROM sales s
LEFT JOIN customers c ON s.customer_id = c.customer_id
LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE s.sales_type_id = 1
GROUP BY c.state
ORDER BY "Average Purchase Price" DESC
LIMIT 5
;
-- Query will rank the top 5 states based on the average purchase price of vehicles by customers.

