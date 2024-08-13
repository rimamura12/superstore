select*
from sample_superstore;

-- check for duplicate

select*,
row_number() over(
partition by `order ID`) as row_num
from sample_superstore;

select*,
row_number() over(
partition by `Product Name`, `order id`) as row_num
from sample_superstore;

with duplicate_cte as
(
select*,
row_number() over(
partition by `product name`, `order id`) as row_num
from sample_superstore
)
select*
from duplicate_cte
where row_num > 1;

select*
from sample_superstore
where `row ID` = '6501';

CREATE TABLE `sample_superstore2` (
  `Row ID` int DEFAULT NULL,
  `Order ID` text,
  `Order Date` text,
  `Ship Date` text,
  `Ship Mode` text,
  `Customer ID` text,
  `Customer Name` text,
  `Segment` text,
  `Country` text,
  `City` text,
  `State` text,
  `Postal Code` int DEFAULT NULL,
  `Region` text,
  `Product ID` text,
  `Category` text,
  `Sub-Category` text,
  `Product Name` text,
  `Sales` double DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Discount` double DEFAULT NULL,
  `Profit` double DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select*
from sample_superstore2;

insert into sample_superstore2
select*,
row_number() over(
partition by `Product Name`, `order id`) as row_num
from sample_superstore;

select*
from sample_superstore2;

select*
from sample_superstore2
where row_num > 1;

delete 
from sample_superstore2
where row_num > 1;

select*
from sample_superstore2
where row_num > 1;

select*
from sample_superstore2;

-- check for blanks or null values

select*
from sample_superstore2
where `row id` = '';

select*
from sample_superstore2
where `order id` = '';

select*
from sample_superstore2
where
	trim(`order date`) = '' or
    trim(`ship date`) = '';
    
    select*
from sample_superstore2
where
	trim(`ship mode`) = '' or
    trim(`customer id`) = '' or
    trim(`customer name`) = '' or
    trim(`segment`) = '' or
    trim(`country`) = '' or
    trim(`city`) = '' or
    trim(`state`) = '' or
    trim(`postal code`) = '' or
    trim(`region`) = '' or
    trim(`product id`) = '' or
    trim(`category`) = '' or
    trim(`sub-category`) = '' or
    trim(`product name`) = '' or
    trim(`sales`) = '' or
    trim(`quantity`) = '' or
    trim(`discount`) = '' or
    trim(`Profit`) = '' or
    trim(`row_num`) = '';
    
    select*
from sample_superstore2
where
	trim(`ship mode`) is null or
    trim(`customer id`) is null or
    trim(`customer name`) is null or
    trim(`segment`) is null or
    trim(`country`) is null or
    trim(`city`) is null or
    trim(`state`) is null or
    trim(`postal code`) is null or
    trim(`region`) is null or
    trim(`product id`) is null or
    trim(`category`) is null or
    trim(`sub-category`) is null or
    trim(`product name`) is null or
    trim(`sales`) is null or
    trim(`quantity`) is null or
    trim(`discount`) is null or
    trim(`Profit`) is null or
    trim(`row_num`) is null;
    
-- no blanks or null values. Data Cleaning Complete

select*
from sample_superstore2;

-- data analysis of sales by yearly, quarterly

select*
from sample_superstore2;

select date_trunc('year', orderdate) as year,
sum(sales) as total_sales,
sum(profit) as total_profit
from sample_superstore2
group by year
order by year asc;

select 
year(`ship date`) as year,
sum(sales) as total_sales,
sum(profit) as total_profit
from sample_superstore2
group by year
order by year
;

select `order date`,
str_to_date(`order date`, '%m/%d/%Y') as converted_date
from sample_superstore2;

select `ship date`,
str_to_date(`ship date`, '%m/%d/%Y') as converted_date
from sample_superstore2;

update sample_superstore2
set `order date` = str_to_date(`order date`, '%m/%d/%Y')
;

update sample_superstore2
set `ship date` = str_to_date(`ship date`, '%m/%d/%Y')
;

select*
from sample_superstore2;

select 
year(`ship date`) as year,
sum(sales) as total_sales,
sum(profit) as total_profit
from sample_superstore2
group by year
order by year
;

select
year(`order date`) as year,
quarter(`order date`) as quarter,
sum(sales) as total_sales,
sum(profit) as total_profit
from sample_superstore2
group by year(`order date`), quarter(`order date`)
order by year, quarter;

select
year(`order date`) as year,
quarter(`order date`) as quarter,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit
from sample_superstore2
group by year(`order date`), quarter(`order date`)
order by year, quarter;

select*
from sample_superstore2;

-- highest profit by region, state, and city

select region,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit
from sample_superstore2
group by region
order by total_profit desc;

select region,
round((sum(profit)/sum(sales))*100,2) as profit_margin
from sample_superstore2
group by region
order by profit_margin desc;

select state,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit,
round((sum(profit)/sum(sales))*100,2) as profit_margin
from sample_superstore2
group by state
order by profit_margin desc;

select state,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit,
round((sum(profit)/sum(sales))*100,2) as profit_margin
from sample_superstore2
group by state
order by total_profit desc;

select state,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit,
round((sum(profit)/sum(sales))*100,2) as profit_margin
from sample_superstore2
group by state
order by total_profit asc
limit 10;

select city,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit,
round((sum(profit)/sum(sales))*100,2) as profit_margin
from sample_superstore2
group by city
order by total_profit desc;

select city,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit,
round((sum(profit)/sum(sales))*100,2) as profit_margin
from sample_superstore2
group by city
order by total_profit asc
limit 10;

-- identify the relationship for total sales, total profit, and profit margin for different columns

select*
from sample_superstore2;

select discount, round(avg(sales),2) as avg_sales
from sample_superstore2
group by discount
order by discount;

select category, round(sum(discount),2) as total_discount
from sample_superstore2
group by category
order by total_discount desc;

select category, `sub-category`, round(sum(discount),2) as total_discount
from sample_superstore2
group by category, `sub-category`
order by total_discount desc;

select category, `sub-category`, round(sum(sales),2) AS total_sales, round(sum(profit),2) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) as profit_margin
from sample_superstore2
group by category, `sub-category`
order by total_profit desc;

select region, category, round(sum(sales),2) AS total_sales, round(sum(profit),2) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) as profit_margin
from sample_superstore2
group by region, category
order by total_profit desc;

select state, category, round(sum(sales),2) AS total_sales, round(sum(profit),2) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) as profit_margin
from sample_superstore2
group by state, category
order by total_profit asc;

select `sub-category`, round(sum(sales),2) AS total_sales, round(sum(profit),2) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) as profit_margin
from sample_superstore2
group by `sub-category`
order by total_profit desc;

select `product name`, round(sum(sales),2) AS total_sales, round(sum(profit),2) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) as profit_margin
from sample_superstore2
group by `product name`
order by total_profit desc;

select `product name`, round(sum(sales),2) AS total_sales, round(sum(profit),2) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) as profit_margin
from sample_superstore2
group by `product name`
order by total_profit asc;

-- find general information

select count(distinct(`customer id`)) as total_customers
from sample_superstore2;

select region, count(distinct(`customer id`)) as total_customers
from sample_superstore2
group by region
order by total_customers desc;

select state, count(distinct(`customer id`)) as total_customers
from sample_superstore2
group by state
order by total_customers desc;


