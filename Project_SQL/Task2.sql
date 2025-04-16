-- Task 1: Identifying the Top Branch by Sales Growth Rate
-- firstly calculate total sales and COGS for each product line in each branch
with product_line_sales as(
select 'product line', branch, SUM(total) as total_sales,
 SUM(cogs) as total_cogs
 from walmartsales
 group by branch, 'product line'),
 -- now calculate for profit for each product line 
 profit_margin as (
 select branch 'product line', (total_sales - total_cogs) as profit 
 from product_line_sales),
 
 -- now assign rank based on profit for each branch 
 ranked_product_lines as (
 select branch, 'product line', profit,
 row_number() over (partition by branch order by profit desc)as ranked
 from profit_margin)
 
 -- now select the most profitable product line by each branch 
 select branch, 'product line', profit as highest_profit
 from ranked_product_lines
 where ranked =1
 order by highest_profit desc;