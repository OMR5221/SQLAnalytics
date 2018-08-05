-- CUBE: similar to ROLLUP, enabling a single statement to calculate all possible combinations of aggregations. 
-- CUBE can generate the information needed in cross-tabulation reports with a single query.
-- Good for representing a cross tabular reports




SELECT channel_desc,  country_id,
   TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES$ 
FROM sales, customers, times, channels 
WHERE sales.time_id=times.time_id AND
   sales.cust_id=customers.cust_id AND
   sales.channel_id= channels.channel_id AND 
   channels.channel_desc IN ('Direct Sales', 'Internet') AND 
   times.calendar_month_desc='2000-09'
   AND country_id IN ('UK', 'US')
GROUP BY CUBE(channel_desc, country_id);


/*

-- output:

CHANNEL_DESC         CO SALES$
-------------------- -- --------------
Direct Sales         UK      1,378,126
Direct Sales         US      2,835,557
Direct Sales                 4,213,683
----------------------------------------
Internet             UK        911,739
Internet             US      1,732,240
Internet                     2,643,979
----------------------------------------
                     UK      2,289,865
                     US      4,567,797
                             6,857,662

*/


-- CUBE is typically most suitable in queries that use columns from multiple dimensions 
-- rather than columns representing different levels of a single dimension.
-- ex: need subtotals for all the combinations of month, state, and product


SELECT channel_desc, calendar_month_desc, country_id, 
   TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES$ 
FROM sales, customers, times, channels 
WHERE sales.time_id=times.time_id AND
   sales.cust_id=customers.cust_id AND
   sales.channel_id= channels.channel_id AND 
   channels.channel_desc IN ('Direct Sales', 'Internet') AND 
   times.calendar_month_desc IN ('2000-09', '2000-10')
   AND country_id IN ('UK', 'US')
GROUP BY CUBE(channel_desc, calendar_month_desc, country_id);


/*
CHANNEL_DESC         CALENDAR CO SALES$
-------------------- -------- -- --------------
Direct Sales         2000-09  UK      1,378,126
Direct Sales         2000-09  US      2,835,557
Direct Sales         2000-09          4,213,683
Direct Sales         2000-10  UK      1,388,051
Direct Sales         2000-10  US      2,908,706
Direct Sales         2000-10          4,296,757
Direct Sales                  UK      2,766,177
Direct Sales                  US      5,744,263
Direct Sales                          8,510,440
Internet             2000-09  UK        911,739
Internet             2000-09  US      1,732,240
Internet             2000-09          2,643,979
Internet             2000-10  UK        876,571
Internet             2000-10  US      1,893,753
Internet             2000-10          2,770,324
Internet                      UK      1,788,310
Internet                      US      3,625,993
Internet                              5,414,303
					  2000-09  UK      2,289,865
					  2000-09  US      4,567,797
					  2000-09          6,857,662
					  2000-10  UK      2,264,622
					  2000-10  US      4,802,459
					  2000-10          7,067,081
							   UK      4,554,487
							   US      9,370,256
									  13,924,743	
	*/