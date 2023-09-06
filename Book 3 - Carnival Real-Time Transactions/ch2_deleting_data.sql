/*
Deleting Data Practice
*/

-- DELETE statement to delete one specific record:
DELETE FROM sales 
WHERE sales.sale_id = 100
;

-- DELETE statement to delete specific records by id:
DELETE FROM  sales 
WHERE sales.sale_id IN (100, 200, 300)
;

/*
A sales employee at carnival creates a new sales record for a sale they are trying to close. The customer, last minute decided not to purchase the vehicle. Help delete the Sales record with an invoice number of '2436217483'.
*/

DELETE FROM sales s
WHERE s.invoice_number = '2436217483'
;

/*
An employee was recently fired so we must delete them from our database. Delete the employee with employee_id of 35. What problems might you run into when deleting? How would you recommend fixing it?
*/

select * from 