
-- to get the top 2 salaries 
select top (3) St_Fname 
from Student where St_Address='alex'

select distinct top(2)  salary 
from Instructor 
order by Salary desc
-- with ties tail get the tail if there is 2 values the same 
select top(3) with ties *
from Student order by St_Age
-- newid global universal id 

-- select three random student from student table 
-- new id random 
-- order by random value 
select top(3)* from Student
order by NEWID()

select *  from Student order by NEWID()

select St_Fname+''+St_Lname as fullname from Student
where fullname='ahmed ali'

-- sol
select St_Fname+''+St_Lname as fullname from Student
where St_Fname='ahmed' and St_Lname='ali'

select *
from ( select St_Fname +' '+St_Lname as [fullname] from Student ) as newtable
where fullname='ahmed ali'


select St_Fname+''+St_Lname as fullname from Student
order by fullname


--execution order 
-- from tables
--join tables
--on tables
--where filter rows
-- group  create groups
-- having filter groups
-- select [distinct+agg]
-- order by
-- top

select Dept_Name from Department 
union all 
select dname from Company_SD.dbo.Departments
-- create an new table called students in another database on the same server from another table 
select * into company_Sd.dbo.Student 
from Student
-- we copy only the structure of the table not the table 
select * into tab4 from Student
where 1=2

-- to transfer the data not the strucure 
-- inset based on select 
-- the reseult set is into the table 
insert into tab4 
select * from Student


select sum(salary) from Instructor having COUNT(ins_id)<100


-- Ranking functions 
-- Row_number()


select *, ROW_NUMBER()over(order by st_fname desc ) as rn from Student

-- same will take the same rank 
select *, Dense_rank()over(order by st_fname desc ) as DR from Student


-- alias name cant be used in where 

-- this to use the alias names in the in where 
-- we use this rank functions in bussiness 
-- this allows us not to use a complex functions 
-- ranking funcions uses subquires 
-- inner quiries  then outer quires 

select * from (select *,ROW_NUMBER()over(order by st_fname desc) as rn ,
DENSE_RANK() over (order by st_fname desc   ) as dr  from Student ) as new_table  where rn=1 


-- ntiles_groups this allows us to group the table this will divide them into 

select * from ( select * , NTILE(3) 
over (order by st_fname desc) as nt from Student) as new 


--- partitioning like grouping but without hide rows 
-- this will partition by dept id 


select * from (
select * , ROW_NUMBER() over ( partition by dept_id order by st_id desc ) as rn 
,dense_rank() over (partition by dept_id order by st_id desc ) as dr 
from student ) as new_tabbb where rn =1

-- this will get the older student in the students table
select * from (select * , ROW_NUMBER() over (order by st_Age desc) as rn from Student
) as newww where rn =1
-- this will get the older student but with duplication 
select * from (
select * , Dense_rank() over (order by st_Age desc) as dr from Student) as new_table where dr =1
-- this will get  the older student in each depratment as we partioned by department  
select * from (select * , ROW_NUMBER() over (partition by dept_id order by st_Age desc) as rn from Student
) as newww where rn =1
-- this will dvivde the studentcolumn into 4 groups 
select * from (
select * , NTILE(4) over(order by st_age desc )as g from Student) as newwwwww 

-- - data types 

-- numerical datatype
--bit  -- bool            0:1              true:flase 
-- tinyint 1 byte -128:127       unsigned 0:255
-- smallint 2B -32768+32767 unsigned 0:65555
-- int 4B
-- bigint 8b 

-- decimal datatype
-- smallmoney 4b
-- real 
-- float 
-- decimal dec(5,2)  123.87

-- char dt
-- char fixed length 
-- varchar variable length character 
--nvarchar
-- ncahr unicode
------------ numeric datatype
-- Date MM/DD/YY
-- Time  hh:mm:ss
--time 
--datetime
-- offset you decide the time zone
-- binary dt
-- binary 
-- image 
------------------ others 
-- xml 
-- sql variant 
-- unique identifier 


-- if we want to condtion a column like instructors with salary more than 3000 then print high salary
-- and instructors with salaries less than 3000 write low 
-- else no value 
-- how can we do this in sql without if 
select Ins_Name,case 
when  Salary>=3000 then 'high salary'
when Salary <3000 then 'low salary'
else 'No value' 
end
from Instructor

-- we want to update the salary based on their salary
-- 

update Instructor
set Salary =
case 
when salary >= 30000 then Salary*1.10
else salary * 1.20
end

-- iif we can use this if we have if else not multiple if or multiple conditions
-- iif built in function
select Ins_Name,iif(salary>=3000,'high','low') from Instructor


-- the difference between convert and cast
select cast (getdate() as varchar(20))

select convert (varchar(20), getdate())
