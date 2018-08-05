-- Use SELF JOIN of the detail tables to compare year 91 vs 92 sales 
-- where sales have dropped by more than 5% between 1991 and 1992:
-- by city/zip
SELECT INTEGER
(((E.NUMBER_OF_SALES - S.NUMBER_OF_SALES) / S.NUMBER_OF_SALES) * 100) ,
E.CUSTOMER_NAME , E.CITY_NAME , E.ZIP , S.NUMBER_OF_SALES , E.NUMBER_OF_SALES

FROM DETAIL S , DETAIL E

WHERE
S.CUSTOMER_NAME = E.CUSTOMER_NAME
 AND
E.STATE_ABBR = 'CA'
 AND
substr(E.DATE_YYMM,1,2) = "91"
 AND
substr(S.DATE_YYMM,1,2) = "92"
 AND
 -- 1992 sales < 1991  sales  - reduced by 5%
E.NUMBER_OF_SALES < S.NUMBER_OF_SALES - (.05 * S.NUMBER_OF_SALES)

ORDER BY E.ZIP ASC , E.CITY_NAME ASC , 1 ;


-- Dsiplay % variance where usage of product has declined by greater than 5%
-- between Oct 1990 compared to Dec 1990:

SELECT INTEGER
(((E.NUMBER_OF_SALES - S.NUMBER_OF_SALES) / S.NUMBER_OF_SALES) * 100) ,
E.CUSTOMER_NAME , E.CITY_NAME , E.ZIP , S.NUMBER_OF_SALES , E.NUMBER_OF_SALES


FROM DETAIL S , DETAIL E

WHERE
S.CUSTOMER_NAME = E.CUSTOMER_NAME
 AND
E.STATE_ABBR = 'CA'
 AND
E.DATE_YYMM = 9101
 AND
S.DATE_YYMM= 9201
 AND
E.NUMBER_OF_SALES < S.NUMBER_OF_SALES - (.05 * S.NUMBER_OF_SALES)

ORDER BY E.ZIP ASC , E.CITY_NAME ASC , 1 ;


-- 1.     Write an SQL query to display the cust_name for all customers 
-- who have had a transaction of more than $5,000 at the Boston branch.

SELECT S.CUSTOMER_NAME
FROM DETAIL S 
GROUP BY S.CUSTOMER_NAME
HAVING