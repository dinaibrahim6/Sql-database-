
/*
1.	Create the following tables 
with all the required information and 
load the required data as specified 
in each table using insert
statements[at least two rows]

Create it by code
2-Create a new user data type named loc with the following Criteria:
•	nchar(2)
•	default:NY 
•	create a rule for this Datatype :values in (NY,DS,KW)) and associate it to the 

*/

create rule rule_loc as @loc in ('NY','DS','KW')
create default def_loc as ('NY')
sp_addtype loc , 'nchar(2)'
sp_bindrule rule_loc,loc
sp_bindefault def_loc ,loc


create table Department (
DeptNo int primary key , DeptName varchar(20) , 
location loc)

insert into Department 
(DeptNo,DeptName,location) values
(1,'Research',	'NY'),
(2,'Accounting','DS'),
(3,	'Markiting','KW')




----------------------------------------------------------------------------
/*


-Create it by code
2-PK constraint on EmpNo
3-FK constraint on DeptNo
4-Unique constraint on Salary
5-EmpFname, EmpLname don’t accept null values
6-Create a rule 
on Salary column to ensure that
it is less than 6000 



*/

 create rule emp_sal  as @sal<6000
create table Employee(EmpNo int ,
EmpFname varchar(20) not null,
EmpLname varchar(20) not null,
DeptNum int , Salary int ,
constraint c1 primary key (EmpNo),
constraint c2 foreign key (DeptNum)
references Department(DeptNo),
constraint c3 unique (Salary),


)
 sp_bindrule emp_sal, 'Employee.Salary'

 insert into Employee (EmpNo,EmpFname,
 EmpLname,DeptNum,Salary) values (
 25348,	'Mathew'	,'Smith'	,3	, 2500),
(10102,'Ann','Jones',	3,	3000),
(18316,'John',	'Barrimore',	1,	2400),
(29346,	'James',	'James',	2,	2800),
(9031	,'Lisa'	,'Bertoni',	2,	4000),
(2581	,'Elisa'	,'Hansel',	2	,3600),
(28559	,'Sybl','Moser'	,1,	2900)


------------------------------------------

/*
1-Add new employee with EmpNo =11111 
In the works_on table [what will happen]


*/
--1-
insert into Works_On (EmpNo,ProjectNo) values(11111,'p3')
-- answer 
-- Msg 547, Level 16, State 0, Line 92
--The INSERT statement conflicted with the FOREIGN KEY 
--constraint "FK_Works_On_Employee". The conflict occurred in database "SDA", table "dbo.Employee", column 'EmpNo'.
--The statement has been terminated.
-- cannot insert a new employee in works on without being exist in the employee table 

/*

2-Change the employee number 10102  
to 11111  in the works on table [what will happen]

*/
update Works_On set works_on.EmpNo=11111
where works_on.EmpNo=10102

--The UPDATE statement conflicted with the FOREIGN KEY constraint "FK_Works_On_Employee".
-- The conflict occurred in database "SDA", table "dbo.Employee", column 'EmpNo'.


/*
3-Modify the employee number 10102 in 
the employee table to 22222. [what will happen]
*/

update Employee set EmpNo=22222
where EmpNo=10102

--The UPDATE statement conflicted 
--with the REFERENCE constraint "FK_Works_On_Employee". 
--The conflict occurred in database "SDA", table "dbo.Works_On", column 'EmpNo'.

/*  
4-Delete the employee with id 10102

*/
delete from Employee where EmpNo=10102


-- what happened
-- The DELETE statement conflicted with the REFERENCE constraint "FK_Works_On_Employee". 
--The conflict occurred in database "SDA", table "dbo.Works_On", column 'EmpNo'.

-- summerize what happened 
-- we can not add a child without parent this happend in number 
-- we can not modify child has a parent and parent has a child that happend in 2,3
-- we can not delete parent has child that happened in number 4 





-------------------------------------------------------------------------
--Table modification	1-Add  TelephoneNumber column to the employee table[programmatically]
-- 2-drop this column[programmatically]
 --  3-Bulid A diagram to show Relations between tables

 alter table employee add 
 TelephoneNumber varchar(15)

 alter table employee drop column
 TelephoneNumber 


 

