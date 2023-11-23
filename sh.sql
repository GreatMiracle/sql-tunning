--NOTE ALL 
--Generating Statistics (Code Samples)
exec dbms_stats.gather_system_stats('Start');
select * from sys.aux_stats$;
exec dbms_stats.gather_table_stats(ownname => 'SH', tabname => 'SALES', cascade=>true);
select * from dba_tab_statistics where table_name = 'SALES'; 
 
select * from sales;
select * from dba_tab_columns where table_name = 'SALES';
exec dbms_stats.gather_system_stats('NOWORKLOAD');
select * from sys.aux_stats$;
select * from v$sql_plan;
 
exec dbms_stats.gather_database_stats;
exec dbms_stats.gather_dictionary_stats;
exec dbms_stats.gather_schema_stats(ownname => 'SH');
exec dbms_stats.gather_table_stats(ownname => 'SH', tabname => 'SALES', cascade=>true);
select * from user_part_col_statistics;
select * from dba_tab_statistics where table_name = 'SALES';
 
select * from	DBA_TABLES; 
select * from	DBA_TAB_STATISTICS;
select * from   DBA_TAB_COL_STATISTICS; 
select * from	DBA_INDEXES; 
select * from	DBA_CLUSTERS; 
select * from	DBA_TAB_PARTITIONS; 
select * from	DBA_IND_PARTITIONS; 
select * from	DBA_PART_COL_STATISTICS;

-- Generating Execution Plan (Code Samples)
EXPLAIN PLAN FOR SELECT * FROM EMPLOYEES;
EXPLAIN PLAN FOR SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID= 100;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID= 100;
EXPLAIN PLAN SET statement_id = 'MyID' FOR SELECT * FROM employees WHERE employee_id= 100;
SELECT * FROM PLAN_TABLE;

-- Autotrace (Code Samples)
set autotrace traceonly explain;
select * from sales s, customers c  where s.CUST_ID = c.cust_id and s.cust_id = 987;
set linesize 200;
set autotrace traceonly statistics;
set autotrace traceonly;
set autotrace on;
show autotrace;
Set autotrace off;
select * from v$mystat;

-- V$SQL_PLAN (Code Samples)
SELECT * FROM v$sqlarea;
SELECT * FROM v$sqlstats;
SELECT * FROM v$sql;
SELECT * FROM v$sql_plan;
SELECT * FROM v$sql_workarea;
SELECT * FROM v$sql_plan_statistics;
SELECT * FROM v$sql_plan_statistics_all;
 
 SELECT s.prod_id
  FROM sales s, customers c
  WHERE s.cust_id = c.cust_id;
 
select * from v$sql;
select * from v$sql where sql_text like '%SELECT s.prod_id 
                                           FROM sales s, customers c 
                                           WHERE s.cust_id = c.cust_id%';
select * from v$sql where sql_text like '%SELECT s.prod_id FROM sales s, customers c WHERE s.cust_id = c.cust_id%';
 
 SELECT /* my query */ s.prod_id
  FROM sales s, customers c
  WHERE s.cust_id = c.cust_id;
 
select * from v$sql where sql_text like '%my query%';
select * from v$sql_plan where sql_id = '';
select * from table(dbms_xplan.display_cursor(''));

-- Reading the Execution Plans (Code Samples)
 SELECT /* my query */ p.prod_id,p.prod_name, s.amount_sold, s.quantity_sold
  FROM sales s, products p
  WHERE s.prod_id = p.prod_id
  and p.prod_id = 13;
 
select * from v$sql where sql_text like '%my query%';
 
select * from table(dbms_xplan.display_cursor(''));

-- Analyzing the Execution Plans (Code Samples)
explain plan for
  SELECT p.prod_id,p.prod_name, s.amount_sold, s.quantity_sold
  FROM sales s, products p, customers c
  WHERE s.prod_id = p.prod_id
  and s.CUST_ID = c.CUST_ID
  and s.cust_id in (2,3,4,5);
 
select * from table(dbms_xplan.display());
 
explain plan for  
SELECT p.prod_id,p.prod_name, s.amount_sold, s.quantity_sold
  FROM sales s, products p, customers c
  WHERE s.prod_id = p.prod_id
  and s.CUST_ID = c.CUST_ID
  and s.cust_id between 2 and 5;
 
select * from table(dbms_xplan.display());

-- table access full code sampple
select * from sales;
select * from sales where amount_sold > 1770;
select * from employees where employee_id > 100;
 
explain plan for
select * from employees e, departments d
where e.employee_id = d.manager_id;
select * from table (dbms_xplan.display());
 
explain plan for
select * from employees e, departments d
where e.department_id = d.department_id;
select * from table (dbms_xplan.display());

--Table Access by ROWID (Code Samples)
select * from sales where prod_id = 116 and cust_id = 100090;
select * from sales where rowid = 'your_row_id';
create index prod_cust_ix on sales (prod_id,cust_id);
select prod_id,cust_id from sales where prod_id = 116;
drop index prod_cust_ix;

-- ===================================================================================================================
-- ===================================================================================================================

--Index Range Scan (Code Samples)
-- One side bounded searched
SELECT * FROM SALES WHERE time_id > to_date('01-NOV-01','DD-MON-RR');
 
