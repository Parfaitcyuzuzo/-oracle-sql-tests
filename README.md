# Restaurant Management System

This README provides an overview of the database schema for a restaurant management system. The system is designed to handle customers, menu items, orders, tables, and reservations.

## Database Schema

The database consists of the following tables:

1. Customers
2. Menu_Items
3. Orders
4. Order_Items
5. Tables
6. Reservations

### Sequences

Each table has an associated sequence for generating unique IDs:

- customer_id_seq
- menu_item_id_seq
- order_id_seq
- order_item_id_seq
- table_id_seq
- reservation_id_seq

### Tables

#### Customers
- `customer_id` (Primary Key)
- `name`

#### Menu_Items
- `menu_item_id` (Primary Key)
- `name`
- `price`
- `type` (e.g., Appetizer, Main Course, Dessert)

#### Orders
- `order_id` (Primary Key)
- `customer_id` (Foreign Key referencing Customers)
- `order_date`

#### Order_Items
- `order_item_id` (Primary Key)
- `order_id` (Foreign Key referencing Orders)
- `menu_item_id` (Foreign Key referencing Menu_Items)
- `quantity`

#### Tables
- `table_id` (Primary Key)
- `table_number`
- `capacity`

#### Reservations
- `reservation_id` (Primary Key)
- `table_id` (Foreign Key referencing Tables)
- `customer_id` (Foreign Key referencing Customers)
- `date_time`

### Triggers

Triggers are implemented for each table to automatically generate IDs using the associated sequences.

## Usage

The script includes commented-out INSERT statements that can be used to populate the tables with sample data. Uncomment these statements to add initial data to the database.

## Queries

The script includes example queries:

1. Retrieve all orders with customer names
2. Retrieve all customers and their orders (commented out)
3. Count orders per customer (commented out)

## Notes

- The script is written for an Oracle database, using Oracle-specific syntax like `VARCHAR2` and `NUMBER`.
- Foreign key constraints are implemented to maintain referential integrity.
- The `Order_Items` table uses `ON DELETE CASCADE` for its foreign key to `Orders`, ensuring that when an order is deleted, its associated items are also removed.

## Future Enhancements

The script includes a commented-out ALTER TABLE statement to add an email column to the Customers table, suggesting potential future enhancements to the schema.
