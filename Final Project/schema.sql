-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it
CREATE TABLE `customer`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `outlet_id` INT,
    `table_number` SMALLINT,
    `num_people` TINYINT,
    PRIMARY KEY(`id`)
);

CREATE TABLE `order_status`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `customer_id` INT UNSIGNED,
    `waiter_id` INT,
    `item_id` INT,
    `status` ENUM('Ordered', 'Delivered', 'Paid', 'Cancelled') NOT NULL,
    `payment_id` INT UNSIGNED,
    `comments` TEXT,
    `time_stamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`customer_id`) REFERENCES `customer`(`id`),
    FOREIGN KEY(`waiter_id`) REFERENCES `staff`(`id`),
    FOREIGN KEY(`item_id`) REFERENCES `menu`(`id`),
    FOREIGN KEY(`payment_id`) REFERENCES `payment`(`id`)
);

CREATE TABLE `menu`(
    `id` INT AUTO_INCREMENT,
    `item_name` TEXT,
    `price` INT NOT NULL,
    `type` ENUM('Food', 'Beverage') NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `outlet`(
    `id` INT AUTO_INCREMENT,
    `outlet_name` TEXT,
    `location` TEXT,
    `outlet_manager_id` INT,
    `monthly_rent` MEDIUMINT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`outlet_manager_id`) REFERENCES `staff`(`id`)
);

CREATE TABLE `staff`(
    `id` INT AUTO_INCREMENT,
    `name` TEXT,
    `contact` TEXT,
    `monthly_salary` INT,
    `title` ENUM('Waiter', 'Chef', 'Outlet Manager') NOT NULL,
    `outlet_id` INT,
    FOREIGN KEY (`outlet_id`) REFERENCES `outlet`(`id`),
    PRIMARY KEY (`id`)
);

CREATE TABLE `transaction`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `outlet_id` INT,
    `chef_id` INT,
    `supplier_id` INT,
    `ingredients_name` TEXT,
    `total_price` INT,
    `time_stamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`outlet_id`) REFERENCES `outlet`(`id`),
    FOREIGN KEY(`chef_id`) REFERENCES `staff`(`id`),
    FOREIGN KEY(`supplier_id`) REFERENCES `supplier`(`id`)
);

CREATE TABLE `payment`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `customer_id` INT UNSIGNED ,
    `payment_type` ENUM('Credit', 'Cash') NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`customer_id`) REFERENCES `customer`(`id`)
);

CREATE TABLE `supplier`(
    `id` INT AUTO_INCREMENT,
    `name` TEXT,
    `ingredients` TEXT,
    `contact` TEXT,
    PRIMARY KEY(`id`)
);

-- View of Monthly Revenue for every outlet
CREATE VIEW `Monthly Revenue for every outlet` AS
SELECT o.outlet_name,
        YEAR(o_s.time_stamp) AS `year`,
        MONTH(o_s.time_stamp) AS `month`,
        SUM(m.price) AS `total_revenue`
FROM outlet o
JOIN customer c ON o.id = c.outlet_id
JOIN order_status o_s ON c.id = o_s.customer_id
JOIN menu m ON o_s.item_id = m.id
WHERE o_s.status = 'Paid'
GROUP BY o.outlet_name, YEAR(o_s.time_stamp), MONTH(o_s.time_stamp)
ORDER BY o.outlet_name;

-- View of Monthly Expenses for every outlet
CREATE VIEW `Monthly Expenses for every outlet` AS
SELECT o.id,
		o.outlet_name,
		YEAR(t.time_stamp) AS `Year`,
        MONTH(t.time_stamp) AS `Month`,
        o.monthly_rent,
        SUM(t.total_price) AS 'Total Expenses on ingrediants',
        (SELECT SUM(monthly_salary) FROM STAFF WHERE outlet_id = o.id) AS 'Staff Salary'
FROM outlet o
JOIN transaction t ON t.outlet_id = o.id
GROUP BY o.id, o.outlet_name, `Year`, `Month`,o.monthly_rent;


-- Creating Index for Staff Name
CREATE INDEX staff_names
ON staff(name(225));


--View for Most ordered sorted by Month/year
		MONTH(o_s.time_stamp) AS `Month`,
           m.item_name AS 'Most Ordered items',
           COUNT(o_s.item_id) AS 'Amount Ordered'
FROM order_status o_s
JOIN menu m ON o_s.item_id = m.id
WHERE o_s.status = 'Ordered'
GROUP BY YEAR(o_s.time_stamp),MONTH(o_s.time_stamp), m.item_name
ORDER BY COUNT(o_s.item_id) DESC;




