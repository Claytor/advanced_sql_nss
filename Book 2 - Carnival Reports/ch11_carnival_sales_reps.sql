-- ========================================
-- Carnival Sales Reps - Employee Reports
-- ========================================

/*
In this section, I will generate reports on the performance and distribution of employees within the Carnival Cars Database.
*/

-- ========================================
-- Count of employees for each role
-- ========================================

-- How many employees are there for each role?
CREATE VIEW employee_count_by_role AS 	
	SELECT
		et.employee_type_name AS "Role",
		COUNT (DISTINCT e.employee_id) "Staffing"
	FROM employees AS e
	LEFT JOIN employeetypes et
		ON e.employee_type_id = et.employee_type_id
	GROUP BY et.employee_type_name
;

/*
"Business Development"	149
"Customer Service"	150
"Finance Manager"	144
"General Manager"	135
"Porter"	144
"Sales"	141
"Sales Manager"	138
*/
-- ========================================
-- Count of finance managers at each dealership
-- ========================================
-- How many finance managers work at each dealership?
-- Staffing for the role ranges from 0 to 7
-- There are two dealerships that do not have finance managers!
SELECT 
	d.business_name AS Dealership,
	SUM(CASE WHEN et.employee_type_name = 'Finance Manager' THEN 1 ELSE 0 END) AS "Finance Managers"
FROM employees e
LEFT JOIN dealershipemployees de ON e.employee_id = de.employee_id
LEFT JOIN dealerships d ON de.dealership_id = d.dealership_id
LEFT JOIN employeetypes et ON e.employee_type_id = et.employee_type_id
GROUP BY d.business_name
ORDER BY "Finance Managers"
;
-- ========================================
-- Top 3 employees working at the most dealerships
-- ========================================

-- Get the names of the top 3 employees who work shifts at the most dealerships.
-- Can't directly answer the question, Top Employee works 3 sites.  27 employees work 2 sites.
SELECT 
	e.first_name ||' '|| e.last_name AS "Employee",
	COUNT (DISTINCT de.dealership_id) AS "Worksites"
FROM dealershipemployees de
JOIN employees e ON de.employee_id = e.employee_id
GROUP BY e.first_name, e.last_name
ORDER BY "Worksites" DESC
;
-- ========================================
-- Top 2 employees with most sales through leasing vehicles
-- ========================================

-- Get a report on the top two employees who have made the most sales through leasing vehicles.
/* Kyle Corssen mad the most lease sales, with a count of 9.Boote Chittock was in second with 8 lease transactions.  However, Boote but generated $51,275.75 more than Kyle.
*/
CREATE VIEW view_top_leasing_employees AS
	SELECT
		d.business_name AS "Dealership",
		COUNT (DISTINCT vt.model) AS "Unique Models Sold"
	FROM sales s
	JOIN vehicles v ON s.vehicle_id = v.vehicle_id
	JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
	JOIN dealerships d ON s.dealership_id = d.dealership_id
	WHERE v.is_sold = TRUE AND s.sales_type_id = 1
	GROUP BY d.business_name
	ORDER BY COUNT(vt.model) DESC
;
SELECT 
		e.first_name ||' '|| e.last_name AS "Employee",
		COUNT(s.sale_id) AS "Leases",
		'$' || TO_CHAR(SUM(s.price), 'FM999,999.00') AS "Lease Revenue"
	FROM sales s
	LEFT JOIN employees as e ON s.employee_id = e.employee_id
	WHERE s.sales_type_id = 2
	GROUP BY e.first_name, e.last_name
	ORDER BY "Leases" DESC
;