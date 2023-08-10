/*Find employees who haven't made any sales and the name of the dealership they work at.*/
SELECT
	e.first_name ||' '|| e.last_name AS employee,
	d.business_name AS dealership,
	s.price
FROM employees e
INNER JOIN dealershipemployees de 
	ON e.employee_id = de.employee_id
Inner JOIN dealerships d
	ON d.dealership_id = de.dealership_id 
LEFT JOIN sales s 
	ON s.employee_id = e.employee_id
WHERE s.price IS NULL;

/*Get all the dealerships in the database, all the employees in the database, and the floor price of any vehicle they have sold.*/
SELECT
	d.business_name AS dealership,
	e.first_name ||' '|| e.last_name AS employee,
	v.floor_price
FROM dealerships d
LEFT JOIN dealershipemployees de
	ON d.dealership_id = de.dealership_id
INNER JOIN employees e
	ON e.employee_id = de.employee_id
INNER JOIN sales s
	ON s.employee_id = e.employee_id
INNER JOIN vehicles v
	ON s.vehicle_id = v.vehicle_id;
	
/*Use a self join to list all sales that will be picked up on the same day, including the full name of customer picking up the vehicle*/
SELECT
    c.first_name ||' '|| c.last_name AS customer,
    s1.invoice_number,
    s1.pickup_date
FROM sales s1
INNER JOIN sales s2
    ON s1.sale_id <> s2.sale_id 
    AND s1.pickup_date = s2.pickup_date
INNER JOIN customers c
   ON c.customer_id = s1.customer_id;

/*Get employees and customers who have interacted through a sale. Include employees who may not have made a sale yet. Include customers who may not have completed a purchase.*/
SELECT
	e.first_name ||' '|| e.last_name AS employee,
	c.first_name ||' '|| c.last_name AS customer
FROM employees e
FULL OUTER JOIN sales s
	ON e.employee_id = s.employee_id
FULL OUTER JOIN customers c
	ON s.customer_id = c.customer_id;
	
/*Get a list of all dealerships and which roles each of the employees hold*/
SELECT
	d.business_name AS dealership,
	et.employee_type_name AS role
FROM dealerships d
LEFT JOIN dealershipemployees de
	ON d.dealership_id = de.dealership_id
INNER JOIN employees e
	ON de.employee_id = e.employee_id
RIGHT JOIN employeetypes et
	ON e.employee_type_id = et.employee_type_id;
	
/*Produce a report that lists every dealership, the number of purchases done by each, and the number of leases done by each.*/

SELECT
	d.business_name AS dealership,
	COUNT(s.sales_type_id)
		FILTER (WHERE s.sales_type_id=1) AS purchases,
	COUNT(s.sales_type_id)
		FILTER (WHERE s.sales_type_id=2) AS leases
FROM
	sales s
LEFT JOIN salestypes st
	ON s.sales_type_id = st.sales_type_id
Left JOIN dealerships d
	ON s.dealership_id = d.dealership_id
WHERE
	s.sales_type_id IN (1, 2)
GROUP BY
	d.business_name
ORDER BY
	d.business_name;

/*Produce a report that determines the most popular vehicle model that is leased.*/
-- Its a Maxima with 294 leases
SELECT
	vt.model,
	COUNT(s.sales_type_id) AS leases
FROM
	sales s
INNER JOIN vehicles v
	ON s.vehicle_id = v.vehicle_id
INNER JOIN vehicletypes vt
	ON v.vehicle_type_id = vt.vehicle_type_id
WHERE s.sales_type_id = 2
GROUP BY vt.model
ORDER BY leases DESC
LIMIT 1;


/*Who Sold What 1 - What is the most popular vehicle make in terms of number of sales?*/
--Nissan with 679 sales
SELECT
	vt.make,
	COUNT(s.sales_type_id) AS sales	
FROM
	sales s
INNER JOIN 
	vehicles v 
	ON s.vehicle_id = v.vehicle_id
INNER JOIN 
	vehicletypes vt 
	ON v.vehicle_type_id = vt.vehicle_type_id
WHERE s.sales_type_id = 1
GROUP BY vt.make
ORDER BY sales DESC
LIMIT 1;

/*Who Sold What 2 - Which employee type sold the most of that make?*/
-- McLelland and Succamore are tied with 4 each
SELECT
	e.first_name ||' '|| e.last_name AS employee,
	COUNT(s.sales_type_id)
		FILTER (WHERE s.sales_type_id=1) AS nissans_sold
FROM
	sales s
INNER JOIN vehicles v
	ON s.vehicle_id = v.vehicle_id
INNER JOIN vehicletypes vt
	ON v.vehicle_type_id = vt.vehicle_type_id
INNER JOIN employees e
	on s.employee_id = e.employee_id
WHERE vt.make = 'Nissan'
GROUP BY employee
ORDER BY nissans_sold DESC;