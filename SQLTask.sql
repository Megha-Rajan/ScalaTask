//creating table
CREATE TABLE contacts (  
id INT PRIMARY KEY,  
first_name VARCHAR(30) NOT NULL,  
last_name VARCHAR(25) NOT NULL,   
    email VARCHAR(210) NOT NULL,  
    age VARCHAR(22) NOT NULL  
); 

//inserting values
INSERT INTO contacts (id,first_name,last_name,email,age)   
VALUES (1,'Kavin','Peterson','kavin.peterson@verizon.net','21'),  
       (2,'Nick','Jonas','nick.jonas@me.com','18'),  
       (3,'Peter','Heaven','peter.heaven@google.com','23'),  
       (4,'Michal','Jackson','michal.jackson@aol.com','22'),  
       (5,'Sean','Bean','sean.bean@yahoo.com','23'),  
       (6,'Tom ','Baker','tom.baker@aol.com','20'),  
       (7,'Ben','Barnes','ben.barnes@comcast.net','17'),  
       (8,'Mischa ','Barton','mischa.barton@att.net','18'),  
       (9,'Sean','Bean','sean.bean@yahoo.com','16'),  
       (10,'Eliza','Bennett','eliza.bennett@yahoo.com','25'),  
       (11,'Michal','Krane','michal.Krane@me.com','25'),  
       (12,'Peter','Heaven','peter.heaven@google.com','20'),  
       (13,'Brian','Blessed','brian.blessed@yahoo.com','20'), 
       (14,'Kavin','Peterson','kavin.peterson@verizon.net','30');
       
       
SELECT * FROM contacts  
ORDER BY email;

METHOD-1

//SQL query returns the duplicate entries from the contact table
SELECT  first_name,last_name,email, COUNT(email)  
FROM  contacts  
GROUP BY  email  
HAVING  COUNT (email) > 1;

//SQL query to delete duplicates
DELETE FROM contacts WHERE email IN
(SELECT c1.email FROM contacts c1 INNER JOIN contacts c2 
Where c1.email = c2.email AND c1.id<c2.id) 

METHOD-2

//SQL query returns the duplicate entries from the contact table
SELECT *  
FROM (SELECT *,  
ROW_NUMBER() OVER (  
PARTITION BY email ORDER BY email) AS row_num  
FROM  
contacts  
) t  
WHERE  
row_num> 1; 

//SQL query to delete duplicates
WITH myTemp AS 
(SELECT *, ROW_NUMBER() OVER (PARTITION BY email ORDER BY email) AS RN  FROM  contacts)    
DELETE FROM myTemp WHERE RN > 1; 

METHOD-3

//SQL query returns the duplicate entries from the contact table
SELECT MIN(id) AS 'Id',first_name,last_name,email     
FROM contacts     
GROUP BY first_name,last_name,email
ORDER BY Id;


//SQL query to delete duplicates
DELETE FROM contacts WHERE Id NOT IN
(SELECT MIN(id) AS 'Id'     
FROM contacts     
GROUP BY first_name,last_name,email)