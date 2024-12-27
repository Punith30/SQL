## ANS 1 SELECT clause with WHERE, AND, DISTINCT, Wild 
# a
select *from employees;
select	distinct employeenumber,firstname,lastname from employees where jobtitle ='sales rep' and reportsTo like '%02';
#b
select *from products;
select distinct productline from products where productLine like '%cars';

## ANS 2CASE STATEMENTS for Segmentation

select *from customers;
#a
select customernumber ,customerName, case
when country in ('usa','canada') then 'north america'
when country in('uk','france','germany') then 'europe'
else 'other'
end as 'customersegnment' from customers ;

## ANS-3  Group By with Aggregation functions and Having clause, Date and Time functions
#a
 select *from orderdetails;
 select productcode,
 sum(quantityOrdered) as TOTAL_ORDERS
 FROM orderdetails
 GROUP BY productCODE
 ORDER BY TOTAL_ORDERS DESC
 LIMIT 10;
 
#b
select *from payments;
select monthname(paymentdate) as MONTH_NAME,
COUNT(AMOUNT) AS NUM_PAYMENTS
FROM payments
group by MONTH_NAME
HAVING NUM_PAYMENTS>20
ORDER BY NUM_PAYMENTS DESC;

## AND -4 CONSTRAINTS: Primary, key, foreign key, Unique, check, not null, default
CREATE database CUSTOMERS_ORDERS;
CREATE table CUSTOMERS(CUSTOMERS_ID INT PRIMARY KEY AUTO_INCREMENT ,
FIRST_NAME VARCHAR(50) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL,
EMALI VARCHAR (255) unique,
PHONE_NUMBER varchar(20) uniQUE);

select* FROM CUSTOMERS;
DESC CUSTOMERS;

##  b
CREATE TABLE ORDERSS(ORDER_ID INT PRIMARY KEY auto_increment,
CUSTOMER_ID INT,
ORDER_DATE DATE,
TOTAL_AMOUNT DECIMAL (10,2), 
foreign key(CUSTOMER_ID)
REFERENCES CUSTOMERS (CUSTOMER_ID),
CHECK (TOTAL_AMOUNT>0));
select* FROM ORDERSS;

use classicmodels;
## ANS 5 JOINS
select customers.country, count(ordernumber) as Order_count from customers 
												inner join orders on customers.customernumber=orders.customernumber 
                                                group by customers.country 
                                                order by order_count  desc 
                                                limit 5; 
    ## ANS 6 SELF JOIN                                            
 create table project (EmployeeID int Primary Key Auto_increment,
                      FullName varchar(50),
                      Gender varchar(20), 
                      ManagerID int , 
                      check(Gender in ('Male','Female'))); 
insert into project (FullName,Gender,ManagerID) values("Pranaya","Male",3), 
													  ("Priyanka","Female",1),
                                                      ("Preety","Female",Null),
                                                      ("Anurag","Male",1),
                                                      ("Sambit","Male",1),
                                                      ("Rajesh","Male",3),
                                                      ("Hina","Female",3);
 select *from project;                                                     
select man.FullName as Manager_Name , emp.FullName as Employee_Name 
from project as man join project as emp 
on man.EmployeeID=emp.ManagerID
order by Manager_Name; 


## 7 DDL CMNDS CREATE ALTER RENAME
create table facility(Facility_ID int,
                       `Name`  varchar(100),
                       State varchar(100),
                       Country varchar(100));
select * from facility;

## a
alter table facility modify  Facility_ID int primary key auto_increment ;            
										
## b
alter table facility
add City varchar(100)not null after`Name`;
desc facility;
alter table facility drop column city;
alter table facility add City varchar(100) not null after`Name`;

desc facility;

## 8 ANS VIEWS IN SQL
create view products_category_sales as 
select p.productline,sum(od.quantityOrdered * od.priceEach) 
as Total_Sales, count(distinct o.ordernumber) as Number_of_orders
from products p
join orderdetails od on p.productCode =od.productCode
join orders o on od.orderNumber = o.orderNumber
group by productLine
order by productLine;

select *from products_category_sales;

##9 STORE PROCUDURE IN SQL
call classicmodels.Get_country_payments(2004, 'usa');


##10 ANS Window functions - Rank, dense_rank, lead and lag
#a
select c.customerName, count(o.orderNumber) as Order_count, 
dense_rank() over (order by count(o.orderNumber) desc ) as order_frequency_rank 
from customers as c join orders as o 
on c.customerNumber = o.customerNumber 
group by customerName 
order by Order_count desc;  

#b
select year(orderDate) as year,monthname(orderDate) as Month , count(orderNumber) as Total_orders, 
CONCAT(FORMAT(ROUND(( count(orderNumber) - LAG(count(orderNumber),1) OVER (ORDER BY year(orderDate)))/ LAG(count(orderNumber),1) OVER (ORDER BY year(orderDate)) * 100),0 ), '%')AS  YOY_CHANGE
FROM orders
group by year, month;   

##11 ANS Subqueries and their applications
select  ProductLine, count(productLine) as Total  from products 
where buyprice > (select avg(buyprice)  from products where productCode=products.productCode) 
group by productLine 
order by Total desc; 

##12 ANS ERROR HANDLING in SQL
create table Emp_EH (EmpID int Primary Key, 
                     EmpName varchar(30), 
                     EmailAddress varchar(30)); 
select * from Emp_EH; 
call classicmodels.InsertIntoEmp_EH(3, 'kholi', 'kholi123@gmail.com');

##13 TRIGGERS
create table Emp_BIT (Name varchar(30) , Occupation varchar(30), Working_date Date, Working_Hours int); 
INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);    
 
INSERT INTO Emp_BIT VALUES ('PUNITH','Analyst','2020-10-05', -15);
INSERT INTO Emp_BIT VALUES ('RANGA','Analyst','2020-10-05', -30);
select * from Emp_BIT;

