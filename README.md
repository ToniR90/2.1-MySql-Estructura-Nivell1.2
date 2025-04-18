# 2.1.2: MySql - Pizzeria Ordering System - Database

This project defines a **relational database schema** for a pizza delivery web application. The system supports customer orders, physical stores, employees, product management (pizzas, burgers, drinks), and categorization of pizzas.

## 🗃️ Database Overview

This database is designed to:

- Store **customer information**
- Track **orders and products**
- Manage **physical store locations**
- Support **pizza categories**
- Assign **employees** to stores and deliveries
- Differentiate between **delivery and pickup** orders

---

## 🧱 Entity-Relationship Model

### 1. `province`

Stores provinces in which customers and stores are located.

| Field        | Type        | Description       |
|--------------|-------------|-------------------|
| province_id  | INT (PK)    | Unique ID         |
| name         | VARCHAR(100)| Province name     |

---

### 2. `location`

Stores cities/towns and their associated province.

| Field        | Type        | Description       |
|--------------|-------------|-------------------|
| location_id  | INT (PK)    | Unique ID         |
| name         | VARCHAR(100)| City name         |
| province_id  | INT (FK)    | Linked province   |

---

### 3. `customer`

Stores customer data who can place orders.

| Field                 | Type           | Description               |
|----------------------|----------------|---------------------------|
| customer_id          | INT (PK)       | Unique ID                 |
| customer_first_name  | VARCHAR(100)   | First name                |
| customer_last_name   | VARCHAR(100)   | Last name                 |
| customer_address     | VARCHAR(150)   | Street address            |
| customer_postal_code | VARCHAR(10)    | Postal code               |
| customer_phone_number| VARCHAR(20)    | Phone number              |
| customer_location_id | INT (FK)       | Linked location           |

---

### 4. `store`

Represents a physical store that processes orders.

| Field             | Type           | Description       |
|------------------|----------------|-------------------|
| store_id         | INT (PK)       | Unique ID         |
| store_address    | VARCHAR(150)   | Street address    |
| store_postal_code| VARCHAR(10)    | Postal code       |
| store_location_id| INT (FK)       | Linked location   |

---

### 5. `employee`

Employees working at each store.

| Field              | Type           | Description                              |
|-------------------|----------------|------------------------------------------|
| employee_id        | INT (PK)       | Unique ID                                |
| employee_first_name| VARCHAR(100)   | First name                               |
| employee_last_name | VARCHAR(100)   | Last name                                |
| employee_nif       | VARCHAR(20)    | Tax ID                                   |
| employee_phone_number | VARCHAR(20)| Phone number                             |
| employee_role      | VARCHAR(20)    | Role: `'cook'` or `'delivery'`           |
| employee_store_id  | INT (FK)       | Linked store                             |

---

### 6. `pizza_category`

Categories for organizing pizzas (e.g., "Special", "Vegan", "Seasonal").

| Field        | Type        | Description       |
|--------------|-------------|-------------------|
| category_id  | INT (PK)    | Unique ID         |
| category_name| VARCHAR(100)| Name of category  |

---

### 7. `product`

Menu items: pizzas, burgers, drinks.

| Field             | Type         | Description                        |
|------------------|--------------|------------------------------------|
| product_id        | INT (PK)     | Unique ID                          |
| product_name      | VARCHAR(100) | Product name                       |
| product_description | TEXT       | Description                        |
| product_image     | VARCHAR(255) | Image URL                          |
| product_price     | DECIMAL(6,2) | Price                              |
| product_type      | VARCHAR(20)  | `'pizza'`, `'burger'`, `'drink'`   |
| product_category_id| INT (FK)    | Optional (only for pizzas)         |

---

### 8. `order_table`

Stores orders placed by customers.

| Field               | Type          | Description                              |
|--------------------|---------------|------------------------------------------|
| order_id            | INT (PK)      | Unique ID                                |
| customer_id         | INT (FK)      | Customer who placed the order            |
| store_id            | INT (FK)      | Store handling the order                 |
| order_datetime      | DATETIME      | When the order was placed                |
| order_type          | VARCHAR(20)   | `'delivery'` or `'pickup'`               |
| total_price         | DECIMAL(8,2)  | Total amount paid                        |
| delivery_employee_id| INT (FK)      | Assigned delivery employee (if delivery) |
| delivery_datetime   | DATETIME      | Time of delivery (if applicable)         |

---

### 9. `order_product`

Links products to an order with quantity.

| Field       | Type       | Description                 |
|-------------|------------|-----------------------------|
| order_id    | INT (FK)   | Associated order            |
| product_id  | INT (FK)   | Product in the order        |
| quantity    | INT        | Quantity of the product     |

---

## ⚙️ Constraints & Business Logic

- **Employees** have fixed roles: `cook` or `delivery`.
- **Only delivery employees** can be assigned to home delivery orders.
- **Pizzas** may belong to a category; other product types do not.
- **Localities** belong to one province; **provinces** can contain many localities.


 
