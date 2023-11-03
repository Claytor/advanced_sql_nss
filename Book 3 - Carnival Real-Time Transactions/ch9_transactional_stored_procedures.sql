-- -----------------------------------------------------------------------------
-- Transactional Stored Procedure for New Customer and Sales Records
-- -----------------------------------------------------------------------------

-- Question 1: 
-- How can you handle the insertion of a new customer and then create 
-- two sales records for that customer using a transactional stored procedure?

-- Answer:
CREATE OR REPLACE PROCEDURE new_customer_new_sale()
LANGUAGE plpgsql
AS $$
DECLARE 
  NewCustomerId INTEGER;
  CurrentTS DATE;
BEGIN
    -- Inserting new customer record
    INSERT INTO customers(first_name, last_name, email, phone, street, city, state, zipcode, company_name)
        VALUES
        ('BILL','Simlet','r.simlet@remves.com','615-876-1237','77 Miner Lane','San Jose','CA','95008','Remves') 
        RETURNING customer_id INTO NewCustomerId;

    COMMIT;

    CurrentTS = CURRENT_DATE;

    -- Inserting the first sales record for the new customer
    INSERT INTO sales(sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method)
        VALUES(1,1,1,NewCustomerId,1,24333.67,6500,CurrentTS,CurrentTS + interval '7 days',1273592747, 'solo');

    COMMIT;

    -- Inserting the second sales record for the new customer
    INSERT INTO sales(sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method)
        VALUES(1,1,1,NewCustomerId,1,24333.67,6500,CurrentTS,CurrentTS + interval '7 days',1273592747);

END;$$

-- To invoke the procedure:
CALL new_customer_new_sale();

-- Note: The procedure might throw an error due to the second sales record 
-- missing a value for payment_method. However, due to the COMMIT statements, 
-- the new customer record and the first sales record would still get created.
-- -----------------------------------------------------------------------------
