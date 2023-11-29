CODE: Using the Real-Time SQL Monitoring Tool
select * from sales s, customers c
where s.cust_id = c.cust_id and
channel_id = 9;
 
select /*+ monitor */* from sales s, customers c
where s.cust_id = c.cust_id and
channel_id = 9;
 
alter system flush shared_pool;
alter system flush buffer_cache;
 
SELECT /*+ PARALLEL(4) */ c.cust_first_name, c.cust_last_name, 
  MAX(QUANTITY_SOLD), AVG(QUANTITY_SOLD)
FROM sales s, customers c, countries ct, costs cs
WHERE s.cust_id = c.cust_id
and s.channel_id = :v_channel_id
and c.country_id = ct.country_id
--and cs.prod_id = s.prod_id
GROUP BY c.cust_first_name, c.cust_last_name
order by c.cust_first_name, c.cust_last_name;

-- ===================================================================================================================
-- ===================================================================================================================

--CODE: Using the Trace Files & TKPROF Utility
sqlplus / as sysdba;
 
alter session set tracefile_identifier= TUN;
 
alter session set sql_trace = true;
 
select * from hr.employees;
 
alter session set sql_trace = false;
 
select value from v$diag_info where name = ‘Diag Trace’;
 
cd c:\app\omr\diag\rdbms\orcl\orcl\trace
 
tkprof file_name.trc tun_ex.txt
 
/********************************************************************/
 
alter session set timed_statistics=true;
 
exec dbms_session.session_trace_enable(waits => true, binds => false);
 
select s.prod_id,p.prod_name,s.cust_id,c.cust_first_name 
from sh.sales s, sh.products p, sh.customers c
where s.prod_id = p.prod_id
and s.cust_id = c.cust_id
and s.amount_sold > 1500;
 
exec dbms_session.session_trace_disable;