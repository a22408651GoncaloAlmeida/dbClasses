-- Gonçalo Almeida (a22408651) 25/09

USE ULHT_DB26;
GO

-- Part A

-- A1. Formal name
SELECT TOP 5
    employee_id,
    UPPER(last_name) + ', ' + LOWER(first_name) AS formal_name
FROM hr.employees;

-- A2. Email address
SELECT TOP 5
    employee_id,
    LEFT(LOWER(first_name), 1) + LOWER(REPLACE(last_name,' ', '')) + '@example.org' AS email_address
FROM HR.EMPLOYEES;

-- A3. Name length
SELECT TOP 5
    last_name,
    LEN(last_name) AS last_name_length
FROM HR.EMPLOYEES
ORDER BY 
    last_name_length DESC,
    last_name ASC;

-- A4. Quarterly and annual salary
SELECT TOP 5
    employee_id,
    salary,
    salary * 3 AS quarter_salary,
    salary * 14 AS annual_salary
FROM HR.EMPLOYEES

-- A5. Review date
SELECT TOP 5
    employee_id,
    hire_date,
    DATEADD(month, 6, hire_date) AS review_date
FROM HR.EMPLOYEES


-- Part B
-- B1. Employees with commission
SELECT 
    employee_id,
    commission_pct
FROM HR.EMPLOYEES
WHERE commission_pct IS NOT NULL;

-- B2. Commission amount
SELECT
    employee_id,
    salary,
    ISNULL(commission_pct, 0),
    salary * ISNULL(commission_pct, 0) AS commission_amount
FROM HR.EMPLOYEES

-- B3. Total annual compensation
SELECT TOP 5
    employee_id,
    (salary * 14) + (salary * ISNULL(commission_pct, 0) * 14) AS annual_total
FROM HR.EMPLOYEES
ORDER BY
    annual_total DESC;

-- B4. Manager label
SELECT TOP 5
    employee_id,
    ISNULL(CAST(manager_id AS VARCHAR), 'no manager') AS manager_label
FROM HR.EMPLOYEES;


-- Part C
-- C1. Department code
SELECT 
    employee_id,
    'DEPT-' + ISNULL(CAST(department_id AS VARCHAR), 'UNASSIGNED') AS department_code
FROM HR.EMPLOYEES;

-- C2. ISO hire date
SELECT 
    employee_id,
    CONVERT(VARCHAR(10), hire_date, 23) AS iso_hire_date
FROM HR.EMPLOYEES;

-- C3. Safe conversion audit
SELECT 
    employee_id,
    TRY_CAST(CAST(employee_id AS VARCHAR) AS INT) AS recovered_id
FROM HR.EMPLOYEES;


-- Part D
-- D1. Salary with two decimal places
SELECT 
    employee_id,
    salary,
    FORMAT(salary, 'C2', 'pt-PT') AS salary_display
FROM HR.EMPLOYEES;

-- D2. Readable hire date
SELECT 
    employee_id,
    hire_date,
    FORMAT(hire_date, 'dd MMMM yyyy') AS hire_date_display
FROM HR.EMPLOYEES;

-- D3. Padded employee reference
SELECT 
    employee_id,
    'HR-' + FORMAT(employee_id, '000000') AS employee_reference
FROM HR.EMPLOYEES;

-- D4. Final staff summary
SELECT TOP 5
    employee_id,
    UPPER(last_name) + ', ' + first_name AS full_name,
    CONVERT(VARCHAR(10), hire_date, 23) AS iso_hire_date,
    FORMAT((salary * 14) + (salary * ISNULL(commission_pct, 0) * 14), 'C2', 'pt-PT') AS annual_total_display,
    'HR-' + FORMAT(employee_id, '000000') AS employee_reference
FROM HR.EMPLOYEES
ORDER BY 
    (salary * 14) + (salary * ISNULL(commission_pct, 0) * 14) DESC,
    employee_id ASC;