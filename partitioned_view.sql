-- Create a view:
CREATE OR REPALCE VIEW acct_payable AS
SELECT * FROM acct_pay_jan99
UNION_ALL
SELECT * FROM acct_pay_feb99
UNION_ALL
SELECT * FROM acct_pay_mar99
UNION_ALL
SELECT * FROM acct_pay_apr99
UNION_ALL
SELECT * FROM acct_pay_may99
UNION_ALL
SELECT * FROM acct_pay_jun99
UNION_ALL
SELECT * FROM acct_pay_jul99
UNION_ALL
SELECT * FROM acct_pay_aug99
UNION_ALL
SELECT * FROM acct_pay_sep99
UNION_ALL
SELECT * FROM acct_pay_oct99
UNION_ALL
SELECT * FROM acct_pay_nov99
UNION_ALL
SELECT * FROM acct_pay_dec99;



-- Created / Alter parallel query 
-- 
CREATE TABLE table_name (column_list)
Storage_options
Table_optins
NOPARALLEL|PARALLEL(DEGREE n|DEFAULT)


-- Partition by range:
/*
 results in a partitioned table that can be treated as a single table for all inserts, updates and deletes or, if desired, the individual partitions can be addressed.
 In addition the indexes created will be by default local indexes that are automatically partitioned the same way as the base table. 
 Be sure to specify tablespaces for the index partitions or they will be placed with the table partitions. 
*/

CREATE TABLE acct_pay_99 (acct_no NUMBER, acct_bill_amt NUMBER, bill_date DATE, paid_date DATE, penalty_amount NUMBER, chk_number NUMBER)
STORAGE (INITIAL 40K NEXT 40K PCTINCREASE 0)
PARTITION BY RANGE (paid_date)
(
PARTITION acct_pay_jan99
   VALUES LESS THAN (TO_DATE('01-feb-1999','DD-mon-YYYY'))
   TABLESPACE acct_pay1,
PARTITION acct_pay_feb99
   VALUES LESS THAN (TO_DATE('01-mar-1999','DD-mon-YYYY'))
   TABLESPACE acct_pay1,
PARTITION acct_pay_mar99
   VALUES LESS THAN (TO_DATE('01-apr-1999','DD-mon-YYYY'))
   TABLESPACE acct_pay1,
PARTITION acct_pay_apr99
   VALUES LESS THAN (TO_DATE('01-may-1999','DD-mon-YYYY'))
   TABLESPACE acct_pay1,
PARTITION acct_pay_may99
   VALUES LESS THAN (TO_DATE('01-jun-1999','DD-mon-YYYY'))
   TABLESPACE acct_pay1,
PARTITION acct_pay_jun99
   VALUES LESS THAN (TO_DATE('01-jul-1999','DD-mon-YYYY'))
   TABLESPACE acct_pay1,
PARTITION acct_pay_jul99
   VALUES LESS THAN (TO_DATE('01-aug-1999','DD-mon-YYYY'))
   TABLESPACE acct_pay1,
PARTITION acct_pay_aug99
   VALUES LESS THAN (TO_DATE('01-sep-1999','DD-mon-YYYY'))
   TABLESPACE acct_pay1,
PARTITION acct_pay_sep99
   VALUES LESS THAN (TO_DATE('01-oct-1999','DD-mon-YYYY'))
   TABLESPACE acct_pay1,
PARTITION acct_pay_oct99
   VALUES LESS THAN (TO_DATE('01-nov-1999','DD-mon-YYYY'))
   TABLESPACE acct_pay1,
PARTITION acct_pay_nov99
   VALUES LESS THAN (TO_DATE('01-dec-1999','DD-mon-YYYY'))
   TABLESPACE acct_pay11,
PARTITION acct_pay_dec99
   VALUES LESS THAN (TO_DATE('01-jan-2000','DD-mon-YYYY'))
   TABLESPACE acct_pay12,
PARTITION acct_pay_2000
   VALUES LESS THAN (MAXVALUE))
   TABLESPACE acct_pay_max
/