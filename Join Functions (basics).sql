-- First Table - Customer_table ( Using Company2 database )
--------------------------------------------------------------

create table customer_table 
(
cust_id int primary key ,
Name varchar(50) ,
age int ,
city varchar(50) ,
gender enum('male','female') ,
phone varchar(50) ,
email varchar(50)
);

-- Second Table- Order_table (using Company2 database)
-------------------------------------------------------

create table order_table
(
order_id int  ,
cust_id int primary key ,
product varchar(50) ,
amount int ,
order_date date ,
payment_mode varchar(50) ,
Order_status enum('delivered','cancelled','pending')
);


-- Third Table - Stock_table ( using Company 2 Database )
-----------------------------------------------------------

create table stock_table
(
Product_id int ,
Product_name varchar(20) ,
Category Varchar(20) ,
Price int ,
Brand varchar(20) ,
Stock int
);


-----------------------------------------------------------------------------------------------

-- insert values Into Customer_table
-------------------------------------

insert into customer_table values 
(1,'Aniket',23,'delhi','male','7782','aniket@mail.com'),
(2,'Aahan',22,'Patna','male','8540','aahan@mail.com'),
(3,'Vipin',20,'delhi','male','8203','vipin@mail.com'),
(4,'Golu',23,'hyderabad','male','9525','golu@mail.com'),
(5,'Gautam',24,'hyderabad','male','9242','gautam@mail.com'),
(6,'rajesh',22,'varanasi','male','8789','rajesh@mail.com'),
(7,'rupali',20,'patna','female','9525','rupali@mail.com'),
(8,'ashu',25,'jaunpur','female','9250','ashu@mail.com'),
(9,'vedant',22,'patna','male','9725','vedant@mail.com'),
(10,'Annu',23,'Bengaluru','female','9925','annu@mail.com'),
(11,'Rahul',18,'hyderabad','male','9525','golu@mail.com'),
(12,'Ram',35,'hyderabad','male','8525','ram@mail.com'),
(13,'prakash',21,'delhi','male','9935','prakash@mail.com'),
(14,'kabir',26,'mumbai','male','9525','kabir@mail.com'),
(15,'nikhil',30,'jaipur','male','9787','nikhil@mail.com'),
(16,'Ranvijay',48,'hyderabad','male','9525','golu@mail.com'),
(17,'Vijay',41,'agra','male','9925','vijay@mail.com'),
(18,'Aksh',25,'delhi','male','7525','aksh@mail.com'),
(19,'Gaurav',51,'varanasi','male','7925','gaurav@mail.com'),
(20,'Anil',31,'delhi','male','7915','anil@mail.com');

insert into customer_table values
(22,'Aniket',23,'delhi','male','7782','aniket@gmail.com'),
(23,'Gautam',24,'hyderabad','male','9242','gautam@gmail.com'),
(24,'rupali',20,'patna','female','9525','rupali@gmail.com'),
(25,'Aniket',23,'delhi','male','7782','aniket@gmail.com'),
(26,'Aahan',22,'patna','male','8540','aahan@gmail.com');

-- Insert Values into Order_table
---------------------------------

insert into order_table values
(101,1,'laptop',15000,'2025-04-01','card','delivered'),
(102,2,'smartphone',12000,'2025-05-03','cash','cancelled'),
(103,3,'mouse',750,'2025-02-01','upi','pending'),
(104,4,'Tv',22500,'2025-05-15','cash','delivered'),
(105,5,'Bag',2150,'2025-06-05','upi','pending'),
(106,6,'Camera',5550,'2025-07-10','cash','delivered'),
(107,7,'Fridge',15550,'2025-03-06','card','delivered'),
(108,8,'keyboard',1250,'2025-08-02','upi','pending'),
(109,9,'shoes',4750,'2025-08-21','cash','delivered'),
(110,10,'watch',4250,'2025-09-15','card','cancelled'),
(111,11,'headphone',2750,'2025-10-01','upi','pending'),
(112,12,'bluetooth',3250,'2025-08-12','cash','delivered'),
(113,13,'books',4250,'2025-11-12','card','cancelled'),
(114,14,'grocery',3850,'2025-02-20','cash','delivered'),
(115,15,'chair',3750,'2025-05-01','upi','pending'),
(116,16,'smartwatch',5250,'2025-12-23','card','delivered'),
(117,17,'tablet',42500,'2025-11-08','card','delivered'),
(118,18,'macbook',75750,'2025-06-05','upi','pending'),
(119,19,'mobile',12500,'2025-06-01','cash','cancelled'),
(120,20,'earphone',750,'2025-08-01','upi','pending'); 

