-- Normal Table Creation:

CREATE VIEW all_customer AS
   SELECT * FROM PHOENIX_CUSTOMER@phoenix
   UNION ALL
   SELECT * FROM LOS_ANGELES_CUSTOMER@los_angeles
   UNION ALL
   SELECT * FROM ROCHESTER_CUSTOMER@rochester;
   
-- Paralleled:

CREATE TABLE REGION_SALESPERSON_SUMMARY_03_97
-- Designate the number of parallel processes to compute the aggreation (5)
-- makes 5 processes open to read blocks from the fact table
-- and 5 query servers to populate the new summary table:
PARALLEL (degree 5)
AS
SELECT region, salesperson, sum(sale_amount)
FROM FACT
WHERE
   month = 3
AND
   year = 1997; 
   
   
 -- DATA Warehouses normally delete indexes:
 --can use parallel processes to recreate the indexes:
ALTER INDEX customer_pk
REBUILD PARALLEL 10;


-- We can specify the upper liit on the number of simultaneous processes:
SELECT /*+ FULL(employee_table) PARALLEL(employee_table, 4) */
   employee_name
   FROM

   WHERE
   emp_type = 'SALARIED';
   
 
-- Can also leave it up to each Oracle instance to use its default degree of parallelism, as follows:

SELECT /*+ FULL(employee_table) PARALLEL(employee_table, DEFAULT, DEFAULT) */
   employee_name
   FROM
   employee_table
   WHERE
   emp_type = 'SALARIED';
   
-- see how many parallel query servers are busy at any given time
 SELECT * FROM V$PQ_SYSSTAT
     WHERE STATISTIC = 'Servers Busy';

   