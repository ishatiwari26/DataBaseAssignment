#Create Database
CREATE DATABASE YashTechnology;

#Create Table
CREATE TABLE yashtechnology.resource
(id INT(10) NOT NULL AUTO_INCREMENT ,
NAME VARCHAR(500) NOT NULL ,
Date_Of_Joining DATE NOT NULL , 
Years_Of_Exp INT ,
Yash_EmpID VARCHAR(500) NOT NULL ,
PRIMARY KEY (id)  );

#Insert all records
INSERT INTO yashtechnology.resource          
VALUES (1,"Amol Nilkanth Bagal", "2014/01/20",1,1002899);
INSERT INTO yashtechnology.resource          
VALUES (2,"Manohar Singh","2012/9/10",10,1001553);
INSERT INTO yashtechnology.resource          
VALUES (3,"Nitish Aggarwal","2008/3/28",2,1000193);
INSERT INTO yashtechnology.resource          
VALUES (4,"Sonali Uttam Mane","2015/3/9",3,1003719);
INSERT INTO yashtechnology.resource          
VALUES (5,"Ruchi Soni","2015/3/26",4,1003813);
INSERT INTO yashtechnology.resource          
VALUES (6,"Kartik Dharmendra Jalgaonkar","2014/12/1",8,1003549);
INSERT INTO yashtechnology.resource          
VALUES (7,"Charu Dubey","2014/3/13",6,1003054);
INSERT INTO yashtechnology.resource          
VALUES (8,"Nikhil Bhagwantrao Raut","2014/5/19",7,1003177);
INSERT INTO yashtechnology.resource          
VALUES (9,"Vishal Khandu Kumkar","2012/5/25",5,1001285);
INSERT INTO yashtechnology.resource          
VALUES (10,"Isha Tiwari","2015/4/27",2,1003927);
INSERT INTO yashtechnology.resource          
VALUES (11,"Dharmendra Biswal","2015/4/30",5,1003999);

#Update Years of exp Kartik  to 10 from 8
UPDATE resource AS rsc SET rsc.Years_Of_Exp=10 WHERE rsc.id=6;	
			
#Delete record of Vishal
DELETE FROM resource WHERE id=9;					

#Alter  table to add location column 
ALTER TABLE resource ADD location VARCHAR(500);					

#Make id as primary key	
ALTER TABLE resource ADD PRIMARY KEY (id);				

#Alter  table to drop column years_of_exp 
ALTER TABLE resource DROP COLUMN Years_Of_Exp;					

#Alter table to change the datatype of primary key column to Bigint
ALTER TABLE resource MODIFY COLUMN id BIGINT;		

#Write a select statement to view all the records from the table created
SELECT * FROM resource;					

#Write a select statement to view data in the increasing and decreasing order of date_of_joining	
SELECT * FROM resource ORDER BY Date_Of_Joining DESC;				
SELECT * FROM resource ORDER BY Date_Of_Joining ASC;