-- Bounded by both sides
SELECT * FROM SALES WHERE time_id between to_date('01-NOV-00','DD-MON-RR') and to_date('05-NOV-00','DD-MON-RR'); 
 
-- B-Tree index range scan
SELECT * FROM employees where employee_id > 190;
 
-- Index range scan on Non-Unique Index
SELECT * FROM employees where department_id > 80;
 
-- Order by with the indexed column -  sort is processed
SELECT * FROM employees where employee_id > 190 order by email;
 
-- Order by with the indexed column - no sort is processed
SELECT * FROM employees where employee_id > 190 order by employee_id;
 
-- Index range scan descending
SELECT * FROM employees where department_id > 80 order by department_id desc;
 
-- Index range scan with wildcard
SELECT * FROM PRODUCTS WHERE PROD_SUBCATEGORY LIKE 'Accessories%';
SELECT * FROM PRODUCTS WHERE PROD_SUBCATEGORY LIKE '%Accessories';
SELECT * FROM PRODUCTS WHERE PROD_SUBCATEGORY LIKE '%Accessories%';

-- ===================================================================================================================
-- ===================================================================================================================

--Index Full Scan (Code Samples)
/* Index usage with order by */
SELECT * FROM departments ORDER BY department_id;
 
/* Index usage with order by, one column of an index - causes index full scan*/
SELECT last_name,first_name FROM employees ORDER BY last_name;
 
/* Index usage with order by, one column of an index - causes unnecessary sort operation*/
SELECT last_name,first_name FROM employees ORDER BY first_name;
 
/* Index usage with order by, but with wrong order - causes unnecessary sort operation */
SELECT last_name,first_name FROM employees ORDER BY first_name,last_name;
 
/* Index usage with order by, with right order of the index - there is no unncessary sort */
SELECT last_name,first_name FROM employees ORDER BY last_name,first_name;
 
/* Index usage with order by, wit unindexed column - there is no unncessary sort */
SELECT last_name,first_name FROM employees ORDER BY last_name,salary;
 
/* Index usage order by - when use * , it performed full table scan */
SELECT * FROM employees ORDER BY last_name,first_name;
 
/* Index usage with group by - using a column with no index leads a full table scan */
SELECT salary,count(*) FROM employees e 
WHERE salary IS NOT NULL
GROUP BY salary;
 
/* Index usage with group by - using indexed columns may lead to a index full scan */
SELECT department_id,count(*) FROM employees e 
WHERE department_id IS NOT NULL
GROUP BY department_id;
 
/* Index usage with group by - using more columns than ONE index has may prevent index full scan */ 
SELECT department_id,manager_id,count(*) FROM employees e 
WHERE department_id IS NOT NULL
GROUP BY department_id, manager_id;
 
/* Index usage with merge join */
SELECT e.employee_id, e.last_name, e.first_name, e.department_id, 
       d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id;

-- ===================================================================================================================
-- ===================================================================================================================

--Index Fast Full Scan (Code Samples)
/* Index Fast Full Scan Usage - Adding a different column 
    than index has will prevent the Index Fast Full Scan */
SELECT e.employee_id, d.department_id, e.first_name,
       d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id;
 
/* If all the columns are in the index, it may perform
   an Index Fast Full Scan */
SELECT e.employee_id, d.department_id,
       d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id;
 
/*Index Fast Full Scan can be applied to b-tree indexes, too 
  Even if there is an order by here, it used IFF Scan */
SELECT prod_id from sales order by prod_id;
 
/* Optimizer thinks Index Full Scan is better here*/
SELECT time_id from sales order by time_id;
 
/* Optimizer uses inded Fast Full Scan*/
SELECT time_id from sales;


-- ===================================================================================================================
-- ===================================================================================================================

--Index Skip Scan (Code Samples)
/*Index skip scan usage with equality operator*/
SELECT * FROM employees WHERE first_name = 'Alex';
 
/* Index range scan occurs if we use the first column of the index */
SELECT * FROM employees WHERE last_name = 'King';
 
/* Using index skip scan with adding a new index */
SELECT * FROM employees WHERE salary BETWEEN 6000 AND 7000;
CREATE INDEX dept_sal_ix ON employees (department_id,salary);
DROP INDEX dept_sal_ix;
 
/* Using index skip scan with adding a new index
   This time the cost increases significantly */
ALTER INDEX customers_yob_bix invisible;
SELECT * FROM customers WHERE cust_year_of_birth BETWEEN 1989 AND 1990;
CREATE INDEX customers_gen_dob_ix ON customers (cust_gender,cust_year_of_birth);
DROP INDEX customers_gen_dob_ix;
ALTER INDEX customers_yob_bix visible;


-- ===================================================================================================================
-- ===================================================================================================================

--Index Join Scan (Code Samples)
/* Index join scan with two indexes */
SELECT employee_id,email FROM employees;
 
/* Index join scan with two indexes, but with range scan included*/
SELECT last_name,email FROM employees WHERE last_name LIKE 'B%';
 
/* Index join scan is not performed when we add rowid to the select clause */
SELECT rowid,employee_id,email FROM employees;

