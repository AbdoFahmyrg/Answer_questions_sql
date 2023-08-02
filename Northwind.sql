-- 1--> Display a list of all customers --
select * from Customer;

-- 2--> Display a list of customers id, name  and city --
select FirstName, LastName, City from Customer;

-- 3--> for customers who live in 'mexico', display a list of their full name and phone
select FirstName +''+ LastName as "Full Name", City from Customer
where Country = 'Mexico';

-- 4-->
select Productname, UnitPrice, SupplierId from Product
where UnitPrice > 10 and SupplierId = 1;

-- 5-->
select Productname, UnitPrice, SupplierId from Product
where UnitPrice > 10 or SupplierId = 1;

-- 6--> for products with price over 50$, display the ProductName, Package and price after Taxes , taxes = 15%;
select ProductName, Package, (UnitPrice*0.15) as "Price After Taxes"  from Product
where UnitPrice>50;

-- 8--> for suppliers outside 'USA' and 'UK' display a list of campany name , city and phone.
select CompanyName, City, Country, Phone from Supplier
where Country not in ('USA','UK');

-- 8--> Prices are between 20 and 50.
select * from Product
where UnitPrice between 20 and 50;

-- 9--> for suppliers located in 'USA' display alist of company name , product names and unitprice sorted alphabetically.
select CompanyName, ProductName, UnitPrice
from Supplier s join Product p 
on s.Id = p.SupplierId
where Country = 'USA'
order by CompanyName asc;	

-- 10--> For each customur , display a list of customer full name and how many arders he made and how match totally paid
select FirstName +''+ LastName as "Full Name",
count(*) as "Num Orders" ,
sum(TotalAmount) as "Total Amount" 
from Customer C join Orders O
on C.Id = O.CustomerId
group by FirstName, LastName;

-- 11--> For suppliers , who supplied more than 3 products, display a list of company name and how many products it supplied ,
-------  sorted by the number of products in descending order.
select CompanyName, count(*) as num_products
from Supplier S join Product P
on S.Id = P.SupplierId
group by CompanyName
having count(*)>3
order by CompanyName desc;

-- 12--> Display a top 5 list of the most expensive products.
select top 5 ProductName, UnitPrice
from Product
order by UnitPrice desc;

-- 13--> Display a list of the top 6 best-selling products.
select top 6 ProductId, count(*) as  "The best selling_p "
from OrderItem
group by ProductId
order by count(*) desc;

-- 13--> Display a list of products with prices more than the average price.
select * from Product
where UnitPrice > (select avg(UnitPrice) from Product);

-- 14--> 12- Display a list of customers who bought one or more products that Mr 'Horst' already bought.
select distinct FirstName, LastName 
from Customer C join Orders O on c.Id = O.CustomerId
join OrderItem oi on oi.OrderId = O.id
where oi.ProductId in (select distinct oi.ProductId from Customer C join Orders O
on c. Id = O.CustomerId join OrderItem oi 
on oi.OrderId = O.id and FirstName ='Horst');