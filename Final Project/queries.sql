-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Checking Outlet's 5 ,Table 10 customer's Order
SELECT c.id,
	o.outlet_name,
	c.table_number,
    o_s.waiter_id,
    o_s.status,
    o_s.comments,
    o_s.time_stamp
FROM order_status o_s
JOIN customer c ON o_s.customer_id = c.id
JOIN outlet o ON c.outlet_id = o.id
WHERE o.outlet_name = 'Outlet A' AND c.table_number = 5;

-- Checking spices supplier's details
SELECT *
FROM supplier
WHERE ingredients LIKE '%spices%';

-- Adding a new dish to the menu
INSERT INTO `menu`(`item_name`, `price`, `type`)
VALUES
('Fish and Chips', '12', 'Food');

-- Recruited a new staff
INSERT INTO `staff`(`name`,`contact`,`monthly_salary`,`title`,`outlet_id`)
VALUES
('John Liam', '666-090-245', '3000', 'waiter', 3 );

-- Adding a new supplier
INSERT INTO `supplier`(`name`, `ingredients`, `contact`)
VALUES
('Chen', 'Fish', '233-534-5634');
