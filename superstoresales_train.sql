CREATE TABLE SuperstoreSales (
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(25),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(25),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(25),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255),
    Sales DECIMAL(10, 2)
);

select * from SuperstoreSales;

-- 1. What is the total sales across the entire dataset? 

select sum(sales) as total_sales from superstoresales;

-- Total sales are : 2261536.97
-- What is the total Profit across the entire dataset?
-- In this dataset profit column is not given so i take sales 15% as profit
select sum(sales*0.15) as total_profit from superstoresales;

-- 2. Total number of orders
select count(order_id) as total_orders from superstoresales;

-- Total number of orders are : 9800

-- 3. Average order value
select avg(sales) as avg_order_value from superstoresales;

-- Average order value is : 230.7690785714285714

-- 4. Total sales by region
select region, sum(sales) as total_sales  from superstoresales group by region;

-- Total on South region is: 389151.45
-- Total on West region is: 710219.77
-- Total on East region is: 669518.85
-- Total on Central region is: 492646.90
-- West region is showing significant growth of sales through years follow by East region

-- 5. Total sales by category (insted of profit we have use sales)
select category, sum(sales) as total_sales  from superstoresales group by category;

-- Total sales by Furniture category is : 728658.75
-- Total sales by Office Supplies category is : 705422.28
-- Total sales by Technology category is : 827455.94
-- The Technology category is showing rise in sales follow by Furniture and lastly Office supplies

-- 6. Top 5 products by sales
select product_name, sum(sales) as product_sale from superstoresales group by product_name order by product_sale desc limit 5;

-- Product : "Canon imageCLASS 2200 Advanced Copier" & Sales: 61599.83
-- Product : "Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind" & Sales: 27453.38
-- Product : "Cisco TelePresence System EX90 Videoconferencing Unit" & Sales: 22638.48
-- Product : "HON 5400 Series Task Chairs for Big and Tall" & Sales: 21870.57
-- Product : "GBC DocuBind TL300 Electric Binding System" & Sales: 19823.48

