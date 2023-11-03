-- ========================================
-- INVENTORY MANAGEMENT
-- ========================================

-- ========================================
-- SELLING A VEHICLE
-- ========================================
-- Carnival aims to automate the process of updating their inventory when a sale occurs.
-- Instead of deleting the vehicle record, they want to flag the vehicle as 'is_sold' in the Vehicles table.
-- This flag, when set to TRUE, indicates that the vehicle is no longer available in the inventory.
-- The idea behind not deleting the vehicle record is to ensure that it remains linked to the sales record.

/*
CREATE OR REPLACE PROCEDURE SellVehicle(p_vehicle_id INT)
LANGUAGE plpgsql AS
$$
BEGIN
    -- Your code to set is_sold to TRUE for the specified vehicle and other related updates
END;
$$
*/

-- ========================================
-- RETURNING A VEHICLE
-- ========================================
-- If a customer returns a vehicle, Carnival has several tasks to manage.
-- Firstly, the vehicle needs to be marked as available again, i.e., is_sold should be set to FALSE.
-- Secondly, the original sales record should indicate that the sale was returned, by setting sale_returned to TRUE.
-- Furthermore, every returned vehicle gets an oil change. This activity must be logged in the OilChangeLogs table.

/*
CREATE OR REPLACE PROCEDURE ReturnVehicle(p_vehicle_id INT, p_sale_id INT)
LANGUAGE plpgsql AS
$$
BEGIN
    -- Your code to handle the return of a vehicle, the sales record update, and the oil change log
END;
$$
*/

-- END OF INVENTORY MANAGEMENT PROCEDURES
