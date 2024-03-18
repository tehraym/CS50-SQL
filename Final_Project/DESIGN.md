# Design Document

By Raymond Teh

Video overview: https://youtu.be/k8Euc5jb8bs?si=4rbFBy74UGCyLtte

## Scope

This database has all the necessasary information to know the daily activities of all the restaurant outlets. It has sufficient data to conduct analysis on revenue, expenses and trends of each outlet. Furthurmore, these are the items were included in the scope of the databases:

* customer, include the basic identifying information (Pax number, table number, outlet)
* order_status, status of the order retrived from the customer
* menu, contains a list of food and beverage listed down with the price
* outlet, contains the basic identifying information of an outlet
* staff, contains identifying information of a staff
* transaction, contains the transaction between ingredients supplier and chef
* payment, states out payment detail by each customers
* supplier, states the supplier's details

outside scope of the database includes, amount of ingredients inventory, utility bills of the outlet, other outlet misc expenses and customer's information.

## Functional Requirements

This database will support:
* The ability to extract outlet's activities from timeframe to timeframe
* The ability to extract financial numbers for each outlet
* Tracking the customer's order statuses
* Providing data which are useful for trend analysis (Most Sales, Most Ordered Food, Most number of customer, etc)

The database will not support specifically for:
* Inventory tracking (Ingrediants, products and etc)
* Customer's Detail Tracking (Name, Age, etc)
* Will not support customer who uses delivery services

## Representation

Entities will captured on MySQL databases

### Entities

This database includes the following entities

### customer
The `customer` table includes the following:

* `id`, the id specified for the unique ID for the customers who came in the outlet restaurant as an `UNSIGNED INT`. This column has `PRIMARY KEY` and `AUTO INCREMENT` constraint applied. Do note that if repeated customer came in a new id will be generated for that customer.

* `outlet_id`, this id represents which outlet this customer belongs to. The outlet_id is a `FOREIGN KEY` which references to the `outlet` table

* `table_number` this number refers to which table number the customer is located in as an `SMALLINT`.

* `num_people` this number refers to the amount number of customer as an `TINYINT`


### order_status
The table `order_status` includes the following:

* `id`, the id specifed the unique ID for each order from each customer as an `UNSIGNED INT`. This column has `PRIMARY KEY` and `AUTO INCREMENT` constraint applied.

* `customer_id`, which is the id of the customer who made an order as an `UNSIGNED INT`. This column has `FOREIGN KEY` constraint applied referencing to `customer` table

* `waiter_id`, which represents the waiter who took the customer's order as an `INT`. This column has `FOREIGN KEY` constraint applied referencing to `staff` table.

* `item_id`, which represents the food/drink, that the customer orders as an `INT`
This column has `FOREIGN KEY` constraint applied referencing to `menu` table

* `status`, which represent the status of the order as `ENUM`. Statuses include (Ordered, Delivered, Paid, Cancelled). Do note that when status reflected as `Paid`, payment id will be generated in the `payment` table

* `payment_id`, which refers the payment id of the customer as `UNSIGNED INT`, payment_id will only appear on `status` column that shows as `Paid`, otherwise it will be `NULL`. This column has `FOREIGN KEY` constraint applied referencing to `payment` table.

* `comments`, this column representing the notes that the customer had given on how they wanted their food to be as a `TEXT`.

* `time_stamp`, this column represents the time when the customer ordered their food as format `DATETIME`, this column will had a `DEFAULT` input as `CURRENT_TIME`.


### payment
The `payment` table includes the following:

* `id`, the id specifed the unique ID for each payment from customers as an `UNSIGNED INT`. This column has `PRIMARY KEY` and `AUTO INCREMENT` constraint applied.

* `customer_id`, the id is specified for the unique ID for the customers who came in the restaurant as an `INT`. This column has a `FOREIGN KEY` constraint which referencing from `customer` table.

* `payment_type`, this column type shows what payment type the customer uses as `ENUM`. Payment types includes (`credit`, `cash`)


### outlet
The `outlet` tables includes the following:

* `id`, the id is specifed the unique ID for each restaurant outlet as `INT`. This column has `PRIMARY KEY` constraint applied. `AUTO INCREMENT` constraint will also be applied.

