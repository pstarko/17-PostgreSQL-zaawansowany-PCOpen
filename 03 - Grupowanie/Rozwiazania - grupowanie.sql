--1
select 
	max(salary), 
	min(salary),
	max(salary) - min(salary) diff 
from employees



--2
select
	job_id,
	round(avg(salary), 2) av
	from employees
where
	department_id not in (10,20, 50)
group by 
	job_id
order by av desc

--3
select 
	count(*) counter
	from employees
where job_id = 'IT_PROG'

--4
select
	department_id,
	sum(salary + (salary*coalesce(commission_pct,0)))
	from employees
where department_id is not null
group by department_id
order by 	
	case 
		when department_id = 110 then 9
		else department_id
	end
	

--5
select
	manager_id,
	min(salary) minimum
	from employees
where salary > 5000 and manager_id is not null
group by manager_id

--6
select 
	count(*) counter
	from employees
where
	lower(last_name) like '%o%' and
	lower(last_name) like '%r%'

--7
select
	department_id,
	ceiling(sum(salary) * power(1.1, 10)) result
	from employees
group by
	department_id
having 
	ceiling(sum(salary) * power(1.1, 10)) > 52673

--8
select 
	max(salary),
	min(salary)
	from employees
where
	hire_date > '2015-12-31'
	and manager_id in (100, 130)
--9
select
    department_id,
    count(commission_pct) counter
    from employees
where department_id is not null
group by department_id
order by department_id desc

--10
select
    department_id,
    count(commission_pct) counter_comm,
    count(*) ilosc
    from employees
group by department_id
having
    count(*)>10
order by department_id desc

--11
select
    department_id,
    job_id,
    max(salary) maksimum,
    round(avg(salary)) srednia
    from employees
where
    job_id in ('IT_PROG','SA_REP')
group by
    department_id,
    job_id
order by department_id desc,job_id

--12
select
    date_part('year', hire_date) "year",
    date_part('month', hire_date) "month",
    count(*) counter
    from employees
where 
	date_part('year', hire_date) in (2016)
	or (date_part('year', hire_date) in (2017) and date_part('month', hire_date) > 6)
group by
    date_part('year', hire_date),
    date_part('month', hire_date)
order by year

--13
select
    length(first_name || last_name) number_of_char,
    count(*) counter
    from employees
group by
    length(first_name || last_name)
order by 1 desc