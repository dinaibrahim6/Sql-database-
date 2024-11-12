
-- 1.	Retrieve number of students who have a value in their age. 
select count(St_id) from Student where St_Age is not null
-- 2.	Get all instructors Names without repetition
select distinct Ins_Name  from Instructor

--  3.	Display student with the following Format (use isNull function)
--             Student ID	Student Full Name	Department name
select isnull(St_Id ,' ') as 'Student ID', isnull (St_Fname,' ')+' '+
isnull(St_Lname,' ') as [Student Full Name] ,isnull(d.Dept_Name,' ') as[Department Name]
from Student s full join Department d on  s.Dept_Id=d.Dept_Id

-- 4.	Display instructor Name and Department Name 
--Note: display all the instructors if they are attached to a department or not
select Ins_Name , Dept_Name from Instructor i left join  Department d on i.Dept_Id=d.Dept_Id
-- 5.	Display student full name and the name of the course he is taking
-- For only courses which have a grade  
select s.St_Fname+' '+ s.St_Lname as [Full Name] , 
c.Crs_Name as [Course Name] 
from Student s inner join Stud_Course sc
on s.St_Id=sc.St_Id inner join Course c
on  c.Crs_Id=sc.Crs_Id
where Grade is not null 
-- 6.	Display number of courses for each topic name
 select Top_Name, COUNT(Crs_Id) as 'number of courses for each topic'
 from Course c inner join Topic t
 on c.Top_Id=t.Top_Id group by t.Top_Name
 

 -- 7.	Display max and min salary for instructors

 select MIN(salary) as 'minimum Salary',max(salary) as 'maximum salary' 
 from Instructor
-- 8.	Display instructors who have salaries less than the average salary of all instructors.
select Ins_Id,Ins_Name from Instructor where
Salary<(select avg(salary ) from Instructor)
-- 9.	Display the Department name that contains the instructor who receives the minimum salary.
select Dept_Name,d.Dept_Id,Ins_Id,Ins_Name 
from Department d inner join Instructor i on 
d.Dept_Id=i.Dept_Id where i.Salary= 
(select min(salary) from Instructor)

-- 10.	 Select max two salaries in instructor table. 

select top (2) Salary from Instructor order by Salary desc 

-- 11.	 Select instructor name and his salary but if there is no salary display 
--instructor bonus. “use one of coalesce Function”

select Ins_Name , coalesce
(convert(nvarchar(20),salary) ,'instructor bonus') 
as 'Salary' from Instructor
-- 12.	Select Average Salary for instructors 
select avg(salary) as'average salary' from Instructor
select sum(salary)/ COUNT(ins_id) from Instructor

-- 13.	Select Student first name and the data of his supervisor 

select s1.St_Fname as [student first name] , 
s2.* from Student s1 , Student s2 where
s1.St_super=s2.St_Id

-- 14.	Write a query to select the highest two salaries 
--in Each Department for instructors who have salaries. “using one of Ranking Functions”

select Salary,Dept_Id from (select *, 
ROW_NUMBER() 
over ( partition by dept_id order by salary desc) 
as Rn from Instructor
 where salary is not null ) as new_tabb 
where rn <3

-- 15.	 Write a query to select a random  student from each department. 
-- “using one of Ranking Functions”

select * from 
(select *  , ROW_NUMBER() over (partition by dept_id order by NEWID()) as rn  from Student) as new_tab
where rn =1




