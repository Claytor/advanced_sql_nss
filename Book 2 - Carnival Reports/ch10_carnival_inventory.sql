-- ========================================
-- Available Models
-- ========================================

/*
Which model of vehicle has the lowest current inventory? This will help dealerships know which models to purchase from manufacturers.
*/

-- It looks like we are running low on "Gremlins"!  There are 2
SELECT
	vt.model AS "Vehicle Model",
	COUNT(v.vehicle_id) AS "Inventory"
FROM vehicles v
LEFT JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
WHERE v.is_sold = FALSE
GROUP BY vt.model
ORDER BY COUNT(v.vehicle_id)
LIMIT 1
;

/*
Which model of vehicle has the highest current inventory?.  This will help dealerships know which models are, perhaps, not selling.
*/

-- We have 606 Maximas in stock.
SELECT
	vt.model AS "Vehicle Model",
	COUNT(v.vehicle_id) AS "Inventory"
FROM vehicles v
LEFT JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
WHERE v.is_sold = FALSE
GROUP BY vt.model
ORDER BY COUNT(v.vehicle_id) DESC
LIMIT 1
;

-- ========================================
-- Diverse Dealerships
-- ========================================

/*
Which dealerships are currently selling the least number of vehicle models This will let dealerships market vehicle models more effectively per region.
*/

-- Curson Autos of Illinois has historically sold 8 distinct types of models
SELECT
	d.business_name AS "Dealership",
	COUNT(DISTINCT vt.model) AS "Unique Models Sold"
FROM sales s
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE v.is_sold = TRUE AND s.sales_type_id = 1
GROUP BY d.business_name
ORDER BY "Unique Models Sold"
LIMIT 3
;

/*
Which dealerships are currently selling the highest number of vehicle models? This will let dealerships know which regions have either a high population, or less brand loyalty.
*/

-- Sollime Autos of Minnesota has historically sold 14 types of models.
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
LIMIT 1
;