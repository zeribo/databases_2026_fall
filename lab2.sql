CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);


SELECT * FROM departments;

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    salary NUMERIC(12, 2),
    dept_id INT REFERENCES departments(dept_id)
);

SELECT * FROM employees;

ALTER TABLE employees
ADD COLUMN email VARCHAR(100) UNIQUE;

SELECT email from employees;


ALTER TABLE employees
RENAME COLUMN  email TO work_email;

ALTER TABLE employees
ALTER COLUMN work_email TYPE text,
ALTER COLUMN work_email SET DEFAULT 'UNKNOWN';

select work_email FROM employees;


ALTER TABLE employees
DROP COLUMN work_email,
ADD CONSTRAINT salary_big CHECK (salary > 0),
ALTER COLUMN salary SET NOT NULL;


ALTER TABLE employees
ALTER COLUMN salary DROP NOT NULL;

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL UNIQUE,
    budget NUMERIC(12,2) CHECK (budget > 1000)
);


CREATE TABLE employee_projects (
    emp_id INT REFERENCES employees(emp_id) ON DELETE CASCADE,
    project_id INT REFERENCES projects(project_id) ON DELETE CASCADE,
    PRIMARY KEY (emp_id, project_id)
);

ALTER TABLE employees
ADD CONSTRAINT unique_employee UNIQUE (first_name, last_name, dept_id);

CREATE INDEX idx_employees_last_name
ON employees(last_name);

INSERT INTO departments(dept_name)
VALUES ('IT'), ('HR'), ('Finance');


INSERT INTO employees (first_name, last_name, salary, dept_id)
VALUES
    ('Aibek',      'Nurlanuly',   1200.00, 1),
    ('Dana',       'Serikkyzy',   1850.50, 2),
    ('Erlan',      'Zhaksybekov',  950.75, 3),
    ('Aigerim',    'Bekova',      2200.00, 1),
    ('Nursultan',  'Abenov',      1650.25, 2);


UPDATE employees
SET salary = salary * 1.1
WHERE dept_id = 1;

SELECT * FROM employees
ORDER BY salary DESC;

DELETE FROM employees
WHERE (salary < 1000);



CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    "timestamp" TIMESTAMP NOT NULL,
    delivery_address TEXT NOT NULL
);

CREATE TABLE products (
    id VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE,
    description TEXT,
    price DOUBLE PRECISION NOT NULL,
    CONSTRAINT price_positive CHECK (price > 0)
);


CREATE TABLE orders (
    code SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id) ON DELETE CASCADE,
    total_sum DOUBLE PRECISION NOT NULL,
    is_paid BOOLEAN NOT NULL,
    CONSTRAINT total_sum_positive CHECK (total_sum > 0)

);



CREATE TABLE order_items (
    order_code INTEGER NOT NULL REFERENCES orders(code),
    product_id VARCHAR NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL,
    PRIMARY KEY (order_code, product_id),
    CONSTRAINT quantity_positive CHECK (quantity > 0)
    );

