-- Sequences for Customers
CREATE SEQUENCE customer_id_seq START WITH 1 INCREMENT BY 1;

-- Sequences for Menu_Items
CREATE SEQUENCE menu_item_id_seq START WITH 1 INCREMENT BY 1;

-- Sequences for Orders
CREATE SEQUENCE order_id_seq START WITH 1 INCREMENT BY 1;

-- Sequences for Order_Items
CREATE SEQUENCE order_item_id_seq START WITH 1 INCREMENT BY 1;

-- Sequences for Tables
CREATE SEQUENCE table_id_seq START WITH 1 INCREMENT BY 1;

-- Sequences for Reservations
CREATE SEQUENCE reservation_id_seq START WITH 1 INCREMENT BY 1;

-- Customers Table
CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL
);

-- Menu_Items Table
CREATE TABLE Menu_Items (
    menu_item_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    price NUMBER(10, 2) NOT NULL,
    type VARCHAR2(50) -- e.g., Appetizer, Main Course, Dessert
);

-- Orders Table
CREATE TABLE Orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER REFERENCES Customers(customer_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Order_Items Table
CREATE TABLE Order_Items (
    order_item_id NUMBER PRIMARY KEY,
    order_id NUMBER REFERENCES Orders(order_id) ON DELETE CASCADE,
    menu_item_id NUMBER REFERENCES Menu_Items(menu_item_id),
    quantity NUMBER NOT NULL
);

-- Tables Table
CREATE TABLE Tables (
    table_id NUMBER PRIMARY KEY,
    table_number NUMBER NOT NULL UNIQUE,
    capacity NUMBER NOT NULL
);

-- Reservations Table
CREATE TABLE Reservations (
    reservation_id NUMBER PRIMARY KEY,
    table_id NUMBER REFERENCES Tables(table_id) ON DELETE CASCADE,
    customer_id NUMBER REFERENCES Customers(customer_id),
    date_time TIMESTAMP NOT NULL
);

-- Trigger for Customers
CREATE OR REPLACE TRIGGER trg_customers_id
BEFORE INSERT ON Customers
FOR EACH ROW
BEGIN
    SELECT customer_id_seq.NEXTVAL INTO :NEW.customer_id FROM dual;
END;
/

-- Trigger for Menu_Items
CREATE OR REPLACE TRIGGER trg_menu_items_id
BEFORE INSERT ON Menu_Items
FOR EACH ROW
BEGIN
    SELECT menu_item_id_seq.NEXTVAL INTO :NEW.menu_item_id FROM dual;
END;
/

-- Trigger for Orders
CREATE OR REPLACE TRIGGER trg_orders_id
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    SELECT order_id_seq.NEXTVAL INTO :NEW.order_id FROM dual;
END;
/

-- Trigger for Order_Items
CREATE OR REPLACE TRIGGER trg_order_items_id
BEFORE INSERT ON Order_Items
FOR EACH ROW
BEGIN
    SELECT order_item_id_seq.NEXTVAL INTO :NEW.order_item_id FROM dual;
END;
/

-- Trigger for Tables
CREATE OR REPLACE TRIGGER trg_tables_id
BEFORE INSERT ON Tables
FOR EACH ROW
BEGIN
    SELECT table_id_seq.NEXTVAL INTO :NEW.table_id FROM dual;
END;
/

-- Trigger for Reservations
CREATE OR REPLACE TRIGGER trg_reservations_id
BEFORE INSERT ON Reservations
FOR EACH ROW
BEGIN
    SELECT reservation_id_seq.NEXTVAL INTO :NEW.reservation_id FROM dual;
END;
/

-- Insert into Customers
--INSERT INTO Customers (name) VALUES ('Cyuzuzo Parfait');
--INSERT INTO Customers (name) VALUES ('Shema Patrick');
--INSERT INTO Customers (name) VALUES ('Mucyo Gael');
--INSERT INTO Customers (name) VALUES ('Diana Prince');
--INSERT INTO Customers (name) VALUES ('Edward Elric');


-- Insert into Menu_Items
--INSERT INTO Menu_Items (name, price, type) VALUES ('Spaghetti', 12.99, 'Main Course');
--INSERT INTO Menu_Items (name, price, type) VALUES ('Caesar Salad', 8.99, 'Appetizer');
--INSERT INTO Menu_Items (name, price, type) VALUES ('Cheesecake', 6.99, 'Dessert');
--INSERT INTO Menu_Items (name, price, type) VALUES ('Grilled Chicken', 14.99, 'Main Course');
--INSERT INTO Menu_Items (name, price, type) VALUES ('Minestrone Soup', 5.99, 'Appetizer');


-- Insert into Tables
--INSERT INTO Tables (table_number, capacity) VALUES (1, 4);
--INSERT INTO Tables (table_number, capacity) VALUES (2, 2);
--INSERT INTO Tables (table_number, capacity) VALUES (3, 6);
--INSERT INTO Tables (table_number, capacity) VALUES (4, 4);
--INSERT INTO Tables (table_number, capacity) VALUES (5, 8);


-- Insert into Orders
--INSERT INTO Orders (customer_id) VALUES (1); -- Order for Parfait
--INSERT INTO Orders (customer_id) VALUES (2); -- Order for Patrick
--INSERT INTO Orders (customer_id) VALUES (3); -- Order for Gael
--INSERT INTO Orders (customer_id) VALUES (4); -- Order for Prince
--INSERT INTO Orders (customer_id) VALUES (5); -- Order for Elric


-- Insert into Order_Items
--INSERT INTO Order_Items (order_id, menu_item_id, quantity) VALUES (1, 1, 2); -- Parfait ordered 2 Spaghetti
--INSERT INTO Order_Items (order_id, menu_item_id, quantity) VALUES (1, 2, 1); -- Parfait ordered 1 Caesar Salad
--INSERT INTO Order_Items (order_id, menu_item_id, quantity) VALUES (2, 3, 1); -- Patrick ordered 1 Cheesecake
--INSERT INTO Order_Items (order_id, menu_item_id, quantity) VALUES (3, 4, 1); -- Gael ordered 1 Grilled Chicken
--INSERT INTO Order_Items (order_id, menu_item_id, quantity) VALUES (4, 5, 3); -- Diana ordered 3 Minestrone Soup


-- Insert into Reservations
--INSERT INTO Reservations (table_id, customer_id, date_time) 
--VALUES (1, 1, TO_TIMESTAMP('2024-10-03 19:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- Parfait reserved Table 1
--INSERT INTO Reservations (table_id, customer_id, date_time) 
--VALUES (2, 2, TO_TIMESTAMP('2024-10-03 19:30:00', 'YYYY-MM-DD HH24:MI:SS')); -- Patrick reserved Table 2
--INSERT INTO Reservations (table_id, customer_id, date_time) 
--VALUES (3, 3, TO_TIMESTAMP('2024-10-03 20:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- Gael reserved Table 3
--INSERT INTO Reservations (table_id, customer_id, date_time) 
--VALUES (4, 4, TO_TIMESTAMP('2024-10-03 20:30:00', 'YYYY-MM-DD HH24:MI:SS')); -- Diana reserved Table 4
--INSERT INTO Reservations (table_id, customer_id, date_time) 
--VALUES (5, 5, TO_TIMESTAMP('2024-10-03 21:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- Edward reserved Table 5


 Retrieve all orders with customer names
SELECT o.order_id, c.name AS customer_name, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

-- Retrieve all customers and their orders (with NULLs for unmatched records)
--SELECT c.name AS customer_name, o.order_id
--FROM Customers c
--FULL OUTER JOIN Orders o ON c.customer_id = o.customer_id;

--SELECT c.name AS customer_name,
  --     (SELECT COUNT(*)
    --    FROM Orders o
      --  WHERE o.customer_id = c.customer_id) AS order_count
--FROM Customers c;

--ALTER TABLE Customers ADD email VARCHAR2(100);





