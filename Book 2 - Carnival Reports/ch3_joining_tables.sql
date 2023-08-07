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
	c.first_name AS cust_first,
	c.last_name AS cust_last,
	e.first_name AS emp_first,
	e.last_name AS emp_last,
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


/*3.  Get a list of all the dealerships and the employees, if any, working at each one.
*/
/*4.  Get a list of vehicles with the names of the body type, make, model and color.*/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/