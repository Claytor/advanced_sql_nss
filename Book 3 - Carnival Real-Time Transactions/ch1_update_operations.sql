/*
Kristopher Blumfield an employee of Carnival has asked to be transferred to a different dealership location. She is currently at dealership 9. She would like to work at dealership 20. Update her record to reflect her transfer.
*/
-- Note to self: Kristopher is employee_id = 9

UPDATE public.dealershipemployees
SET dealership_id = 20
WHERE employee_id = 9
;

/*
A Sales associate needs to update a sales record because her customer want to pay with a Mastercard instead of JCB. Update Customer, Ernestus Abeau Sales record which has an invoice number of 9086714242.
*/
-- Note to Self: Abeau's customer ID is 160
UPDATE public.sales
SET payment_method = 'Mastercard'
WHERE invoice_number = '9086714242'
;