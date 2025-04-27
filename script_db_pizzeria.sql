CREATE DATABASE IF NOT EXISTS pizzeria;
USE pizzeria;

CREATE TABLE province (
  province_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE location (
  location_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  province_id INT NOT NULL,
  FOREIGN KEY (province_id) REFERENCES province(province_id)
);

CREATE TABLE customer (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_first_name VARCHAR(100) NOT NULL,
  customer_last_name VARCHAR(100) NOT NULL,
  customer_address VARCHAR(150) NOT NULL,
  customer_postal_code VARCHAR(10) NOT NULL,
  customer_phone_number VARCHAR(20),
  customer_location_id INT NOT NULL,
  FOREIGN KEY (customer_location_id) REFERENCES location(location_id)
);

CREATE TABLE store (
  store_id INT PRIMARY KEY AUTO_INCREMENT,
  store_address VARCHAR(150) NOT NULL,
  store_postal_code VARCHAR(10) NOT NULL,
  store_location_id INT NOT NULL,
  FOREIGN KEY (store_location_id) REFERENCES location(location_id)
);

CREATE TABLE employee (
  employee_id INT PRIMARY KEY AUTO_INCREMENT,
  employee_first_name VARCHAR(100) NOT NULL,
  employee_last_name VARCHAR(100) NOT NULL,
  employee_nif VARCHAR(20) NOT NULL,
  employee_phone_number VARCHAR(20),
  employee_role VARCHAR(20) CHECK (employee_role IN ('cook', 'delivery')),
  employee_store_id INT NOT NULL,
  FOREIGN KEY (employee_store_id) REFERENCES store(store_id)
);

CREATE TABLE pizza_category (
  category_id INT PRIMARY KEY AUTO_INCREMENT,
  category_name VARCHAR(100) NOT NULL
);

CREATE TABLE product (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(100) NOT NULL,
  product_description TEXT,
  product_image VARCHAR(255),
  product_price DECIMAL(6,2) NOT NULL,
  product_type VARCHAR(20) CHECK (product_type IN ('pizza', 'burger', 'drink')),
  product_category_id INT,
  FOREIGN KEY (product_category_id) REFERENCES pizza_category(category_id)
);

CREATE TABLE order_table (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  store_id INT NOT NULL,
  order_datetime DATETIME NOT NULL,
  order_type VARCHAR(20) CHECK (order_type IN ('delivery', 'pickup')),
  total_price DECIMAL(8,2) NOT NULL,
  delivery_employee_id INT,
  delivery_datetime DATETIME,
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (store_id) REFERENCES store(store_id),
  FOREIGN KEY (delivery_employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE order_product (
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES order_table(order_id),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);


--DADES DE PROVA

INSERT INTO province (name) VALUES ('Girona');

INSERT INTO location (name, province_id) VALUES 
('Girona', 1),
('Salt', 1);

INSERT INTO customer (customer_first_name, customer_last_name, customer_address, customer_postal_code, customer_phone_number, customer_location_id) VALUES
('Joan', 'Serra', 'Carrer Major 1', '17001', '612345678', 1),
('Anna', 'Roca', 'Carrer Nou 23', '17190', '698765432', 2);

INSERT INTO store (store_address, store_postal_code, store_location_id) VALUES
('Carrer Comerç 10', '17002', 1),
('Av. Catalunya 33', '17190', 2);

INSERT INTO employee (employee_first_name, employee_last_name, employee_nif, employee_phone_number, employee_role, employee_store_id) VALUES
('Marc', 'Torres', '12345678A', '600111222', 'delivery', 1),
('Clara', 'Puig', '87654321B', '600333444', 'cook', 2);

INSERT INTO pizza_category (category_name) VALUES ('Classic');

INSERT INTO product (product_name, product_description, product_image, product_price, product_type, product_category_id) VALUES
('Pizza Margarita', 'Tomato sauce and cheese pizza', NULL, 8.50, 'pizza', 1),
('Beef burgyuer', 'Classic Burger', NULL, 6.90, 'burger', NULL),
('Coca-Cola', 'Soda drink', NULL, 2.00, 'drink', NULL),
('Water', 'Mineral water', NULL, 1.50, 'drink', NULL);

INSERT INTO order_table (customer_id, store_id, order_datetime, order_type, total_price, delivery_employee_id, delivery_datetime) VALUES
(1, 1, '2025-04-20 13:00:00', 'delivery', 12.00, 1, '2025-04-20 13:30:00');

INSERT INTO order_product (order_id, product_id, quantity) VALUES
(1, 1, 1),  
(1, 3, 2);

INSERT INTO order_table (customer_id, store_id, order_datetime, order_type, total_price, delivery_employee_id, delivery_datetime) VALUES
(2, 2, '2025-04-21 20:00:00', 'pickup', 10.40, NULL, NULL);

INSERT INTO order_product (order_id, product_id, quantity) VALUES
(2, 2, 1),
(2, 4, 1);



--Consultes

SELECT location.name AS location , SUM(order_product.quantity) AS total_drink FROM order_product INNER JOIN product ON order_product.product_id = product.product_id INNER JOIN order_table ON order_product.order_id = order_table.order_id INNER JOIN customer ON order_table.customer_id = customer.customer_id INNER JOIN location ON customer.customer_location_id = location.location_id WHERE product.product_type = 'drink' AND location.name = 'Girona' GROUP BY location.name;

SELECT employee.employee_first_name , employee.employee_last_name , COUNT(*) AS total_orders FROM order_table INNER JOIN employee ON order_table.delivery_employee_id = employee.employee_id WHERE employee.employee_first_name = 'Marc' AND employee.employee_last_name = 'Torres' GROUP BY employee.employee_id;



























