Internship Task: Audit Table Changes


1) Create database
CREATE DATABASE IF NOT EXISTS internship_audit;
USE internship_audit;

2) Create main table: employees

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    email VARCHAR(150) UNIQUE,
    salary DECIMAL(10,2),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

3) Create audit table: audit_log

CREATE TABLE audit_log (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(128) NOT NULL,
    operation VARCHAR(10) NOT NULL,
    row_id VARCHAR(255),
    performed_by VARCHAR(255),
    performed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    old_row JSON,
    new_row JSON
);

4a) Trigger: AFTER INSERT
DELIMITER $$

CREATE TRIGGER employees_after_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
  INSERT INTO audit_log (
    table_name,
    operation,
    row_id,
    performed_by,
    performed_at,
    old_row,
    new_row
  )
  VALUES (
    'employees',
    'INSERT',
    NEW.emp_id,
    CURRENT_USER(),
    NOW(),
    NULL,
    JSON_OBJECT(
      'emp_id', NEW.emp_id,
      'first_name', NEW.first_name,
      'last_name', NEW.last_name,
      'email', NEW.email,
      'salary', NEW.salary,
      'updated_at', NEW.updated_at
    )
  );
END$$

DELIMITER ;

4b) Trigger: AFTER UPDATE
DELIMITER $$

CREATE TRIGGER employees_after_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
  INSERT INTO audit_log (
    table_name,
    operation,
    row_id,
    performed_by,
    performed_at,
    old_row,
    new_row
  )
  VALUES (
    'employees',
    'UPDATE',
    NEW.emp_id,
    CURRENT_USER(),
    NOW(),
    JSON_OBJECT(
      'emp_id', OLD.emp_id,
      'first_name', OLD.first_name,
      'last_name', OLD.last_name,
      'email', OLD.email,
      'salary', OLD.salary,
      'updated_at', OLD.updated_at
    ),
    JSON_OBJECT(
      'emp_id', NEW.emp_id,
      'first_name', NEW.first_name,
      'last_name', NEW.last_name,
      'email', NEW.email,
      'salary', NEW.salary,
      'updated_at', NEW.updated_at
    )
  );
END$$

DELIMITER ;

4c) Trigger: AFTER DELETE
DELIMITER $$

CREATE TRIGGER employees_after_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
  INSERT INTO audit_log (
    table_name,
    operation,
    row_id,
    performed_by,
    performed_at,
    old_row,
    new_row
  )
  VALUES (
    'employees',
    'DELETE',
    OLD.emp_id,
    CURRENT_USER(),
    NOW(),
    JSON_OBJECT(
      'emp_id', OLD.emp_id,
      'first_name', OLD.first_name,
      'last_name', OLD.last_name,
      'email', OLD.email,
      'salary', OLD.salary,
      'updated_at', OLD.updated_at
    ),
    NULL
  );
END$$

DELIMITER ;

5) Sample data for testing

INSERT INTO employees (first_name, last_name, email, salary) VALUES ('Test', 'User', 'test@example.com', 20000);
UPDATE employees SET salary = 25000 WHERE emp_id = 1;
DELETE FROM employees WHERE emp_id = 1;
SELECT * FROM audit_log;

