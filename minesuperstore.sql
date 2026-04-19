Create Database sales_analysis;
use sales_analysis;
select *
from superstore
limit 10;
-- Total sales by Region
select  Region, Sum(Sales) as total_sales
from superstore 
group by region
order by total_sales desc; 

-- Case When implementation
select  Sales,
case
	when Sales>500 then "high Sale"
    when Sales>100 then "Medium sale"
    else "Low sale"
end as sale_category
from superstore;

select
case
	when Profit>50 then "High Profit"
    when Profit>0 then "Low Profit"
    else "Loss"
end as profit_category,
count(*) as number_of_orders
from superstore
group by profit_category;

select
case
	when Discount=0 then "No discount"
    when Discount=0.2 then "Low discount"
    else "High discount"
end as 'discount_category',
count(*) as orders
from superstore
group by discount_category;

-- understanding row_number(), partition by()
select *
from(
select
	Region, 
	Sales,
    row_number() over (partition by Region order by Sales desc) as rn
from superstore
) t
where rn <=2;

-- row_number() vs rank() vs dense_rank()

select
Region,
	Sales,
    row_number() over(partition by Region order by Sales desc) as row_num,
    rank() over (partition by Region order by Sales desc) as rank_val,
    dense_rank() over (partition by Region order by Sales desc) as dense_rank_val
from superstore
where Region ='West';

-- category profit
select Category, sum(Profit)
from superstore
group by Category; 

-- discount impact on profit
select Discount, avg(Profit)
from superstore
group by Discount;

-- region profit
select Region, sum(Profit)
from superstore
group by Region
order by sum(Profit);

-- top products sales wise
SELECT *
FROM (
    SELECT 
        `Sub-Category`,
        SUM(Sales) AS total_sales,
        ROW_NUMBER() OVER (ORDER BY SUM(Sales) DESC) AS rn
    FROM superstore
    GROUP BY `Sub-Category`
) t
WHERE rn <= 5;

-- discount impacct on each region's profit
SELECT 
    Region,
    AVG(Discount) AS avg_discount,
    AVG(Profit) AS avg_profit,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY Region
ORDER BY avg_discount DESC;




