-- find the top 10 highest revenue generating products
select product_id,sum(sale_price) as sales
from df_orders
group by product_id
order by sales desc limit 10;

-- find top 5 highest selling product in each region
with cte as( 
select region,product_id,sum(sale_price) as sales
from df_orders
group by region,product_id)
select * from(
select *,
row_number() over (partition by region order by sales desc) as rn
from cte) A
where rn <= 5;

-- find month over month growth comparison for 2022 and 2023 sales eg. Jan 2022 vs Jan 2023
with cte as(
select 
year(order_date) as order_year,
month(order_date) as order_month,
sum(sale_price) as sales
from df_orders
group by year(order_date), month(order_date)
)
select order_month,
sum(case when order_year=2022 then sales else 0 end) as sales_2022,
sum(case when order_year=2023 then sales else 0 end) as sales_2023
from cte
group by order_month
order by order_month;

-- for each category which month had highest sale
with cte as(
select category,
date_format(order_date,'%Y%m') as order_year_month,
sum(sale_price) as sales
from df_orders
group by category, date_format(order_date,'%Y%m')
)
select * from(
select *,
rank() over(partition by category order by sales desc) as rn
from cte) A
where rn=1;

-- which sub category had highest growth by profit in 2023 compared to 2022
with cte as(
select
sub_category, 
year(order_date) as order_year,
sum(sale_price) as sales
from df_orders
group by sub_category, year(order_date)
),
cte2 as(
select sub_category,
sum(case when order_year=2022 then sales else 0 end) as sales_2022,
sum(case when order_year=2023 then sales else 0 end) as sales_2023
from cte
group by sub_category)
select *,
(sales_2023-sales_2022)*100/sales_2022 as growth_percentage
from  cte2
order by growth_percentage desc limit 1;