#CREATE sales TABLE
CREATE DATABASE Sales;
#CREATE SALESPEOPLE TABLE
CREATE TABLE Sales.SALESPEOPLE
(SNUM INT(10) NOT NULL AUTO_INCREMENT ,
SNAME VARCHAR(500) NOT NULL ,
CITY VARCHAR(500) NOT NULL ,
COMM INT ,
PRIMARY KEY (SNUM)  );
#CREATE CUSTOMER TABLE
CREATE TABLE Sales.CUSTOMER
(CNUM INT(10) NOT NULL AUTO_INCREMENT ,
CNAME VARCHAR(200) ,
CITY VARCHAR(500) ,
SNUM INT, 
RATING INT,
PRIMARY KEY (CNUM) ,
FOREIGN KEY (SNUM) REFERENCES SALESPEOPLE(SNUM)  );
#CREATE ORDERS TABLE
CREATE TABLE Sales.ORDERS
(ONUM INT(10),
AMT NUMERIC(10,2) ,
SNUM INT, 
CNUM INT,
ODATE DATE,
FOREIGN KEY (SNUM) REFERENCES SALESPEOPLE(SNUM)  ,
FOREIGN KEY (CNUM) REFERENCES CUSTOMER(CNUM)  );

# insert records into customer
INSERT INTO customer
VALUES(2001,'KELVIN','SANJOSE',1007,200);
INSERT INTO customer
VALUES(2002,'GIOVANNI','ROME',1003,200);
INSERT INTO customer
VALUES(2003,'LIU','SANJOSE',1002,200);
INSERT INTO customer
VALUES(2004,'GRASS','BARLIN',1002,300);
INSERT INTO customer
VALUES(2006,'CLEMENS','LONDON',1001,100);
INSERT INTO customer
VALUES(2007,'PEREIRA','ROME',1004,100);
INSERT INTO customer
VALUES(2008,'CISNEROS','SANJOSE',1007,300);

#insert records into salespeople
INSERT INTO salespeople VALUES(1002,'SERRES','SANJOSE',14);
INSERT INTO salespeople VALUES(1003,'AXCELROD','NEW YORK',10);
INSERT INTO salespeople VALUES(1004,'MOTIKA','LONDON',11);
INSERT INTO salespeople VALUES(1005,'FRAN','LONDON',26);
INSERT INTO salespeople VALUES(1007,'RIKKLIN','BARCELONA',21);

#insert records into orders
INSERT INTO orders
VALUES (3001,	18.69	,1007	,2008	,'1996/03/10');
INSERT INTO orders
VALUES (3003	,890	,1001	,2001	,'1996/03/10');
INSERT INTO orders
VALUES (3002,	1900.1	,1004,	2007	,'1996/03/10');
INSERT INTO orders
VALUES (3005,	5160.45,	1002,	2003	,'1996/03/10');
INSERT INTO orders
VALUES (3006,	1098.16	,1007,	2008	,'1996/03/10');
INSERT INTO orders
VALUES (3009	,1713.23,	1003	,2002,'1996/04/10');
INSERT INTO orders
VALUES (3007,	75.75,	1003	,2002,'1996/04/10');
INSERT INTO orders
VALUES (3008,	4723	,1001	,2006,'1996/05/10');
INSERT INTO orders
VALUES (3010,	1309.95	,1002	,2004,'1996/06/10');
INSERT INTO orders
VALUES (3011,	9891.8,	1001,	2006,'1996/06/10');

#-1-Count the number of Non NULL rating fields in the Customers table (including repeats)
SELECT COUNT(CNUM) AS CountOfRating FROM customer WHERE !ISNULL(RATING);

#-2-Write a query that gives the names of both the salesperson and the customer for each order after the order number
SELECT ords.ONUM OrderNumber,spl.SNAME SalesPerson ,cst.CNAME Customer
FROM salespeople spl
INNER JOIN orders ords
ON spl.SNUM=ords.SNUM
INNER JOIN customer cst
ON cst.CNUM=ords.CNUM;

#-3-Count the number of Salespeople registering orders for each day. 
-- (If a salespersons has more than one order on given day, he or she should be counted only once).
SELECT IF(COUNT(DISTINCT onum)>1,1,COUNT(DISTINCT onum)) AS RegisteredOrder FROM orders GROUP BY odate;

#-4-Find all orders attributed to salespeople in London.
SELECT ords.ONUM,ords.AMT,ords.SNUM,ords.CNUM,ords.ODATE,spl.CITY
FROM orders ords
INNER JOIN salespeople spl
ON ords.SNUM=spl.SNUM
WHERE spl.CITY LIKE 'london';

#-5-Find all salespeople who have customers with more than one current order
SELECT spl.SNAME
FROM salespeople spl
INNER JOIN customer cst
ON cst.SNUM=spl.SNUM;

#-6-Write a query that selects all customers whose names begins with ‘C’.
SELECT * FROM customer cst
WHERE cst.CNAME LIKE 'C%';

#-7-Write a query on the Customers table that will find the highest rating in each city. 
-- Put the output in this form: for the City (city) the highest rating is: (rating)
SELECT MAX(RATING) FROM customer cst GROUP BY CITY;

