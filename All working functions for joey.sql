
--duplicate check by email

SELECT email_id_1, COUNT( * ) 
FROM table 
GROUP BY email_id_1 
HAVING COUNT( * ) > 1



--Mysql delete duplicate base on email but keep the longest row-sum-length record

CREATE TABLE tmp AS SELECT id FROM table1 t WHERE not exists 
(SELECT 1 FROM table tt WHERE tt.email_id_1=t.email_id_1 AND 
(char_length(tt.column1) + char_length(tt.column2))> (char_length(t.column1) + char_length(t.column2)));
 DELETE FROM table WHERE id not IN (SELECT id FROM tmp); 
 DROP TABLE tmp;




--Mysql delete duplicate if the length of the row are same

DELETE FROM customer_Mar09 
WHERE member_id NOT IN (SELECT * 
FROM (SELECT MAX(n.member_id) 
FROM customer_Mar09 n GROUP BY n.email_id_1) x)




--Insert Data from another table

INSERT INTO table1 
SELECT * FROM table2 t2
WHERE t2.id NOT IN (SELECT id FROM table1)


--Combine source based in email

SET session group_concat_max_len=10240000000000000; 
SET @@global.sql_mode= ''; 

INSERT INTO table1(column1,column2,column3) 

SELECT *, GROUP_CONCAT( source ) AS new_source FROM customer GROUP BY email_id_1

