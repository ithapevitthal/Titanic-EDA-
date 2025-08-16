#Original table and database name
SELECT * FROM sales.`sales dataset`;


#change table name 
rename table sales.`sales dataset` to sales.saledata;

#print table
select * from sales.saledata;

#rename column name in usebale formate
ALTER TABLE sales.saledata
CHANGE `Order ID` `OrderID` CHAR(255);

ALTER TABLE sales.saledata
CHANGE `Sub-Category` `SubCategory` CHAR(255);

ALTER TABLE sales.saledata
CHANGE `Order Date` `OrderDate` DATE;

ALTER TABLE sales.saledata
CHANGE `Year-Month` `YearMonth` char(255);


#Extract month number and name from order date
SELECT 
    MONTH(orderdate) AS monthnumber,
    MONTHNAME(orderdate) AS MonthNme
FROM
    sales.saledata;
    
    #use group by and some aggr function for sum of  total profit 
    SELECT DISTINCT
    (City) AS discity,
    sum(profit),
    YEAR(orderdate) AS yearnum,
    MONTH(orderdate) AS monthnum
FROM
    sales.saledata
GROUP BY yearnum , profit , discity , monthnum;


#use some function for revenue
SELECT DISTINCT
    (yearmonth), SUM(profit) AS TotalProfit
FROM
    sales.saledata
GROUP BY yearmonth;

#Count total volume
SELECT DISTINCT
    (OrderId) AS o_id, Quantity, Amount, profit
FROM
    sales.saledata
WHERE
    (SELECT 
            COUNT(quantity)
        FROM
            sales.saledata);
            
#use order by for sorting and get top 10 higest sales
SELECT 
    distinct(city), Amount, Profit, OrderDate, State, OrderId
FROM
    sales.saledata
ORDER BY Profit DESC
LIMIT 10;

#find top 5 state with highest orders using ordr by ,group by and limit in 2024 amd created view
create view sales.yearmonth as
SELECT 
    State, COUNT(OrderId) AS TotalOrders
FROM
    sales.saledata
WHERE
    YEAR(OrderDate) = 2024
GROUP BY state
ORDER BY TotalOrders DESC
LIMIT 5;

