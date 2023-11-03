-- ========================================
-- PRACTICE: CARNIVAL
-- ========================================

-- ========================================
-- PRACTICE PROBLEM 1: Set Purchase Date
-- ========================================
-- Create a trigger for the Sales table. 
-- When a new Sales record is added, the trigger should automatically set the purchase date to 3 days from the current date.
-- Hint: You might use 'NEW.purchase_date' and PostgreSQL's interval functionality.

-- ========================================
-- PRACTICE PROBLEM 2: Update Pickup Date
-- ========================================
-- Create a trigger for updates to the Sales table. 
-- If the pickup date is set to on or before the purchase date, the trigger should update it to be 7 days after the purchase date.
-- If the pickup date is after the purchase date but less than 7 days out, the trigger should add 4 days to the pickup date.
-- Hint: Check the difference between 'NEW.pickup_date' and 'NEW.purchase_date' to determine which action to take.
