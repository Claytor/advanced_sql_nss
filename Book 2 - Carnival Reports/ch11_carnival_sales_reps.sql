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
-- ...

-- ========================================
-- Top 2 employees with most sales through leasing vehicles
-- ========================================

-- Get a report on the top two employees who have made the most sales through leasing vehicles.
-- ...