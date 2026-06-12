--1
select
	first_name,
	last_name,
	(salary+(COALESCE(commission_pct,0) * salary))*12 roczna_placa
from employees

--2
select
	*
	from departments
order by department_name

--3
select
	DISTINCT job_id
	from employees
where department_id not in (20, 50)


--4
select
	*
	from employees
where
	job_id IN ('AC_ACCOUNT', 'FI_ACCOUNT')
order by hire_date DESC

--5
select
	employee_id,
	last_name,
	job_id
	from employees
where
	department_id in (30,40)
order by salary

--6
select
	last_name,
	salary
	from employees
where
	salary not between 8000 and 15000

--7
select
	last_name,
	job_id,
	department_id
	from employees
where
	last_name like '%an'

--8
select
	last_name,
	salary
	from employees
where
	manager_id is not null
	and salary > 10000

--9
select
	last_name,
	job_id,
	salary/20/8 per_hour
	from employees
where
	job_id not in('AD_VP','PU_CLERK','SA_MAN')
	and salary between 5000 and 20000
order by per_hour

--10
select
	first_name,
	last_name
	from employees
where
	first_name like '%a'
	and commission_pct is not null
order by 2

--11
select
	first_name,
	last_name,
	job_id,
	department_id
	from employees
where
	manager_id = 102 and department_id = 60
	or
	manager_id = 120 and department_id = 50
	

--12
select
	first_name,
	last_name,
	salary+(COALESCE(commission_pct,0) * salary) pensja,
	((salary+(COALESCE(commission_pct,0) * salary)) / 4) odkladaja_co_miesiac
	--((salary+(COALESCE(commission_pct,0) * salary)) / 4) * 12 *5
	from employees
where
	 ((salary+(COALESCE(commission_pct,0) * salary)) / 4) * 12 *5 > 200000

--13
select
	*
	from jobs
where
	10000 between min_salary and max_salary