-- -----------------------------------------------------------------------------
-- Creating Carnival Reports
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Issue 1: Accounting Needs
-- -----------------------------------------------------------------------------

-- Provide a way for the accounting team to track all financial transactions.
-- Create a new table called 'Accounts Receivable' with columns:
-- credit_amount, debit_amount, date_received, a primary key, and a foreign key to link to a sale.

-- Set up a trigger on the Sales table. 
-- When a new row is added, make an entry to the 'Accounts Receivable' table.
-- Use the deposit as credit_amount, the current timestamp for date_received, and associate the sale_id.

-- Implement another trigger on the Sales table.
-- When the 'sale_returned' flag changes, add an entry to the 'Accounts Receivable' table.
-- Use the deposit as debit_amount, the current timestamp for date_received, and associate the sale_id.

-- -----------------------------------------------------------------------------
-- Issue 2: HR Needs
-- -----------------------------------------------------------------------------

-- Help HR streamline the onboarding and offboarding processes.

-- Create a stored procedure with a transaction to handle hiring a new employee:
-- 1. Insert a new record for the employee in the Employees table.
-- 2. Add entries in the Dealershipemployees table for the two initial dealerships the new employee will be assigned to.

-- Create another stored procedure with a transaction for when an employee departs:
-- 1. Delete the employee's record from the Employees table.
-- 2. Remove all records linking the departing employee to any dealerships in the Dealershipemployees table.
