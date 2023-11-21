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

















