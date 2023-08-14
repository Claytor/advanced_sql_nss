/*Insert some oil change records into the database.*/
-- INSERT INTO
-- 	oilchangelogs
-- 	(date_occured, vehicle_id)
-- VALUES
--     ('2020-01-09', 1),
--     ('2021-10-30', 2),
--     ('2019-02-20', 3),
--     ('2022-03-17', 4);

/*Create a CTE to get cars that require an oil change service.*/
--looks like 15 people need an oil change
WITH vehicles_needing_service AS
(
	SELECT
		v.vehicle_id,
        v.year_of_car,
        v.miles_count,
        TO_CHAR(o.date_occured, 'YYYY-MM-DD') date_of_last_change
	FROM vehicles v
	JOIN oilchangelogs o
		ON v.vehicle_id = o.vehicle_id
	WHERE o.date_occured < '2022-01-01'
)
SELECT	
	vs.vehicle_id,
	vs.miles_count,
	s.purchase_date,
	e.first_name ||' '|| e.last_name AS seller,
	c.first_name ||' '|| c.last_name AS purchaser,
	c.email
FROM vehicles_needing_service vs
JOIN sales s
	ON s.vehicle_id = vs.vehicle_id
JOIN employees e
	ON s.employee_id = e.employee_id
JOIN customers c
	ON s.customer_id = c.customer_id
ORDER BY
	vs.vehicle_id,
	s.purchase_date DESC;
	
/*Since multiple people can purchase the same car over time, the service manager only wants the last purchaser. You can break this part of the SQL out into another CTE. You can use multiple CTEs as part of the query. You separate them with a comma.*/
WITH vehicles_needing_service AS
(
	SELECT
		v.vehicle_id,
        v.year_of_car,
        v.miles_count,
        TO_CHAR(o.date_occured, 'YYYY-MM-DD') date_of_last_change
	FROM vehicles v
	JOIN oilchangelogs o
		ON v.vehicle_id = o.vehicle_id
	WHERE o.date_occured < '2022-01-01'
),
last_purchase AS
(
	SELECT
		s.vehicle_id,
		MAX(s.purchase_date) AS purchased
	FROM sales s
	GROUP BY s.vehicle_id
)
SELECT
	vc.vehicle_id,
	vs.miles_count,
	lp.purshaces,
	e.first_name ||' '|| e.last_name seller,
	c.first_name ||' '|| c.purchaser,
	e.email
FROM vehicles_needing_service vs
JOIN last_purchase
	ON lp.vehicle_id = vs.vehicle_id
JOIN sales s
	ON lp.vehicle_id = s.vehicle_id
	AND lp.purchased = s.purchase_date
JOIN employees e
	ON s.employee_id = e.employee_id
JOIN customers c
	ON s.customer_id = c.customer_id
	
--Top 5 Dealerships--
/*For the top 5 dealerships, which employees made the most sales? I am going to choose to define "best" as highest arithmetic mean of employee to overall sales revenue*/

/*My strategy is to use the arithmetic mean for all sales types per each employee per dealership to make fair compairisons between dealerships with unequal staffing.  I will use this metric to differentiate the top 5 performing dealerships. Note that using a weighed average may be more appropriate for finding profit per employee.  However, the margins per sales type are not provided*/
 
/*Unique employees per dealership range from 74 to 115.  This represents a range of 41 employees across all 50 dealerhsips.*/ 

/*Here I will use 'dms' which represents "dealership mean sales" revenue per employee*/
WITH dms AS 
(
SELECT
	s.dealership_id,
	-- avg_spe = average sales per employee
	'$' ||''|| ROUND(SUM(s.price) / COUNT(DISTINCT s.employee_id), 2) AS avg_spe
FROM
	sales s
GROUP BY
	s.dealership_id
ORDER BY
	avg_spe DESC
LIMIT 5;
),
WITH average AS
-- Average revenue per dealership.  Again, 50 dealerships are represented and have unique values for each
(
SELECT
	s.dealership_id,
	-- average of revenue per dealership
	SUM(s.price) AS revenue
FROM
	sales s
GROUP BY
	s.dealership_id
ORDER BY
	dealership_id
)
SELECT
	weight.employees + average.revenue / weight.employees as weighted_average

/*For the top 5 dealerships, which vehicle models were the most popular in sales?*/
select* FROM sales

/*For the top 5 dealerships, were there more sales or leases?*/

