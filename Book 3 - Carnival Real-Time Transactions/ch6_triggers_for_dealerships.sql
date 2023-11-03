-- ========================================
-- PRACTICE PROBLEM 1: Ensure Consistent Website URL Format
-- ========================================
-- Whenever a new dealership is added or an existing one is updated, 
-- ensure the website URL follows the format: http://www.carnivalcars.com/{name of the dealership with underscores separating words}.
-- Hint: You might want to consider using triggers for this.
/*
CREATE OR REPLACE FUNCTION FormatWebsiteURL()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
BEGIN
    -- Your code here
END;
$$
*/

-- ========================================
-- PRACTICE PROBLEM 2: Default Phone Number
-- ========================================
-- If a phone number is not provided when adding a new dealership, 
-- automatically set it to the default number: 777-111-0305.
-- Hint: You might want to use the COALESCE function or check for NULL values.
/*
CREATE OR REPLACE FUNCTION DefaultPhoneNumber()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
BEGIN
    -- Your code here
END;
$$
*/

-- ========================================
-- PRACTICE PROBLEM 3: Add State to Tax ID
-- ========================================
-- For each new or updated dealership, ensure that the tax id includes the state name at the end.
-- Example: If the provided tax id is bv-832-2h-se8w for a dealership in Virginia, 
-- the stored tax id should be bv-832-2h-se8w--virginia.
/*
CREATE OR REPLACE FUNCTION AddStateToTaxID()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
BEGIN
    -- Your code here
END;
$$
*/
