-- Firstly, calculate total monthly sales for each branch
WITH monthly_sales AS (
SELECT branch, 
DATE_FORMAT(STR_TO_DATE(date, '%d-%m-%Y'), '%m-%Y') AS month, 
SUM(total) AS total_sales
FROM walmartsales       
GROUP BY branch, month),
-- Now, calculate monthly growth rate for each branch
growth_rate AS (
SELECT branch, month, total_sales,
LAG(total_sales) OVER (PARTITION BY branch ORDER BY month) AS prev_month_sales,
((total_sales - LAG(total_sales) OVER (PARTITION BY branch ORDER BY month)) / 
LAG(total_sales) OVER (PARTITION BY branch ORDER BY month)) * 100 AS growth_rate
FROM monthly_sales)
-- Now, find the branch with the highest month-to-month growth rate
SELECT branch, 
MAX(growth_rate) AS max_growth_rate
FROM growth_rate
WHERE growth_rate IS NOT NULL
GROUP BY branch
ORDER BY max_growth_rate DESC
LIMIT 1;
