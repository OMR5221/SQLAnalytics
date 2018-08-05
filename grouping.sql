-- GROUPING: Using a single column as its argument, GROUPING returns 1 when it encounters a NULL value created by a ROLLUP or CUBE operation
-- if the NULL indicates the row is a subtotal, GROUPING returns a 1


SELECT channel_desc, calendar_month_desc, country_id, 
   TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES$,    
   GROUPING(channel_desc) as Ch,
   GROUPING(calendar_month_desc) AS Mo,
   GROUPING(country_id) AS Co 
FROM sales, customers, times, channels 
WHERE sales.time_id=times.time_id AND
   sales.cust_id=customers.cust_id AND
   sales.channel_id= channels.channel_id AND 
   channels.channel_desc IN ('Direct Sales', 'Internet') AND 
   times.calendar_month_desc IN ('2000-09', '2000-10')
   AND country_id IN ('UK', 'US')
GROUP BY ROLLUP(channel_desc, calendar_month_desc, country_id);


/*
CHANNEL_DESC         CALENDAR CO SALES$                CH        MO        CO
-------------------- -------- -- -------------- --------- --------- ---------
Direct Sales         2000-09  UK      1,378,126         0         0         0
Direct Sales         2000-09  US      2,835,557         0         0         0
Direct Sales         2000-09          4,213,683         0         0         1
Direct Sales         2000-10  UK      1,388,051         0         0         0
Direct Sales         2000-10  US      2,908,706         0         0         0
Direct Sales         2000-10          4,296,757         0         0         1
Direct Sales                          8,510,440         0         1         1
Internet             2000-09  UK        911,739         0         0         0
Internet             2000-09  US      1,732,240         0         0         0
Internet             2000-09          2,643,979         0         0         1
Internet             2000-10  UK        876,571         0         0         0
Internet             2000-10  US      1,893,753         0         0         0
Internet             2000-10          2,770,324         0         0         1
Internet                              5,414,303         0         1         1
                                     13,924,743         1         1         1
									 
									 */