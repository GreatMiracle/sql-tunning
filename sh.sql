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

--
EXPLAIN PLAN FOR SELECT * FROM EMPLOYEES;
EXPLAIN PLAN FOR SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID= 100;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID= 100;
EXPLAIN PLAN SET statement_id = 'MyID' FOR SELECT * FROM employees WHERE employee_id= 100;
SELECT * FROM PLAN_TABLE;

--
set autotrace traceonly explain;
select * from sales s, customers c  where s.CUST_ID = c.cust_id and s.cust_id = 987;
set linesize 200;
set autotrace traceonly statistics;
set autotrace traceonly;
set autotrace on;
show autotrace;
Set autotrace off;
select * from v$mystat;

--

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

--
 SELECT /* my query */ p.prod_id,p.prod_name, s.amount_sold, s.quantity_sold
  FROM sales s, products p
  WHERE s.prod_id = p.prod_id
  and p.prod_id = 13;
 
select * from v$sql where sql_text like '%my query%';
 
select * from table(dbms_xplan.display_cursor(''));

--
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
