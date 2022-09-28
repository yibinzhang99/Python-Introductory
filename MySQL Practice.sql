-- create database company;

use company;

## Create Employee Table
create Table Employee(
emplid int Not null primary key auto_increment,
first_name varchar(25),
last_name varchar(25),
salary int,
joining_date datetime,
department_name varchar(25)
);

## check the schema
desc Employee;

## create `Bonus` table
create table Bonus(
emp_ref_id int,
bonus_amt int,
bonus_date datetime,
foreign key(emp_ref_id) references Employee(emplid)
on Delete cascade
);
desc bonus;

## create Employee Designation table
create table designation(
emp_ref_id int,
designation varchar(25),
designation_date datetime,
foreign key (emp_ref_id) references Employee(emplid)
on Delete Cascade
);
-- drop table designation;

## insert values into tables
insert into employee values
(0001, 'Krish','Naik', 50000, '14-12-11 09.00.00', 'Development'),
(0002, 'Sud','Kumar', 60000, '14-12-11 09.00.00', 'Development'),
(0003, 'San','Kumar', 70000, '14-12-12 09.00.00', 'HR'),
(0004, 'Dar','Ben', 70000, '14-12-13 09.00.00', 'HR'),
(0005, 'Sat','Bhan', 30000, '15-10-21 09.00.00', 'Accountant'),
(0006, 'Shak','Hero', 50000, '15-10-15 09.00.00', 'Accountant');

select * from employee;

insert into Bonus values
(0001, 5000, '16-03-14'),
(0002, 5000, '16-03-13'),
(0003, 5000, '16-03-15'),
(0003, 5000, '16-03-17'),
(0004, 3500, '16-03-19'),
(0005, 7000, '16-03-20'),
(0001, 8000, '16-03-21');

select * from bonus;

insert into designation values
(0001, 'Manager', '16-02-5 00:00:00'),
(0002, 'Executive', '16-06-11 00:00:00'),
(0003, 'Executive', '16-06-11 00:00:00');

select * from designation;

## delete specific rows
delete from designation
where emp_ref_id = 3;

## https://www.guru99.com/delete-and-update.html

# 1. retrieve all detials where first name from employee table which starts with "d"
select *
FROM employee
WHERE first_name like "d%";

# 2. print all detials of the employees whose salary btw 10000 to 35000
## We use 'concat()' in this case
select concat(first_name,' ', Last_name) as employee_name, salary
FROM employee 
WHERE emplid in 
	(select emplid from employee
	where salary BETWEEN 10000 and 35000);
    
# 3. retrive details of the employees who have join on a date
select * from employee
where year(joining_date) = "2015" AND day(joining_date) = 21;

# 4. fetch number of employees in every deparment
select count(*),department_name
from employee
GROUP BY department_name;

# 5. print details of employee who are also Executives
# Join info: https://www.w3schools.com/sql/sql_join.asp
select *
FROM employee e
JOIN designation d
on e.emplid = d.emp_ref_id
AND d.designation = "Executive";

# 6. clone a new table from another table
# https://learn.microsoft.com/en-us/sql/relational-databases/tables/duplicate-tables?view=sql-server-ver16
create table clone_employee like employee;
select * from clone_employee;
desc clone_employee;

# 7. show top n salary of employees
select * from employee 
order by salary desc
limit 4;

# 8. determine the 6th highest salary
select * from employee 
order by salary asc
# limit n-1,1
limit 3,1;