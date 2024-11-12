-- part 2 of lab 6 qeuries 
-- 2.	Create the following schema and transfer the following tables to it 
--a.	Company Schema 
--i.	Department table (Programmatically)
--ii.	Project table (using wizard)
--b.	Human Resource Schema
--i.	  Employee table (Programmatically)
create schema company 
ALTER SCHEMA company TRANSFER dbo.Department

create schema HumanResource 
alter schema HumanResource  transfer dbo.Employee


--Write query to display the constraints for the Employee table.
--4.	Create Synonym for table Employee as Emp and then run 
--the following queries and describe the results

create synonym emp for HumanResource.Employee

	Select * from Employee
	--Invalid object name 'Employee'.
	Select * from HumanResource.Employee
	-- display the employee table
	Select * from emp
	-- display the employee table


	Select * from HumanResource.Emp
	-- Invalid object name 'HumanResource.Emp


	-- 5.	Increase the budget of the project where the manager number is 10102 by 10%.
update p set p.budget=1.1*p.budget from 
Works_On  w inner join Project p on w.ProjectNo=p.ProjectNo
where w.EmpNo=10102 and w.Job='manager'

-- 6.	Change the name 
--of the department for which the employee named James works.The new department name is Sales.

update d set d.DeptName ='Sales'  from HumanResource.Employee e inner join 
company.Department d on e.DeptNum=d.DeptNo
where e.empfname='James' and e.emplname='James' 



-- 7.	Change the enter date for the projects for those employees 
--who work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007.
update w set w.enter_date ='12.12.2007'
 from Works_On w inner join  HumanResource.Employee e on w.EmpNo=e.EmpNo 
inner join company.Department  d on 
e.DeptNum=d.DeptNo where ProjectNo='p1' and d.deptname='sales'


-- 8.	Delete the information in 
--the works_on table for all employees who work for the department located in KW.
delete w from Works_On  w inner join HumanResource.Employee e on w.EmpNo=e.empno
inner join company.Department d on e.deptNum=d.deptno where location='kw'

