--1
select
	e.first_name,
	e.last_name,
	j.job_title
	from employees e join jobs j on e.job_id = j.job_id
where
	e.department_id = 
	(select department_id 
		from employees where last_name ='Miller')

--2
select
	e.first_name ,
	e.last_name,
	e.job_id
	from employees e
where hire_date = 
		(
			select min(hire_date) from employees
			where job_id = 'FI_ACCOUNT')
and job_id = 'FI_ACCOUNT'

/*
3. Zobacz najdłużej pracujących pracowników każdego działu. (12 wierszy)
*/

select 
	e.last_name ,
	e.hire_date ,
	d.department_id ,
	d.department_name 
	from employees e join departments d on e.department_id = d.department_id 
where 
	(e.department_id, hire_Date) in (
								select 
									department_id,
									min(hire_Date)
									from employees e 
								group by department_id )


--4
select * from jobs
where
	job_id in (select job_id from employees
					where department_id not in (select department_id
												from departments
												where 
												department_name='Marketing'))
												
--5
select 
	e.first_name, 
	e.last_name, 
	e.salary,
	(select job_title from jobs j where e.job_id = j.job_id) job_title,
	(select avg(emp.salary) from employees emp where emp.job_id = e.job_id) avg_jobs_salary
        from employees e
where salary > (select avg(salary) from employees
                    where job_id = e.job_id)



--6
select 
	e.last_name,
	e.email,
	e.department_id,
	(select first_name || ' ' || last_name from employees where
		employee_id = e.manager_id) Boss
	from employees e 
where 
	job_id in 
				(select 
					job_id
					from jobs j 
					where lower(job_title) like '%sales%')					
	and manager_id != (select employee_id from employees
						where first_name = 'John' and last_name = 'Singh')
												
--7
select
    e.first_name,
    e.last_name
    from employees e 
    where not exists (select 1 from departments dd where dd.department_id = e.department_id)
	
	
--8
select 
	(select department_name from departments d where d.department_id = e.department_id) department_name
	from employees e 
		group by department_id 
		having 
			sum(salary) = 
				(select max(salary) 
						from (					
							select 
								sum(salary) salary
								from employees e 
							group by department_id) t1 )		

									
--9
select
    e.first_name,
    e.last_name,
    e.department_id
    from employees e 
where e.salary 
    not between (select min_salary from jobs
                            where job_title = 'Sales Representative')
                            and (select max_salary from jobs
                            where job_title = 'Sales Representative')
    and department_id not in (select department_id from departments 
    							where department_name = 'Shipping')	
order by 1


--10
select 
	last_name,
	salary
from employees e 
where 
	department_id in (
		select 	
			department_id 
			from departments d
		where 
			location_id in (select location_id from locations l 
								where l.city in ('Toronto', 'Oxford','Munich')))
and salary > 10000
and position ('y' in last_name) > 0