-- 7. Bottom 5 products by sub_category (instead of profit i use sub_category
select sub_category, sum(sales) as total_sales from superstoresales group by sub_category order by total_sales asc limit 5;

-- Sub-category : "Fasteners" & Sales : 3001.93
-- Sub-category : "Labels" & Sales    : 12347.71
-- Sub-category : "Envelopes" & Sales : 16128.02
-- Sub-category : "Art" & Sales       : 26705.42
-- Sub-category : "Supplies" & Sales  : 46420.29

-- 8. Monthly sales trend with order_date
select to_char(order_date ::date,'Month') as months , sum(sales) as total_sales from superstoresales group  by months;

/*
Months      :   Sales
"November "	: 350161.74
"January  "	: 94291.66
"April    "	: 136283.04
"August   "	: 157315.85
"June     "	: 145837.55
"February "	: 59371.12
"May      "	: 154086.74
"December "	: 321480.21
"March    "	: 197573.60
"October  "	: 199496.34
"July     "	: 145535.70
"September"	: 300103.42
*/
-- 9. Year-over-year growth
select date_part('Year', order_date) as years, sum(sales)as yearly_sales from superstoresales group by years order by years asc;

/*
Years : Sales
2015  : 479856.27
2016  : 459435.94
2017  : 600192.80
2018  : 722051.96
*/

-- 10. Top 10 customers by sales (insteafd of revenue i use sales)
select customer_id, customer_name , sum(sales) as cust_sales from superstoresales group by customer_id,customer_name order by cust_sales desc limit 10;

/*
Customer Id : Customer Name        : Customer Sales
--------------------------------------------------
"SM-20320"	: "Sean Miller"	       : 25043.07
"TC-20980"	: "Tamara Chand"	   : 19052.22
"RB-19360"	: "Raymond Buch"	   : 15117.35
"TA-21385"	: "Tom Ashbrook"	   : 14595.62
"AB-10105"	: "Adrian Barton"	   : 14473.57
"KL-16645"	: "Ken Lonsdale"	   : 14175.23
"SC-20095"	: "Sanjit Chand"	   : 14142.34
"HL-15040"	: "Hunter Lopez"	   : 12873.30
"SE-20110"	: "Sanjit Engle"       : 12209.44
"C I12370"	: "Christopher Conant" : 12129.08
*/

-- 11. How many unique customers are there?
select distinct(customer_id), customer_name from superstoresales group by customer_id,customer_name;

-- There are 793 distict customers

-- 12. What are the distinct categories and sub-categories available?
select distinct category,sub_category from superstoresales group by category,sub_category;

-- 13. Total sales by region
select region, sum(sales) as total_sales  from superstoresales group by region;

-- Total on South region is: 389151.45
-- Total on West region is: 710219.77
-- Total on East region is: 669518.85
-- Total on Central region is: 492646.90

-- 14. Which top 5 cities have the highest sales?
select city,sum(sales) as city_sales from superstoresales group by city order by city_sales desc limit 5;

-- 15. What is the total sales by;category and sub-category?
select  distinct category, sub_category , sum(sales) as categorical_sales from superstoresales group by category, sub_category;

-- 16. Which customer segment (Consumer, Corporate, etc.) generates the most sales?
select segment, sum(sales) from superstoresales group by segment;

-- 17. What is the monthly sales trend (extract month from Order_Date)?
select date_part('month',order_date) as months, sum(sales) as monthly_sales from superstoresales group by months;
select to_char(order_date,'Month') as months, sum(sales) as monthly_sales from superstoresales group by months;

-- 18. Which are the top 10 products by sales?
select product_id, product_name, sum(sales) as product_sales from superstoresales group by product_id,product_name order by product_sales desc limit 10;

-- 19. What is the average order value per customer?
select customer_name, sum(sales)/count(distinct order_id) as avg_orders from superstoresales group by customer_name;

-- 20. Which state has the highest sales in each region?
--(Hint: use window functions like RANK) Note: I Used Google
with state_sales as(
select region,state,sum(sales) as st_sales, rank() over(partition by region order by sum(sales) desc) as rnk from superstoresales group by region ,
state
)
select  region , state , st_sales from state_sales where rnk = 1

-- 21. Find the top-selling product in each category.
with cat_top_sale_prdct as(
select category,product_name,sum(sales) as cat_sales, rank() over(partition by category order by sum(sales) desc) as rnk from superstoresales group by category, product_name
)
select category, product_name , cat_sales from cat_top_sale_prdct where rnk = 1;

--22. Calculate the percentage contribution of each region to total sales.
-- use gemini for silution
select region, sum(sales),(sum(sales) *100.0)/sum(sum(sales)) over ()as percentage_distribution
from superstoresales group by region;

--23. Identify repeat customers (customers with more than 1 order) and their total sales.
-- My solution
select customer_id,customer_name , sum(sales) as total_sales,
case when count(customer_id) > 1 then 1 else 0 end
from superstoresales group by customer_id, customer_name;

-- Gemini solution because i use count so using having
select	customer_id, customer_name, sum(sales) as total_sales
from superstoresales group by customer_id, customer_name
having count(customer_id) > 1;

-- 24. Find the fastest shipping time and average shipping time:
--(Ship_Date - Order_Date)
select min(ship_date - order_date) as fast_ship from superstoresales;
select min(ship_date - order_date) as fast_ship_time , round(avg(ship_date - order_date),2)as avg_ship_time from superstoresales;

--🔹 Bonus (Real Analyst Thinking 🚀)
--If you want to go one level deeper (this is what companies expect):

-- 25. Which segment is growing month-over-month?
-- use gemini
with monthly_sales as(
select date_trunc('month',order_date) as months, segment ,sum(sales) as current_month_sales
from superstoresales
group by months, segment
order by months
)select months, segment, current_month_sales,
lag(current_month_sales) over(partition by segment order by months) as previous_month_sales,
current_month_sales - lag(current_month_sales) over(partition by segment order by months) as growth_amount
from monthly_sales
order by months, segment;

-- 26. Which products are consistently top performers across regions?
-- use gemini
with rankedproducts as(
select region, product_name , sum(sales), rank() over(partition by region order by sum(sales) desc) as rnk
from superstoresales group by region, product_name
)select product_name, count(region) as appereances_at_top
from rankedproducts where rnk <= 7 -- Change this to 1 if you only want the absolute best
group by product_name having count(region) > 1 -- This identifies "Consistency" across multiple regions
order by appereances_at_top desc;

--27. Which cities have high sales but low order frequency (opportunity areas)?
-- hint from gemini
select city , sum(sales) as city_total , count(distinct order_id) as order_counts from superstoresales group by city
having count(distinct order_id) < 6
order by order_counts desc;  

-- Subquery using gemini
select city , sum(sales) as city_total , count(distinct order_id) as order_counts from superstoresales group by city
having count(distinct order_id) < (select avg(city_order_counts)
from(
select count(distinct order_id) as city_order_counts
from superstoresales group by city)as average_frequency)
order by order_counts desc;  

