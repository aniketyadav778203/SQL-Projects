-- show date and time

use company2;

select now();

select curdate();

select year('2020-04-01');

select month('2020-04-01');

select day('2020-04-01');

select date_format('2020-04-01','%d-%m-%Y');

select datediff('2022-04-01','2020-04-01');

select timestampdiff(month,'2020-04-01','2022-04-01');

create table diff_date(
id int primary key auto_increment,
start_date date,
end_date date,
diff_year varchar(20)
);

alter table diff_date
drop column diff_year;

insert into diff_date (start_date,end_date)
values
('2020-01-01','2022-01-01'),
('2020-01-01','2025-01-01'),
('2020-01-01','2026-01-01');

alter table diff_date
add diff_year int;
set sql_safe_updates=0;
update diff_date
set diff_year = timestampdiff(year,start_date,end_date);

--  Total sales between two dates

select sum(sales_amount) as Total_Sales From sales
where sale_date 
between '2024-01-01'
 and '2026-01-01';
 
 -- Last year total sales

select sum(Sales_amount) AS Total_sales from sales
where year(sale_date) = year(curdate())-1;

-- Current year sales

select sum(sales_amount) as Total_sales from sales
where sale_date= year(current_date());

-- Month-wise total sales

select month(sale_date) AS Month,
sum(sales_amount) AS Total_sales
from sales
group by month(sale_date);

-- City-wise sales between two dates

select city , sum(sales_amount) As Total_sales from sales
where sale_date between '2025-01-01' and '2025-12-31'
group by city ;

-- Top 5 highest sales dates

select sale_date , sum(sales_amount) As Total_sales from sales
group by sale_date
order by Total_sales desc
limit 5 ;

-- Average sales for each year

select year(sale_date), avg(sales_amount) As Average_sale from sales
group by year(sale_date) ;

-- Sales growth rate between 2024 and 2025

select
(
(
sum(case when year(sale_date)=2025
then sales_amount
end) 
-
sum(case when year(sale_date)=2024
then sales_amount
end)
)
/
sum(case when year(sale_date)=2024
then sales_amount
end)
)*100 as growth_rate
from sales;

-- Products whose sales increased compared to last year

select product_name from sales 
group by product_name
having
sum(case when year(sale_date)=2025
then sales_amount
end)
>
sum(case when year(sale_date)=2024
then sales_amount
end);

-- Total sales for last 30 days

select sum(sales_amount) as Total_sales from sales
where sale_date >= curdate()- interval 30 day ;

-- Quarterly sales report

select quarter(sale_date) AS quarter,
sum(sales_amount) AS Total_sales 
from sales
group by quarter(sale_date);

-- Highest sales month in 2025

select month(sale_date) As month,
sum(sales_amount) AS Total_sales from sales
where year(sale_date) = 2025
group by month(sale_date)
order by Total_sales desc
limit 1;

-- Customer order count between two dates

select customer_id , count(order_id) AS Total_orders from sales
where sale_date between '2025-01-01' and '2025-12-31'
group by customer_id ;

-- Monthly growth percentage of sales

select month(sale_date) as Month , 
sum(sales_amount) As Total_sales from sales
group by month(sale_date);





