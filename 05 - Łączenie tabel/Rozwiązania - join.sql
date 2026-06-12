--1
select
	e.first_name,
	e.last_name,
	e.department_id,
	j.job_title
	from employees e join jobs j on e.job_id = j.job_id
					 join departments d on e.department_id=d.department_id


--2
select
	e.first_name,
	e.last_name,
	l.city
	from employees e join departments d on e.department_id=d.department_id
					 join locations l on d.location_id=l.location_id
where
	l.city in ('Seattle','London')

	
--3
select 
	e.last_name,
	d.department_name 
	from employees e right join departments d on e.department_id =d.department_id
where 
	d.department_name != 'Operations'
order by d.department_name 

--4
select 
	l.city,
	count(e.employee_id) ilosc_pracownikow
	from employees e join departments d on e.department_id =d.department_id
					 right join locations l on d.location_id = l.location_id 
where l.city in ('Stretford',
					'Bombay',
					'Sydney',
					'London',
					'Munich',
					'Seattle')
group by l.city

--5
select
    count(*) counter   
    from employees e join departments d on  e.department_id = d.department_id
                     join locations l on l.location_id=d.location_id
where l.state_province like 'T%'

--6
select
    last_name,
    job_title,
    12*(salary + (salary * coalesce(commission_pct,0))) year_income
    from employees e join jobs j on e.job_id = j.job_id
where j.job_title in ('Accountant','Purchasing Clerk')
and 12*(salary + (salary * coalesce(commission_pct,0)))>37200

--7
select 
    e.first_name boss_first_name,
    e.last_name boss_last_name,
    d.department_name,
    l.city
    from employees e join departments d on e.employee_id = d.manager_id
    				 join locations l on d.location_id = l.location_id
	
--8
select 
    e.first_name boss_first_name,
    e.last_name boss_last_name,
    d.department_name,
    l.city
    from employees e right join departments d on e.employee_id = d.manager_id
    				 join locations l on d.location_id = l.location_id
	
--9
select
    d.department_name,
    count(*) counter,
    round(avg(e.salary),2) avg
    from employees e join departments d on  e.department_id = d.department_id
group by d.department_name


--10
select
    j.job_title,
    count(*) counter
    from employees e join jobs j on e.job_id = j.job_id    				 
group by 
    j.job_title
having 
	count(*) > 10
order by 2 desc


--11
select
    c.country_name,
    sum(coalesce(e.salary,0)) suma
    from employees e join departments d on  e.department_id = d.department_id
                     join locations l on l.location_id=d.location_id
                     right join countries c on l.country_id = c.country_id
group by 
	c.country_name 
order by suma desc










