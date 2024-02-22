drop table employees
create table employees(
emp_no int primary key,
emp_title_id varchar not null,
birth_date date,
first_name varchar not null,
last_name varchar not null,
sex varchar not null,
hire_date date


);
select * from employees



drop table departments
create table departments(

dept_no varchar primary key,
dept_name varchar not null
);
select * from departments


create table salaries(
emp_no int,
Foreign key (emp_no) references employees(emp_no),
salary int not null


);

select * from salaries


create table dept_emp(
emp_no int,
foreign key (emp_no) references employees(emp_no),
dept_no varchar,
foreign key (dept_no) references departments(dept_no)


);
select * from dept_emp


create table dept_manager(
dept_no varchar,
Foreign key (dept_no) references departments(dept_no),
emp_no int,
foreign key (emp_no) references employees(emp_no)

);

select * from dept_manager

drop table titles
create table titles(

title_id varchar not null,
title varchar not null
	
);

select * from titles


--Data Analysis

--List the employee number, last name, first name, sex, and salary of each employee.
select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
join salaries on employees.emp_no = salaries.emp_no;




--List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date
from employees
where hire_date between '1986-01-01' and '1986-12-31';


--List the manager of each department along with their department number, department name, employee number, last name, and first name.
select departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
from departments
join dept_manager
on departments.dept_no = dept_manager.dept_no
join employees
on dept_manager.emp_no = employees.emp_no;




--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp
join employees
on dept_emp.emp_no = employees.emp_no
join departments
on dept_emp.dept_no = departments.dept_no;


--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select first_name, last_name
from employees
where first_name = 'Hercules'
and last_name LIKE 'B%';


--List each employee in the Sales department, including their employee number, last name, and first name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp
join employees
on dept_emp.emp_no = employees.emp_no
join departments
on dept_emp.dept_no = departments.dept_no
where departments.dept_name = 'Sales';


--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp
join employees
on dept_emp.emp_no = employees.emp_no
join departments
on dept_emp.dept_no = departments.dept_no
where departments.dept_name = 'Sales' 
or departments.dept_name = 'Development';


--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select last_name,
count (last_name) as "frequency"
from employees
group by last_name
order by
count (last_name) desc;

