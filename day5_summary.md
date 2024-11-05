----Sumery and notes of lec 5 of database course 

TOP is used to specify the number of rows you want to retrieve, but it doesn’t sort the data on its own. Typically, you'll combine TOP with an ORDER BY clause to control which rows are selected (e.g., the "top 7 oldest students" if ordered by age).

TOP WITH TIES allows additional rows to be included if there are "ties" based on the value in the ORDER BY column(s). It's optional to use WITH TIES, and it only has an effect when ORDER BY is used.


To summarize:

TOP can work with or without ORDER BY.

WITH TIES needs ORDER BY to make sense since it depends on having "ties" in a specific column(s).


Here's an example that shows the difference:

-- Returns the top 7 rows without necessarily ordering them
SELECT TOP 7 * FROM Students;

-- Returns the top 7 rows, ordered by Age
SELECT TOP 7 * FROM Students ORDER BY Age;

-- Returns the top 7 rows, plus any additional rows with the same Age as the 7th row
SELECT TOP 7 WITH TIES * FROM Students ORDER BY Age;
Here's a structured summary of the main ranking functions in SQL,
highlighting key differences and uses. These functions can simplify complex queries, especially when yo
u're looking for specific ranks or positions in data, like the second-highest salary.

1. Ranking Functions Overview

Ranking functions are built-in SQL functions designed to assign a rank or order to each row within a result set. They are especially useful for business-related queries that would otherwise require complex joins or subqueries.

2. Main Ranking Functions

Each ranking function serves a specific purpose and behaves slightly differently, especially when handling duplicate values. Here’s an overview of the primary ranking functions:

ROW_NUMBER():

Purpose: Assigns a unique sequential number to each row, starting from 1, within each partition of a result set.

Use Case: Useful when you need a unique number for each row, such as when ordering records by a specific column without grouping ties together.

Example: ROW_NUMBER() OVER (ORDER BY Salary DESC)

This assigns a unique rank to each row based on salary, with no ties.



RANK():

Purpose: Similar to ROW_NUMBER, but ranks tied rows with the same rank and skips the next number(s) in the sequence for ties.

Use Case: When you want tied values to share the same rank and want gaps in the ranking for ties (e.g., ranking athletes where multiple people could have the same score).

Example: RANK() OVER (ORDER BY Salary DESC)

If two employees share the highest salary, both get rank 1, and the next rank would be 3.



DENSE_RANK():

Purpose: Similar to RANK(), but without gaps. Tied rows receive the same rank, and the next rank follows sequentially.

Use Case: Useful when you want ranks without gaps, such as ranking products based on sales where ties don’t skip numbers.

Example: DENSE_RANK() OVER (ORDER BY Salary DESC)

If two employees share the highest salary, both get rank 1, and the next rank is 2.



NTILE(n):

Purpose: Divides the result set into n roughly equal groups and assigns a rank to each row within its group.

Use Case: Useful for splitting data into percentiles, quartiles, or any equal divisions, like creating performance groups in employee evaluations.

Example: NTILE(4) OVER (ORDER BY Salary DESC)

This would divide the employees into four groups (or "tiles") based on salary, with each group receiving a unique tile number.




3. PARTITION BY and ORDER BY Clauses

PARTITION BY: Divides the result set into partitions, and the ranking function is applied separately within each partition.

ORDER BY: Determines the order of rows within each partition, affecting how ranks are assigned.

Example:

SELECT 
    EmployeeID, 
    Department, 
    Salary,
    RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DepartmentRank
FROM Employees;

This ranks employees within each department based on salary, giving insight into who has the highest salary per department.



4. Application Examples

Finding the second highest salary:

SELECT EmployeeID, Salary
FROM (
    SELECT EmployeeID, Salary, RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) AS RankedSalaries
WHERE SalaryRank = 2;

Identifying top employees in each department:

SELECT EmployeeID, Department, Salary
FROM (
    SELECT EmployeeID, Department, Salary, ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RowNum
    FROM Employees
) AS DepartmentTop
WHERE RowNum = 1;


Summary

ROW_NUMBER: Unique rank, no ties.

RANK: Ties share the same rank, gaps after ties.

DENSE_RANK: Ties share the same rank, no gaps.

NTILE: Divides data into n equal groups or tiles.

