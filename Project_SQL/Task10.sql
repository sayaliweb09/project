-- Task 10: Analyzing Sales Trends by Day of the Week
WITH daily_sales AS (
    SELECT 
        DAYNAME(STR_TO_DATE(date, '%d-%m-%Y')) AS day_of_week,
        SUM(total) AS total_sales
    FROM walmartsales 
    GROUP BY day_of_week
)
SELECT day_of_week, total_sales 
FROM daily_sales
ORDER BY total_sales DESC;

 
