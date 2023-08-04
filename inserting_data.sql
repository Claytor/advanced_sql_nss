/* Insert new type to salestype
table*/

INSERT INTO public.salestypes(sales_type_name)
VALUES ('Rent');

/* Insert a new record into the sales
table using the new salestypes tuple*/

INSERT INTO public.sales(sales_type_id, vehicle_id, employee_id, dealership_id, price, invoice_number)
VALUES (3, 21, 12, 7, 5599, 123477289);

/* Insert multiple records into the sales
table using the new salestypes tuple*/

INSERT INTO
public.sales(sales_type_id, vehicle_id, employee_id, dealership_id, price, invoice_number)
VALUES
(3, 21, 12, 7, 55999, 123477289),
(3, 14, 3, 7, 19999, 232727349),
(3, 6, 75, 7, 39500, 8635482010);

/* Insert two new customers into customers
table*/

INSERT INTO public.customers(first_name, last_name, email) 
VALUES
('Leo', 'Claytor', 'dad@claytor.com'),
('Linda', 'Claytor', 'mom@claytor.com');

/* Insert new entry for your dream car into the vehicletypes
table and add it to the vehicle table*/ 

--make new entry into vehicle types
INSERT INTO public.vehicletypes(body_type, make, model)
VALUES ('Car', 'American Motors Corporation', 'Gremlin');

--add gremlin to vehicles
INSERT INTO public.vehicles(vin, engine_type, vehicle_type_id, exterior_color, interior_color, floor_price, msr_price, miles_count, year_of_car, is_sold, is_new, dealership_location_id) 
VALUES ('5XYKU4A75FG619907', 'V8', 31, 'Goldenrod', 'Yellow', 1000, 1879, 1000000, 1970, FALSE, FALSE, 44);

/* add a new employee with the following info. This employee works shifts at the first three dealerships listed in your Dealerships table:
Name: Kennie Maharg
Email: kmaharge@com.com
Phone: 598-678-4885
Role: Customer Service

Notes: 
employeetypes = 4
Kennie's employee_id = 1001
dealership_id = 1, 2, 3
*/

-- Add Kennie to Employees
INSERT INTO public.employees(first_name, last_name, email_address, phone, employee_type_id)
VALUES('Kennie', 'Maharg', 'kmaharge@com', '598-678-4885', 4);

-- Add Kennie to the dealershipemployees
INSERT INTO public.dealershipemployees(dealership_id, employee_id)
VALUES 
(1, 1001),
(2, 1001),
(3, 1001);

-- Confirming that Kennie works at all three dealerships
SELECT*
FROM dealershipemployees
WHERE employee_id = 1001;
