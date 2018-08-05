-- rollup so that only some of the sub-totals will be included.

/*
GROUP BY expr1, ROLLUP(expr2, expr3);
*/


SELECT channel_desc, calendar_month_desc, country_id,
   TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES$
FROM sales, customers, times, channels 
WHERE sales.time_id=times.time_id AND
   sales.cust_id=customers.cust_id AND
   sales.channel_id= channels.channel_id AND 
   channels.channel_desc IN ('Direct Sales', 'Internet') AND 
   times.calendar_month_desc IN ('2000-09', '2000-10')
   AND country_id IN ('UK', 'US')
GROUP BY channel_desc, ROLLUP(calendar_month_desc, country_id);


/*
CHANNEL_DESC         CALENDAR CO SALES$
-------------------- -------- -- --------------
Direct Sales         2000-09  UK      1,378,126
Direct Sales         2000-09  US      2,835,557
Direct Sales         2000-09          4,213,683
------------------------------------------------
Direct Sales         2000-10  UK      1,388,051
Direct Sales         2000-10  US      2,908,706
Direct Sales         2000-10          4,296,757
------------------------------------------------
Direct Sales                          8,510,440
------------------------------------------------
Internet             2000-09  UK        911,739
Internet             2000-09  US      1,732,240
Internet             2000-09          2,643,979
------------------------------------------------
Internet             2000-10  UK        876,571
Internet             2000-10  US      1,893,753
Internet             2000-10          2,770,324
------------------------------------------------
Internet                              5,414,303
-------------------------------------------------
-- Does not include grand total of all fields by channel_desc
*/