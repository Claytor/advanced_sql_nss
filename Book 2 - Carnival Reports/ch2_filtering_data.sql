/* WHERE CLAUSE Practice*/

-- Find coustomers from texas
SELECT
	last_name,
	first_name,
	city,
	state
FROM
	customers
WHERE state = 'TX';

	