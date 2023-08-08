/*JOINING TABLES*/

/* PERSONAL QUESTION FOR FUN! What is the make, model, and vin for all v8 trucks that have been sold?  how many have been sold*/
-- 234
SELECT 
	vt.make,
	vt.model,
	v.vin
FROM vehicles v
INNER JOIN vehicletypes vt
	ON v.vehicle_type_id = vt.vehicle_type_id
WHERE
	v.engine_type = 'V8' AND vt.body_type = 'Truck' AND v.is_sold = 'true';

/*1.  Get a list of the sales that were made for each sales type.*/
SELECT
	s.purchase_date,
	s.invoice_number,
	s.price,
	st.sales_type_name
FROM 
	sales s
LEFT JOIN salestypes st
	ON s.sales_type_id = st.sales_type_id;
	
/*2.  Get a list of sales with the VIN of the vehicle, the first name and last name of the customer, first name and last name of the employee who made the sale and the name, city and state of the dealership.
*/
SELECT 
	s.invoice_number AS invoice,
	v.vin,
	c.first_name || ' ' || c.last_name AS customer,
	e.first_name || ' ' || e.last_name AS employee,
	d.business_name AS dealership,
	d.city,
	d.state
FROM
	sales s
LEFT JOIN vehicles v
	ON s.vehicle_id = v.vehicle_id
LEFT JOIN customers c
	ON s.customer_id = c.customer_id
LEFT JOIN employees e
	ON s.employee_id = e.employee_id
LEFT JOIN dealerships d
	ON s.dealership_id = d.dealership_id
ORDER BY
	s.invoice_number;


/*3.  Get a list of all the dealerships and the employees, if any, working at each one.
*/
SELECT
	d.business_name AS dealership,
	e.first_name || ' ' || e.last_name AS employee	
FROM 
	dealershipemployees de
LEFT JOIN 
	employees e
		ON de.employee_id = e.employee_id
LEFT JOIN
	dealerships d
		ON de.dealership_id = d.dealership_id
ORDER BY 
	d.business_name; 

/*4.  Get a list of vehicles with the names of the body type, make, model and color.*/
SELECT
	vt.body_type AS body, 
	vt.make,
	vt.model,
	v.exterior_color AS exterior,
	v.interior_color AS interior
FROM
	vehicles v
LEFT JOIN vehicletypes vt
	on v.vehicle_type_id = vt.vehicle_type_id
ORDER BY vt.body_type;
