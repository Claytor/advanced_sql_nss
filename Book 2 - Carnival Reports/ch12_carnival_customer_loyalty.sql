-- ========================================
-- States With Most Customers
-- ========================================

/*
In this section, we aim to identify the regions with the highest customer base for dealerships participating in the Carnival platform. Understanding the customer distribution can help Carnival and its partner dealerships make informed decisions about marketing and inventory distribution.
*/

-- ========================================
-- Top 5 US States by Customer Count
-- ========================================

/*
What are the top 5 US states with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform?
*/

-- I intrepreted this as the state in which the most unique customers who have purchased a car reside.
SELECT
	c.state AS "Customer Home State",
	COUNT(DISTINCT s.customer_id) AS "Unique Customers"
FROM sales s
LEFT JOIN customers c ON s.customer_id = c.customer_id
LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE s.sales_type_id = 1
GROUP BY c.state
ORDER BY "Unique Customers" DESC
LIMIT 5
;
/*
"TX"	123
"CA"	112
"FL"	78
"NY"	52
"OH"	41
*/

-- ========================================
-- Top 5 US Zip Codes by Customer Count
-- ========================================

/*
What are the top 5 US zip codes with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform?
*/
SELECT
	c.zipcode AS "Zip Code",
	COUNT(DISTINCT s.customer_id) AS "Unique Customers"
FROM sales s
LEFT JOIN customers c ON s.customer_id = c.customer_id
LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE s.sales_type_id = 1
GROUP BY c.zipcode
ORDER BY COUNT(DISTINCT s.customer_id) DESC
LIMIT 5
;

-- ========================================
-- Top 5 Dealerships by Customer Count
-- ========================================

-- What are the top 5 dealerships with the most customers?
-- Intrepreted this as the most uniqe customers who made any kind of purchase
SELECT
	d.business_name AS "Dealership",
	COUNT(DISTINCT s.customer_id) AS "Unique Customers"
FROM sales s
LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
GROUP BY d.business_name
ORDER BY COUNT(DISTINCT s.customer_id) DESC
LIMIT 5
;
/*
"Junes Autos of Texas"	115
"Meeler Autos of San Diego"	114
"Mertgen Autos of Alabama"	113
"Twidell Autos of Kentucky"	110
"Newton Autos of Kansas"	109
*/