* `outlet_name`, this column represents the name of the outlet in `TEXT`

* `location`, this column represents the location of the outlet in `TEXT`

* `outlet_manager_id`, representing who is the manager of the outlet as `INT`. It had a constraint of `FOREIGN KEY` referencing to `staff` table.

* `monthly_rental`, represents the monthly rental of the outlet as `MEDIUMINT`.

### menu
The `menu` tables includes the following:

* `id` the id is specified the unique ID of each items in the menu. This column had a `PRIMARY KEY` and `AUTO INCREMENT` constraint applied.

* `item_name` referencing the name of the items in the menu in `TEXT`

* `price` referencing the price of the item in `INT`

* `type` this column refers to what type the item is in `ENUM`. The types includes (Food or Beverages)

### staff
The `staff` table includes the following

* `id` the id is specified the unique ID of each items in the menu. This column had a `PRIMARY KEY` and `AUTO INCREMENT` constraint applied.

* `name` referencing the staff's name in `TEXT`

* `contact` referencing the staff's contact number in `TEXT`

* `monthly_salary` referencing the staff's salary in `INT`

* `title` this column refer to the staff's title using `ENUM`. The types includes (Waiter, Chef, Outlet Manager)

* `outlet_id`, this id represents the outlet that the staff works. The outlet_id is a `FOREIGN KEY` which references to the `outlet` table

### transaction
The `transaction` table includes the following

* `id` the id is specified the unique ID of each transaction with the supplier in `UNSIGNED INT`. This column had `PRIMARY KEY` and `AUTO INCREMENT` constraint applied.

* `outlet_id` the id represents the the origin of the transaction in `INT`. This column had `FOREIGN KEY` constraint referencing to the `outlet` table.

* `chef_id` the id represents the chef who is responsible for the transaction with supplier in `INT`. This column had `FOREIGN KEY` referencing to the `staff` table

* `supplier_id`, the id represents the supplier who delivers the ingredients as `INT`. This column had `FOREIGN KEY` constraint referencing to `supplier` table.

* `ingredients_name`, this column represents the ingredient's name as `TEXT`

* `total_price`, this column represents the price of the ingrediants as `INT`

* `time_stamp`, this column represents the time when the customer ordered their food as format `DATETIME`, this column will had a `DEFAULT` input as `CURRENT_TIME`.

### supplier
* `id` the id is specified the unique ID of each supplier. This column had `PRIMARY KEY` and `AUTO INCREMENT` constraint applied.

* `name` this column represents the name of the supplier as `TEXT`

* `ingrediants` this column represent what ingrediants that this supplier supplies as `TEXT`

* `contact` referencing supplier's contact number as `TEXT`

### Relationships

As detailed in the diagram
![alt text](<CS50 SQL ER Diagram.png>)


### customers table
* One and only one customer table can only be in one outlet at a time
(Do Note that if repeated customer or new customer came in, a new id will be generated for that customer.)

### order_status table
* One and only one customer_table can place one or multiple orders of items
* One and only one waiter can take one or multiple orders from one customer at a time
* Multiple orders in the table can be referenced to Multiple items in the menu
* One or multiple orders can be referenced to one and only one payment_id

### outlet table
* One and only one outlet manager had one and only one identity reference

### transaction
* One or multiple outlet can place ingredients orders from one or multiple suppliers
* One and only one chef has one and only one identity reference
* One and only one supplier had one and only one identity reference

### payment
* One and only one total payment details will belong to one and only one customer table

### Staff
* One and only one staff can work in one and only one outlet

## Optimizations

It it common for restaurant and outlet owners to review their own revenue and expenses for each and every outlet from timeframe to timeframe. As such a `view` that shows monthly `Revenue` and `Expenses` of each outlet was created.

It is also common for restaurant to easily identify when you wanted to check the staff's activities and details in the restaurant at databases. So `indexes` were created for `name` column in `staff` table.

It is also very useful for outlets to identify most ordered food/beverages.
Therefore, a view of `Most ordered sorted by Month/year` was created.


## Limitations

The limitations of the database design assumes that each customer invariably dines at every outlet, and it lacks valuable functionalities for financial operations, such as tax calculation, tip calculation, and etc.
