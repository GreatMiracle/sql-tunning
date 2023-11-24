SELECT * FROM employees where employee_id > 190 order by email;
 
-- Order by with the indexed column - no sort is processed
SELECT * FROM employees where employee_id > 190 order by employee_id desc;
 
-- Index range scan descending
SELECT * FROM employees where department_id > 80 order by department_id desc;

SELECT * FROM PRODUCTS WHERE PROD_SUBCATEGORY LIKE 'Accessories%';
SELECT * FROM PRODUCTS WHERE PROD_SUBCATEGORY LIKE '%Accessories';
SELECT * FROM PRODUCTS WHERE PROD_SUBCATEGORY LIKE '%Accessories%';


select * from v$sql order by last_load_time desc


SELECT * FROM departments ORDER BY department_id;

SELECT last_name,first_name FROM employees ORDER BY last_name;

SELECT first_name, last_name FROM employees ORDER BY first_name,last_name;

SELECT last_name,first_name FROM employees ORDER BY last_name,first_name;

SELECT last_name,first_name FROM employees ORDER BY last_name,salary;

SELECT * FROM employees ORDER BY last_name,first_name;


SELECT salary,count(*) FROM employees e
WHERE salary IS NOT NULL
GROUP BY salary;


SELECT department_id,count(*) FROM employees e
WHERE department_id IS NOT NULL
GROUP BY department_id;


SELECT department_id,manager_id,count(*) FROM employees e
WHERE department_id IS NOT NULL
GROUP BY department_id, manager_id;

SELECT e.employee_id, e.last_name, e.first_name, e.department_id,
d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id;

SELECT e.employee_id, d.department_id, e.first_name,
       d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id;


SELECT e.employee_id, d.department_id,
       d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id;


