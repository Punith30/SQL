create database Adventure_works;
select *from dimcustomer;
select *from dimdate;
select *from salesold;
select *from salesnew;
select *from dimproduct;
select * from dimproductcategory;
select * from dimproductsubcategory;
select *from dimsalesterritory;


create table Sales as
SELECT *
FROM factinternetsales
UNION ALL
SELECT *
FROM fact_internet_sales_new; 
SELECT *FROM SALES; 


create table Product as SELECT 
    dp.*, 
    dps.EnglishProductSubcategoryName, 
    dpc.EnglishProductCategoryName
FROM 
    dimproduct dp
left JOIN 
    dimproductsubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
left JOIN 
    dimproductcategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey;
    
alter table dimproduct drop column ChineseDescription,drop column arabicdescription,drop column hebrewdescription,drop column germandescription,drop column turkishdescription ;


select s.*, p.EnglishProductName
from sales as s
inner join dimproduct as p
on s.productkey = p.productkey;

## ans 2
 SELECT s.*, 
       CONCAT(c.FirstName, ' ', c.LastName) AS CustomerfullName,
       p.`Unit Price`
FROM sales s
INNER JOIN dimcustomer c
ON s.CustomerKey = c.CustomerKey
INNER JOIN dimproduct p
ON s.ProductKey = p.ProductKey;   

# ans 3
SELECT  
  YEAR(OrderDate) AS Year,
  MONTH(OrderDate) AS Monthno,
  MONTHNAME(OrderDate) AS Monthfullname,
  QUARTER(OrderDate) AS Quarter,
  DATE_FORMAT(OrderDate, '%Y-%b') AS YearMonth,
  WEEKDAY(OrderDate) AS Weekdayno,
  DAYNAME(OrderDate) AS Weekdayname,
  IF(MONTH(OrderDate) IN (4, 5, 6), 'Q1', 
     IF(MONTH(OrderDate) IN (7, 8, 9), 'Q2', 
        IF(MONTH(OrderDate) IN (10, 11, 12), 'Q3', 'Q4'))) AS FinancialQuarter,
  IF(MONTH(OrderDate) IN (4, 5, 6), 'Apr-Jun', 
     IF(MONTH(OrderDate) IN (7, 8, 9), 'Jul-Sep', 
        IF(MONTH(OrderDate) IN (10, 11, 12), 'Oct-Dec', 'Jan-Mar'))) AS FinancialMonth
FROM sales;
    select *from sales;
    
    #ans 4
    
    SELECT 
  (UnitPrice * OrderQuantity) * (1 - UnitPriceDiscountPct) AS SalesAmount
FROM 
  sales;
  
  ## ans 5
  SELECT 
  (ProductStandardCost * OrderQuantity) AS ProductionCost
FROM 
  sales;

## and 6

select Orderdate from Sales limit 10;

select Orderdate from Sales limit 10;

select year(orderdate) as `year`  from sales;


alter table sales add column `year` int;
set SQL_SAFE_UPDATES=0;
UPDATE sales
SET Year = YEAR(orderdate);

select `year` from sales;

select month(orderdate)as month from sales
group by month;

select monthname(orderdate) as month from sales
group by month;

select quarter(orderdate) as month_quarter from sales
group by month_quarter;

SELECT DATE_FORMAT(OrderDate, '%Y-%b') AS YearMonth
FROM sales;


