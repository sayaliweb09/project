-- Task 3: Analyzing Customer Segmentation Based on Spending
with customer_spending as (
select 'Invoice id', sum(total) as total spent, avg(total) as avg_spent from walmartsales
group by 'Invoice id'),

-- now Determine Spending Tiers based on Total Spending
total_spending_tiers as (
select 'Invoice id', total_spent, case
when total spent >= (select max(total_spent)v* 0.75 from customer_spending) then 'High'
when total spent >= (select max(total_spent) *0.50 from customer_spending) then 'Medium'
else 'Low'
end as total_spending tier from customer_spending),

-- now Determine Spending Tiers based on Average Spending
average_spending tiers as (
select 'Invoice id', avg spent, case
when avg spent >= (select max(avg_spent) 0.75 from customer_spending) then 'High'
when avg spent >= (select max(avg_spent) 8.50 from customer_spending) then 'Piedium"
else 'Low'
end as average_spending_tier from customer_spending)

-- lastly display results
select 'invoice id', total_spent, total_spending_tier, avg_spent, average_spending_tier
from total_spending_tiers join average_spending_tiers using ('Invoice id') order by total_spent desc, avg_spent desc);