-- Insert values into stock_table
----------------------------------

INSERT INTO STOCK_TABLE VALUES 
(1,'LAPTOP','ELECTRONICS',35000,'ASUS',10),
(2,'LAPTOP','ELECTRONICS',375000,'APPLE',5),
(3,'LAPTOP','ELECTRONICS',42000,'HP',15),
(4,'TV','ELECTRONICS',55000,'SAMSUNG',7),
(5,'TV','ELECTRONICS',46500,'SONY',12),
(6,'TV','ELECTRONICS',25000,'LG',15),
(7,'FRIDGE','ELECTRONICS',15000,'SAMSUNG',12),
(8,'FRIDGE','ELECTRONICS',24000,'WHIRLPOOL',20),
(9,'MOBILE','ELECTRONICS',35000,'SAMSUNG',25),
(10,'MOBILE','ELECTRONICS',25000,'VIVO',26),
(11,'TABLET','ELECTRONICS',15000,'LENOVO',20),
(12,'CAMERA','ELECTRONICS',25000,'CANON',25),
(13,'SHOES','FASHION',12000,'PUMA',30),
(14,'WATCH','FASHION',4000,'TITAN',50),
(15,'WATCH','FASHION',8000,'FASTRACK',30),
(16,'BAG','FASHION',5550,'SKYBAGS',40),
(17,'BAG','FASHION',12000,'AMERICAN TOURISTER',30),
(18,'JEANS','FASHION',3500,'KILLER',45),
(19,'SHIRTS','FASHION',2650,'MUFTI',50),
(20,'SHOES','FASHION',9500,'NIKE',50);

-------------------------------------------------------------------
-- Data Cleaning

update order_table
set order_id = null  
where order_id = 112 ;

set sql_safe_updates = 0 ;
---------------------------------------------------------------------------------

-- inner join
-----------------


select name,product,amount,city,order_id from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id ;


-- Show all customers with their order amount

select name,amount,order_id from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id ;


-- Show customer name and product

select name , product from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id ;

-- Show only Delhi customers with orders

select name , city , product from customer_table
inner join order_table 
on customer_table.cust_id=order_table.cust_id 
where city = 'delhi' ;


-- Show orders where amount > 20000

select name , product , amount , order_id from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id
where amount > 20000 ;


-- Show all customers even if no orders (LEFT JOIN)

select name , amount from customer_table
left join order_table
on customer_table.cust_id=order_table.cust_id ;


-- Count total orders for each customer

select name , count(order_id) as Total_orders from customer_table
left join order_table
on customer_table.cust_id=order_table.cust_id 
group by name ; 



-- Show total amount spent by each customer

select name, sum(amount) as Total_spent from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id 
GROUP BY NAME ;


-- Show customers who have no orders

select name from customer_table
left join order_table
on customer_table.cust_id=order_table.cust_id 
where order_table.order_id is null ;


-- Show top 3 customers by total spending

select name , sum(amount) as Total_spent from customer_table
inner join order_table 
on customer_table.cust_id=order_table.cust_id
group by Name
order by Total_spent desc 
limit 3 ;


-- Show customer details with order count and total amount

select name , count(Order_id) as Total_orders , sum(amount) as Total_spent
from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id
group by Name ;


USE COMPANY2;
SELECT * FROM customer_table
cross join order_table
ON order_table.cust_id=customer_table.cust_id;

-- SHOW CUSTOMER NAME PRODUCT OR AMOUNT

