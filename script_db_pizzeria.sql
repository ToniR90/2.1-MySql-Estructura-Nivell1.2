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