#-8-Write a query that selects each customer’s smallest order.
SELECT cst.CNUM,cst.CNAME,MIN(ords.AMT) AS MinOrder
FROM orders ords
INNER JOIN customer cst 
ON ords.CNUM=cst.CNUM
GROUP BY cst.CNAME;
#-9-Write a query that selects the first customer in alphabetical order whose name begins with G
SELECT cst.CNAME
FROM customer cst
WHERE cst.CNAME LIKE 'G%'
ORDER BY cst.CNAME LIMIT 1;

#-10-Write a query that counts the number of different non NULL city values in the Customers table
SELECT COUNT(!ISNULL(CITY)) FROM customer GROUP BY CITY;

#-11-Find the average amount from the Orders table.
SELECT AVG(AMT) FROM orders;

#-12-Find all customers who are not located in San Jose and whose rating is above 200.
SELECT CNAME,CITY,RATING
FROM customer 
WHERE CITY NOT IN ('SANJOSE')
AND RATING > 200;

#-13-Does the customer who has placed the maximum number of orders have the maximum rating?
SELECT maxRecord.Employee, MAX(MaxOrder),MAX(MaxRating)
FROM (SELECT cst.CNUM AS Employee,COUNT(DISTINCT ords.ONUM) MaxOrder,MAX(cst.RATING) MaxRating
FROM customer cst
INNER JOIN orders ords
ON cst.CNUM=ords.CNUM
GROUP BY cst.CNUM
ORDER BY 2,3 ASC) AS maxRecord;

#-14-Find all records in the Customer table with NULL values in the city column
SELECT *
FROM customer 
WHERE CITY = NULL;

#-15-Arrange the Orders table by descending customer number.
SELECT *
FROM orders
ORDER BY CNUM DESC;

#-16-Find which salespeople currently have orders in the Orders table.
SELECT ords.SNUM,spl.SNUM,spl.SNAME,ords.ONUM
FROM orders ords,salespeople spl 
WHERE ords.SNUM=spl.SNUM 
GROUP BY ords.SNUM;

#-17-Find the names and numbers of all salespeople who had more the one customer.
SELECT spl.SNUM,spl.SNAME FROM salespeople spl 
WHERE 1 <  (SELECT COUNT(*) FROM customer WHERE SNUM=spl.SNUM);

#-18-Count the orders of each of the salespeople and output the results in descending order.
SELECT ords.snum, spl.SNAME,COUNT(ords.SNUM) CountOrders
FROM orders ords
INNER JOIN salespeople spl
ON ords.SNUM = spl.SNUM
GROUP BY spl.SNUM
ORDER BY ords.SNUM DESC;

#-19-List the Customer table if and only if one or more of the Customers in the Customer table are located in San Jose.
SELECT * FROM customer WHERE CITY = 'SANJOSE';

#-20-Find the largest order taken by each salesperson.
SELECT SNUM,MAX(AMT) LargestOrder FROM orders GROUP BY SNUM;

#-21-Find customers in San Jose who have a rating above 200.
SELECT *
FROM customer 
WHERE CITY = 'SANJOSE' AND RATING > 200;

#-22-List all the orders of salesperson Motika from the Orders table.
SELECT ords.*
FROM orders ords
INNER JOIN salespeople spl
ON ords.SNUM =spl.SNUM
WHERE spl.SNAME LIKE 'Motika';

#-23-Find salespeople who have multiple customers.
SELECT spl.*, COUNT(cst.SNUM) NoOfCutomers
FROM salespeople spl
INNER JOIN customer cst
ON spl.SNUM=cst.SNUM
WHERE 1 < (SELECT COUNT(*) FROM customer WHERE SNUM=spl.SNUM)
GROUP BY spl.SNUM;

#-24-Find salespeople with customers located in their city.
SELECT cst.cname CusomerName,cst.city CustomerCity,slp.sname SalespeopleName,slp.city SalespeopleCity
FROM salespeople slp,customer cst WHERE slp.city=cst.city;

#-25-Find the largest orders for serres and Rifkin.
SELECT ords.ONUM,MAX(ords.AMT) LargestOrder,slp.SNAME
FROM orders ords
INNER JOIN salespeople slp
ON ords.SNUM=slp.SNUM
WHERE slp.SNAME IN ('serres','Rikklin')
GROUP BY slp.SNAME;

#-26-Find all salespeople that are located in either Barcelona or London.
SELECT *
FROM salespeople
WHERE CITY='Barcelona' OR CITY='London';

#-27-Find all salespeople with only one customer.
SELECT * 
FROM salespeople 
WHERE SNUM IN (
   SELECT DISTINCT SNUM 
   FROM customer cst 
   WHERE NOT EXISTS (
      SELECT * FROM customer cstr 
      WHERE cst.CNUM=cstr.CNUM
      AND cst.CNAME<>cstr.CNAME));

#-28-Find salespeople whose sales is greater the avg sales

SELECT * FROM salespeople slp WHERE slp.COMM > (SELECT AVG(slpl.COMM) FROM salespeople slpl);
