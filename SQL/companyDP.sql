-- Create the departments table

CREATE TABLE departments (

department_id SERIAL PRIMARY KEY,

department_name VARCHAR(100) NOT NULL

);


-- Create the employees table

CREATE TABLE employees (

employee_id SERIAL PRIMARY KEY,

employee_name VARCHAR(100) NOT NULL,

salary NUMERIC(10, 2) NOT NULL,

department_id INT REFERENCES departments(department_id)

)


CREATE OR REPLACE PROCEDURE add_employee(

emp_name VARCHAR,

emp_salary NUMERIC,

dept_id INT

)

LANGUAGE plpgsql

AS $$

BEGIN

INSERT INTO employees (employee_name, salary, department_id)

VALUES (emp_name, emp_salary, dept_id);

RAISE NOTICE 'Employee % added successfully!', emp_name;

END;

$$;


INSERT INTO departments (department_name)VALUES ('dept1');


CALL add_employee('John Doe', 5000.00, 1);

