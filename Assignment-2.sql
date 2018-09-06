#Add Location as foreign key in resource table
ALTER TABLE resource ADD CONSTRAINT FK_resource FOREIGN KEY (location_id) REFERENCES location (location_id);
#create location table
CREATE TABLE location (
  location_id INT(11) NOT NULL,
  location_name VARCHAR(200) DEFAULT NULL,
  PRIMARY KEY (location_id));
#create resourcehour table with resource id foregin key
CREATE TABLE  resourcehour(
resourcehrs_ID INT NOT NULL ,
resourceid INT NOT NULL ,     
hours INT ,     
week_endDate DATE ,     
PRIMARY KEY (resourcehrs_ID));
ALTER TABLE  resourcehour ADD CONSTRAINT FK_ resourcehour FOREIGN KEY (resourceid) REFERENCES resource (id);
#create table project with location id as foreign key
CREATE TABLE project( 
projectid INT NOT NULL ,     
projectname VARCHAR(200) ,     
location_id INT ,     
PRIMARY KEY (projectid)  );

ALTER TABLE project ADD CONSTRAINT FK_project FOREIGN KEY (location_id) REFERENCES location (location_id);
#Insert records in location
INSERT INTO yashtechnology.location
VALUES (1,	"Indore");
INSERT INTO yashtechnology.location
VALUES (2,	"Pune");
INSERT INTO yashtechnology.location
VALUES (3,	"Banglore");
INSERT INTO yashtechnology.location
VALUES (4,	"Mumbai");
#insert records in project table and location with foreign key
INSERT INTO `yashtechnology`.`project`(`projectid`,`projectname`,`location_id`) VALUES ( 1,'project1',1);
INSERT INTO `yashtechnology`.`project`(`projectid`,`projectname`,`location_id`) VALUES ( 2,'project2',1);
INSERT INTO `yashtechnology`.`project`(`projectid`,`projectname`,`location_id`) VALUES ( 3,'project3',3);
INSERT INTO `yashtechnology`.`project`(`projectid`,`projectname`,`location_id`) VALUES ( 4,'project4',4);
#Insert all records where location as a foriegn key
INSERT INTO yashtechnology.resource          
VALUES (1,"Amol Nilkanth Bagal", "2014/01/20",1,1002899,1);
INSERT INTO yashtechnology.resource          
VALUES (2,"Manohar Singh","2012/9/10",8,1003927,1);
INSERT INTO yashtechnology.resource          
VALUES (3,"Nitish Aggarwal","2008/3/28",8,1001553,2);
INSERT INTO yashtechnology.resource          
VALUES (4,"Sonali Uttam Mane","2015/3/9",2,1000193,3);
INSERT INTO yashtechnology.resource          
VALUES (5,"Ruchi Soni","2015/3/26",3,1003719,1);
INSERT INTO yashtechnology.resource          
VALUES (6,"Kartik Dharmendra Jalgaonkar","2014/12/1",4,1003813,2);
INSERT INTO yashtechnology.resource          
VALUES (7,"Charu Dubey","2014/3/13",8,1003549,1);
INSERT INTO yashtechnology.resource          
VALUES (8,"Nikhil Bhagwantrao Raut","2014/5/19",6,1003054,2);
INSERT INTO yashtechnology.resource          
VALUES (9,"Vishal Khandu Kumkar","2012/5/25",7,1003177,1);
INSERT INTO yashtechnology.resource          
VALUES (10,"Isha Tiwari","2015/4/27",2,1003927,3);
INSERT INTO yashtechnology.resource          
VALUES (11,"Dharmendra Biswal","2015/4/30",5,1003999,2);
INSERT INTO `yashtechnology`.` resourcehour` (`resourcehrs_ID`,`resourceid`,`hours`,`week_endDate`)  VALUES ( 1,1,8,'2014/12/26');
INSERT INTO `yashtechnology`.`resourcehour`(`resourcehrs_ID`,`resourceid`,`hours`,`week_endDate`) VALUES ( '1','1','8','2014/12/26');
INSERT INTO `yashtechnology`.`resourcehour`(`resourcehrs_ID`,`resourceid`,`hours`,`week_endDate`) VALUES ( '2','2','9','2014/12/26');
INSERT INTO `yashtechnology`.`resourcehour`(`resourcehrs_ID`,`resourceid`,`hours`,`week_endDate`) VALUES ( '3','3','2','2014/12/26');
INSERT INTO `yashtechnology`.`resourcehour`(`resourcehrs_ID`,`resourceid`,`hours`,`week_endDate`) VALUES ( '4','4','3','2014/12/26');
INSERT INTO `yashtechnology`.`resourcehour`(`resourcehrs_ID`,`resourceid`,`hours`,`week_endDate`) VALUES ( '5','5','5','2015/06/26');
INSERT INTO `yashtechnology`.`resourcehour`(`resourcehrs_ID`,`resourceid`,`hours`,`week_endDate`) VALUES ( '6','2','8','2015/06/26');
INSERT INTO `yashtechnology`.`resourcehour`(`resourcehrs_ID`,`resourceid`,`hours`,`week_endDate`) VALUES ( '7','1','7','2015/06/26');
#List out resource name ,date_of_joining,location  of resource whose years_of_exp is more than 2 years	
SELECT rosc.NAME AS ResourceName, rosc.Date_Of_Joining AS DateOfJoining,loc.location_name AS Location
FROM resource AS rosc
INNER JOIN location AS loc
ON rosc.location_id=loc.location_id
WHERE rosc.Years_Of_Exp > 2;
#Find the employee which maximum experience

SELECT * FROM resource WHERE Years_Of_Exp 
=(SELECT MAX(Years_Of_Exp) FROM resource);

#Find the resource with Indore location 						
SELECT rosc.NAME AS ResourceName, loc.location_name AS Location
FROM resource AS rosc
INNER JOIN location AS loc
ON rosc.location_id=loc.location_id
WHERE loc.location_id=1;

#Find the resource name,hours ,location ,week_end_date	
SELECT rosc.NAME AS ResourceName, rs.hours AS Houres, loc.location_name AS Location,rs.week_endDate AS WeekEnds
FROM resource AS rosc
INNER JOIN location AS loc
ON rosc.location_id=loc.location_id
INNER JOIN resourcehour rs
ON rs.resourceid=rosc.id;
		
#Delete record from location table with location name as Mumbai	
#First Add Set Null for foreign key	
ALTER TABLE `yashtechnology`.`project` ADD CONSTRAINT `FK_project` 
FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE SET NULL ;
#then delete records
DELETE FROM location WHERE location_name LIKE 'Mumbai';

#Make listing of all the records from all the tables using inner join 			
SELECT rosc.id AS ResorceId,rosc.NAME AS ResourceName,rosc.Date_Of_Joining AS DateOfJoining,rosc.Years_Of_Exp AS ExperienceInYear,rosc.Yash_EmpID AS EmailId,
 pr.projectname AS ProjectName,loc.location_name AS Location,rs.week_endDate AS WeekEnds
FROM resource AS rosc
INNER JOIN location AS loc
ON rosc.location_id=loc.location_id
INNER JOIN project AS pr
ON pr.location_id=loc.location_id
INNER JOIN resourcehour rs
ON rs.resourceid=rosc.id;	
#Drop primary key  and foreign key constraint from project table (Drop constraint not the columns)						
ALTER TABLE project
DROP FOREIGN KEY FK_project;
ALTER TABLE project
DROP PRIMARY KEY;