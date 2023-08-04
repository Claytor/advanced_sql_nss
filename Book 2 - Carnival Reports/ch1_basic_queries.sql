--BASIC QUERIES--

--Select all vehicles--
SELECT
	*
FROM
	Vehicles;

/*Select engine type, floor price, and msr price from vehicles using an alias */
SELECT
	v.engine_type,
	v.floor_price,
	v.msr_price
FROM
	vehicles v;

/*Write a query that returns the business name, city, state, and website for each dealership. Use an alias for the Dealerships table.*/

SELECT
	d.business_name,
	d.city,
	d.state,
	d.website
FROM
	dealerships d;

/* Write a query that returns the first name, last name, and email address of every customer. Use an alias for the Customers table.*/

SELECT
	c.first_name,
	c.last_name,
	c.email
FROM 
	customers c;


	