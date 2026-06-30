
-- Total Window Functions 
-------------------------------------------------------------------------

-- 1. count row number-- 
select name_, Quantity , row_number() over (order by Quantity desc) as row_num
from zepto_products;

-- 2. find ranking
select name_, Quantity , rank() over (order by Quantity desc) as rank_no
from zepto_products;


-- 3. dense_ranking

select name_, Quantity , dense_rank() over (order by Quantity desc) as rank_no
from zepto_products;

-- 4. previous data use function lag()

select name_, Quantity , lag(Quantity) over (order by Quantity desc) as previous_data
from zepto_products;

-- 5. next row data use function lead()

select name_, Quantity , lead(Quantity) over (order by Quantity desc) as next_data
from zepto_products;

-- 6. running total 

select name_, Quantity , sum(Quantity) over (order by name_ desc) as running_total
from zepto_products;

-- 7. highest qty

select name_, Quantity , first_value(Quantity) over (order by Quantity desc) as highest_qty
from zepto_products;

-- 8. year over year growth

select year_,sum(Quantity) as Total_qty,
lag(sum(quantity)) over (order by year_) as Previous_year_qty
from crude_oil_import
group by year_ ;

-- 9. growth %

select year_ ,Total_qty , Previous_year_qty,
((Total_qty - previous_year_qty)/previous_year_qty)*100 as Growth_per
from
(
select year_ , sum(Quantity) as Total_qty,
lag(sum(quantity)) over (order by year_) as Previous_year_qty
from crude_oil_import
group by year_
)A;


-----------------------------------------------------------------------------------------

-- Practise qs using window Functions
---------------------------------------

-- 1. Product-wise Ranking

select product , sum(qty) as Total_qty
, rank () over ( order by sum(qty) desc) as Ranking
from imports2 
group by Product;

-- 2. Dense Ranking

select product , sum(qty) as Total_qty ,
dense_rank () over (order by sum(qty) desc) as Dense_ranking
from imports2
group by Product;

-- 3. Running Total

select product , qty ,
sum(qty) over (order by Import_date desc) as Running_total
from imports2;


-- 4. Previous Import Quantity (LAG)

select Import_Date , qty ,
lag(qty) over (order by Import_Date ) as Previous_year_qty
from imports2;


-- 5. Next Import Quantity (LEAD)

select import_date , qty ,
lead(qty) over (order by import_date) as Next_qty
from imports2;

-- 6. Year-over-Year Growth

select year(import_date) , sum(qty) as Total_qty ,
lag(sum(qty)) over (order by sum(qty) desc) as Previous_year_qty
from imports2
group by year(import_date);


-- 7. Top 3 Products

select *
from
(
select product , sum(qty) as Total_qty,
row_number () over (order by sum(qty) desc) as Row_num
from imports2
group by Product
) A
where Row_num<=3;


-- 8. Country-wise Running Total

select country , import_date , qty ,
sum(qty) over ( partition by country order by import_date)
as Running_total
from imports2;


-- 9. Highest Quantity Product

select product , qty ,
first_value(qty) over ( order by qty desc) as Highest_qty
from imports2;


-- 10. Monthly Moving Average

select import_date , qty , 
avg(qty) over (order by import_date 
			   rows between 2 preceding and current row )
               as Moving_avg
from imports2;



















































