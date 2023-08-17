-- ========================================
-- Practice: Creating views
-- ========================================

-- ========================================
-- View of Vehicle Attributes
-- ========================================

-- Create a view that lists all vehicle body types, makes and models.
-- I'm going to throw current inventory on there as well.
CREATE VIEW fleet_inventory AS
	SELECT
		vt.body_type AS "Body Type",
		vt.make AS "Make",
		vt.model AS "Model",
		COUNT(v.vehicle_type_id) AS "Inventory"
	FROM vehicles AS v
	LEFT JOIN vehicletypes as vt ON v.vehicle_type_id = vt.vehicle_type_id
	WHERE v.is_sold = FALSE
	GROUP BY vt.body_type, vt.make, vt.model
	ORDER BY "Make"
;

-- ========================================
-- Employee Count by Type
-- ========================================

-- Create a view that shows the total number of employees for each employee type.
CREATE VIEW position_staffing AS
	SELECT
		et.employee_type_name AS "Role",
		COUNT (DISTINCT e.employee_id) "Staffing"
	FROM employees AS e
	LEFT JOIN employeetypes et
		ON e.employee_type_id = et.employee_type_id
	GROUP BY et.employee_type_name
	;

-- ========================================
-- Redacted Customer List
-- ========================================

-- Create a view that lists all customers without exposing their emails, phone numbers and street address.
CREATE VIEW customer_list AS
	SELECT
		c.customer_id as "Customer ID",
		c.first_name ||' '|| c.last_name AS "Customer Name"
	FROM customers c
;

-- ========================================
-- Sales for 2018
-- ========================================

-- Create a view named sales2018 that shows the total number of sales for each sales type for the year 2018.
-- ...

-- ========================================
-- Top Salesperson at Each Dealership
-- ========================================

-- Create a view that shows the employee at each dealership 
-- with the most number of sales.
-- ...
