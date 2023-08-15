--Top 5 Dealerships--
-- I am going to try to answer all quesitons in ONE table . . .
--For the top 5 dealerships: 

-- which employees made the most sales (I will intrepret as sales which were not returned), 
-- which vehicle models were the most popular in sales and 
-- were there more sales or leases?

/*My strategy is to use the arithmetic mean for all sales types per each employee per dealership to make fair compairisons between dealerships with unequal staffing.  I will use this metric to differentiate the top 5 performing dealerships. Note that using a weighed average may be more appropriate for finding profit per employee.  However, the margins per sales type are not provided*  Also, since I want to get a good idea of profit, I will exclude sales which were returned*/
 
/*Unique employees per dealership range from 74 to 115.  This represents a range of 41 employees across all 50 dealerhsips.*/ 

-- Sales per Employee CTE
WITH dms AS 
(
	SELECT
		s.dealership_id,
		d.business_name,
		-- avg_spe = sales per employee where the vehicle was not returned
		'$' ||''|| ROUND(SUM(s.price) / COUNT(DISTINCT s.employee_id), 2) AS avg_spe
	FROM sales s
	LEFT JOIN dealerships AS d ON s.dealership_id = d.dealership_id
	--I am going to exclude vehicles that were returned from revenue generated
	WHERE s.sale_returned = FALSE
	GROUP BY s.dealership_id, d.business_name
),
-- Ranked non-returned sales per employee per dealership CTE
d_rank AS
(
	SELECT
		s.dealership_id,
		s.employee_id,
		e.first_name ||' '|| e.last_name AS top_seller,
		COUNT(s.sale_id) AS transactions,
		ROW_NUMBER() OVER(PARTITION BY s.dealership_id ORDER BY COUNT(s.sale_id) DESC) AS rank
	FROM sales s
	LEFT JOIN employees e ON s.employee_id = e.employee_id
	WHERE s.sale_returned = FALSE
	GROUP BY s.dealership_id, s.employee_id, e.first_name, e.last_name
),
-- Most popular models which were not returned
top_model AS
(
	SELECT
		s.dealership_id,
		vt.model,
		COUNT(vt.model) as model_sales,
		ROW_NUMBER() OVER(PARTITION BY s.dealership_id ORDER BY COUNT(s.sale_id) DESC) AS rank
	FROM sales s
	LEFT JOIN vehicles as v ON s.vehicle_id = v.vehicle_id
	LEFT JOIN vehicletypes AS vt ON v.vehicle_type_id = vt.vehicle_type_id
	WHERE s.sale_returned = FALSE
	GROUP BY s.dealership_id, vt.model
),
-- Purchases vs. Leases majority per dealership
order_type AS
(
	SELECT
		s.dealership_id,
		st.sales_type_name AS transaction,
		COUNT(s.sales_type_id) AS count,
	-- There is only one "rent" record, all others are purchases or leases
		ROW_NUMBER() OVER(PARTITION BY s.dealership_id ORDER BY COUNT(s.sales_type_id) DESC) AS rank
	FROM sales AS s
	LEFT JOIN salestypes st ON s.sales_type_id = st.sales_type_id
	WHERE s.sales_type_id IN (1,2)
	GROUP BY s.dealership_id, st.sales_type_name
)
-- Main Query
SELECT
	d.business_name AS "Top 5 Dealerships",
	d.avg_spe AS "Per-Employee Transaction Mean",
	r.top_seller AS "Top Performing Employee by Sales Volume",
	tm.model AS "Most Popular Car Model",
	ot.transaction AS "Top Transaction Type"
FROM dms d
LEFT JOIN d_rank AS r ON d.dealership_id = r.dealership_id AND r.rank = 1
LEFT JOIN top_model AS tm ON d.dealership_id = tm.dealership_id AND tm.rank = 1
LEFT JOIN order_type AS ot ON d.dealership_id = ot.dealership_id and ot.rank = 1
ORDER BY d.avg_spe DESC
LIMIT 5;