SELECT NAME,PRODUCT_NAME,AMOUNT FROM customer_table
inner join order_table
ON customer_table.cust_id=order_table.cust_id
inner JOIN stock_table
ON order_table.PRODUCT_ID=stock_table.PRODUCT_ID;

-- Show customer name, city, product category
SELECT NAME,city,CATEGORY FROM customer_table
inner join order_table
ON customer_table.cust_id=order_table.cust_id
inner JOIN stock_table
ON order_table.PRODUCT_ID=stock_table.PRODUCT_ID;

-- Show orders with product price > 20000

SELECT NAME,product,PRICE FROM customer_table
inner join order_table
ON customer_table.cust_id=order_table.cust_id
inner JOIN stock_table
ON order_table.PRODUCT_ID=stock_table.PRODUCT_ID
where PRICE >=20000;

-- Show total amount spent by each customer

select name, sum(amount) as total_amount from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id
group by Name
order by total_amount desc;

-- Show top 3 customers by spending
select name, sum(amount) as total_amount from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id
group by Name
order by total_amount desc
limit 3;

-- laptop total stock 

select  PRODUCT_NAME , sum(STOCK) as Total_stock from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id
inner join stock_table
on stock_table.PRODUCT_ID=order_table.PRODUCT_ID
group by PRODUCT_NAME 
order by Total_stock desc ;

-- Show customers whose amount is greater than ANY amount below 7000
select name , amount from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id
where amount > any (
						select amount
                        from order_table
                        where amount < 7000);
select amount
                        from order_table
                        where amount < 7000;


-- Show amounts less than ANY amount above 10000

select name , amount from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id
where amount < any (
						select amount
                        from order_table
                        where amount >10000);
select amount
                        from order_table
                        where amount >10000;
                        
-- Show customers whose amount equals ANY selected values

select name , amount from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id
where amount = any (
						select amount
                        from order_table
                        where amount in (5000,15000));
                        
-- Show customers with amount greater than ANY Mumbai customer amount
select name , amount from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id
where amount > any (
						select amount
                        from customer_table
                        inner join order_table
                        on customer_table.cust_id=order_table.cust_id
                        where name='kabir');
                        
-- Show customers whose amount is greater than ALL amounts below 7000

select name , amount from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id
where amount > all (
						select amount
                        from order_table
                        where amount <7000);
                        
-- Show customers who placed orders

select name,amount from customer_table
inner join order_table
on customer_table.cust_id=order_table.cust_id
where amount > exists (
						select 1 from order_table
                        where customer_table.cust_id=order_table.cust_id 
                        );
                        
-- Show customers whose amount is greater than ALL amounts below 7000

select name , amount from customer_table
inner join order_table
on customer_table.cust_id = order_table.cust_id
where amount > all (
					select amount from order_table
                    where amount < 7000 
                    );
                    
-- Show customers whose amount is greater than ANY amount below 7000

select name , amount from customer_table
inner join order_table
on customer_table.cust_id = order_table.cust_id
where amount > any (
                    select amount from order_table
                    where amount < 7000 
                    );
                    

-- Show customers whose amount equals ANY selected values

select name , amount from customer_table
inner join order_table
on customer_table.cust_id = order_table.cust_id
where amount = any (
                    select amount from order_table
                    where amount in (5000,15000) 
                    );
                    
-- Show amounts less than ANY amount above 10000

select name , amount from customer_table
inner join order_table
on customer_table.cust_id = order_table.cust_id
where amount < any (
                    select amount from order_table
                    where amount >  10000 
                    );
                    
-- Show customers with amount greater than ANY Mumbai customer amount

select name , amount from customer_table
inner join order_table
on customer_table.cust_id = order_table.cust_id
where amount > any (
                    select amount from order_table
                    inner join customer_table
                    on customer_table.cust_id=order_table.cust_id
                    where name = 'kabir'
                    );
                    
-- Show customers who placed orders

select name , amount from customer_table
inner join order_table
on customer_table.cust_id = order_table.cust_id
where amount > all (
					select amount from order_table
                    where amount < 7000 
                    );
                    

