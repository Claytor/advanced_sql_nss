/*Find employees who haven't made any sales and the name of the dealership they work at.*/
SELECT
	e.first_name ||' '|| e.last_name AS employee,
	d.business_name AS dealership,
	s.price
FROM
	employees e
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
