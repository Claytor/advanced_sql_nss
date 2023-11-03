-- ========================================
-- PRACTICE PROBLEM 1: Update Vehicle Price
-- ========================================
-- Create a stored procedure that accepts a vehicle_id and a percentage. 
-- The procedure should increase the price of the given vehicle by the specified percentage.
-- Example: If the price of a vehicle with ID 5 is $10,000 and you pass in 10 as the percentage,
-- the new price should be updated to $11,000.

/*
CREATE OR REPLACE PROCEDURE UpdateVehiclePrice(p_vehicle_id INT, p_percentage FLOAT)
LANGUAGE plpgsql AS
$$
BEGIN
    -- Your code here
END;
$$
*/

-- ========================================
-- PRACTICE PROBLEM 2: Calculate Employee Sales Total
-- ========================================
-- Create a stored procedure that accepts an employee_id.
-- The procedure should return the total sales made by that employee.
-- Additionally, consider providing a message indicating if the employee has outstanding, average, or below average sales,
-- based on the sales total.

/*
CREATE OR REPLACE PROCEDURE CalculateEmployeeSalesTotal(p_employee_id INT)
LANGUAGE plpgsql AS
$$
DECLARE
    total_sales FLOAT;
BEGIN
    -- Your code here
END;
$$
*/

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


