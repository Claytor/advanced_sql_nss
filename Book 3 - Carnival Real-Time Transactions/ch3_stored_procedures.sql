-- ========================================
-- PRACTICE PROBLEM 1: Update Vehicle Price
-- ========================================
-- Create a stored procedure that accepts a vehicle_id and a percentage. 
-- The procedure should increase the price of the given vehicle by the specified percentage.
-- Example: If the price of a vehicle with ID 5 is $10,000 and you pass in 10 as the percentage,
-- the new price should be updated to $11,000.

CREATE OR REPLACE PROCEDURE UpdateVehiclePrice(p_vehicle_id INT, p_percentage FLOAT)
LANGUAGE plpgsql 
AS $$
BEGIN
    -- Calculate new price and update
    UPDATE vehicles
    SET floor_price = floor_price * (1 + p_percentage / 100)
    WHERE vehicle_id = p_vehicle_id;
END;
$$;

-- Call Procedure - update price of vehicle_id 1 by 10%
CALL UpdateVehiclePrice(1, 10);

-- See if the changes worked (GREAT SUCCESS!)
select* from vehicles where vehicle_id = 1;

-- ========================================
-- PRACTICE PROBLEM 2: Calculate Employee Sales Total
-- ========================================

-- Create a stored procedure that accepts an employee_id.
-- The procedure should return the total sales made by that employee.
-- Additionally, consider providing a message indicating if the employee has outstanding, average, or below average sales,
-- based on the sales total.

CREATE OR REPLACE PROCEDURE CalculateEmployeeSalesTotal(p_employee_id INT) RETURNS FLOAT AS
LANGUAGE plpgsql AS
$$
DECLARE
    total_sales FLOAT; -- Variable to hold total sales per employee
	avg_sales FLOAT; -- Variable to hold average of all sales
	high_threshold FLOAT; -- Variable for high sales threshold 
	low_threshold FLOAT; -- Variable for low sales threshold
BEGIN
-- Calculating total sales for given employee
	SELECT COALESCE(SUM(price), 0) INTO total_sales -- Using COALESCE to avoid null value errors
	FROM sales
	WHERE employee_id = p_employee_id;
	
-- Calculating average sales
	SELECT COALESCE(AVG(price), 0) INTO avg_sales
	FROM sales;
	
-- Assinging thresholds based on calculated average sales
	high_threshold := avg_sales * 1.20; -- 20% above average
	low_threshold := avg_sales * 0.80; -- 20% below average
	
-- Making message for total sales and performance thresholds
	RAISE NOTICE 'Total Sales for Employee %: %', p_employee_id, total_sales;
	
-- Logic for performance notices
	IF total_sales = 0 THEN
		RAISE NOTICE 'No sales data for employee %.', p_employee_id;
	ELSIF total_sales > high_threshold THEN
		RAISE NOTICE 'Outstanding Sales';
	ELSIF total_sales >= low_threshold AND total_sales <= high_threshold THEN
		RAISE NOTICE 'Average Sales';
	ELSE
		RAISE NOTICE 'Below Average Sales';
	END IF;
	RETURN total_sales;
END;
$$;



-- ========================================
-- PRACTICE PROBLEM 3: Lease Duration Update
-- ========================================
-- Assume there's a field in your sales table that indicates the duration of a lease in months. 
-- Create a stored procedure that accepts a sale_id and a number of months. 
-- The procedure should update the duration of the lease for that specific sale entry. 
-- Include error handling for cases where the sale_id does not exist or is not a lease.

/*
CREATE OR REPLACE PROCEDURE UpdateLeaseDuration(p_sale_id INT, p_months INT)
LANGUAGE plpgsql AS
$$
BEGIN
    -- Your code here
END;
$$
*/


