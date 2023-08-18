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
CREATE VIEW sales2018 AS
	SELECT 
		st.sales_type_name AS "Sales Type", 
		COUNT(s.sales_type_id) AS "Total Sales"
	FROM sales s
	LEFT JOIN salestypes st ON s.sales_type_id = st.sales_type_id
	WHERE EXTRACT(YEAR FROM s.purchase_date) = 2018
	GROUP BY st.sales_type_name
;
-- ========================================
-- Top Salesperson at Each Dealership
-- ========================================
select* from sales;
-- Create a view that shows the employee at each dealership with the highest number of sales.
CREATE VIEW dealership_top_sellers AS
	WITH ranked_sales AS
	(
		SELECT
			s.dealership_id,
			e.first_name || ' ' || e.last_name AS employee_name,
			SUM(s.price) AS sales_amount,
			ROW_NUMBER() OVER(PARTITION BY s.dealership_id ORDER BY COUNT(s.price) DESC) AS rank
		FROM sales s
		LEFT JOIN employees e ON s.employee_id = e.employee_id
		WHERE s.sale_returned = FALSE
		GROUP BY s.dealership_id, e.first_name, e.last_name
	)
	SELECT
		d.business_name AS "Dealership",
		rs.employee_name AS "Top Employee",
		'$' || TO_CHAR(rs.sales_amount, 'FM999,999.00') AS "Total Sales"
	FROM ranked_sales rs
	LEFT JOIN dealerships d ON rs.dealership_id = d.dealership_id
	WHERE rs.rank = 1;