create table df_orders(
order_id int primary key,
order_date date,
ship_mode varchar(50),
segment varchar(20),
country varchar(50),
city varchar(50),
state varchar(50),
postal_code varchar(50),
region varchar(50),
category varchar(50),
sub_category varchar(50),
product_id varchar(50),
cost_price int,
list_price int,
quantity int,
discount_percent int,
discount decimal(7,2),
sale_price decimal(7,2),
profit decimal(7,2)
);

select *
from df_orders

