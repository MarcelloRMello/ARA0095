-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS fbv;
-- Utilização do banco de dados
USE fbv;

-- Criação da tabela employees
CREATE TABLE IF NOT EXISTS employees (
    employee_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    department_id INTEGER,
    salary REAL,
    hire_date DATE
);

-- Criação da tabela departments
CREATE TABLE IF NOT EXISTS departments (
    department_id INTEGER PRIMARY KEY,
    department_name TEXT NOT NULL,
    manager_id INTEGER
);

-- Criação da tabela orders
CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE
);

-- Criação da tabela products
CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    price REAL
);

-- Criação da tabela order_items
CREATE TABLE IF NOT EXISTS order_items (
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Criação da tabela customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT NOT NULL,
    email TEXT
);

-- Criação de índices
CREATE INDEX idx_department_id ON employees (department_id);
CREATE INDEX idx_manager_id ON departments (manager_id);
CREATE INDEX idx_customer_id ON orders (customer_id);
CREATE INDEX idx_order_id ON order_items (order_id);
CREATE INDEX idx_product_id ON order_items (product_id);

-- Inserção de dados na tabela employees
INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, hire_date) VALUES
    (1, 'John', 'Doe', 1, 6000, '2023-01-15'),
    (2, 'Jane', 'Smith', 2, 5500, '2022-05-20'),
    (3, 'Michael', 'Johnson', 1, 6200, '2024-02-10');

-- Inserção de dados na tabela departments
INSERT INTO departments (department_id, department_name, manager_id) VALUES
    (1, 'Sales', 1),
    (2, 'Marketing', 2);

-- Inserção de dados na tabela orders
INSERT INTO orders (order_id, customer_id, order_date) VALUES
    (1, 1, '2024-03-01'),
    (2, 2, '2024-03-05');

-- Inserção de dados na tabela products
INSERT INTO products (product_id, product_name, price) VALUES
    (1, 'Product A', 100),
    (2, 'Product B', 200),
    (3, 'Product C', 150);

-- Inserção de dados na tabela order_items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
    (1, 1, 2),
    (1, 3, 1),
    (2, 2, 3);

-- Inserção de dados na tabela customers
INSERT INTO customers (customer_name, email) VALUES
    ('Customer 1', 'customer1@example.com'),
    ('Customer 2', 'customer2@example.com');

-- Consultas de teste

-- a. Qual é o nome e o salário de todos os funcionários que têm um salário maior que $5000?
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 5000;

-- b. Qual é o nome do departamento e o número total de funcionários em cada departamento, ordenados pelo número total de funcionários em ordem decrescente?
SELECT d.department_name, COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY total_employees DESC;

-- c. Escreva uma consulta SQL para encontrar os clientes que não fizeram nenhum pedido.
SELECT c.customer_id, c.customer_name, c.email
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
