--1
select
	department_id,
	sum(salary) suma
	from employees
group by rollup(department_id)
having sum(salary) > 8000

--2
select
	case 
		when grouping(department_id) = 1 then 'Result'
		else department_id::char(10)
	end as department_id,
	sum(salary)
	from employees
group by rollup (department_id)
having sum(salary) > 8000

--3
select 
    department_id,
    job_id,
    sum(salary) sum
    from employees
where department_id between 10 and 50
group by cube (department_id, job_id)
having grouping(department_id) + grouping(job_id) <> 2


--4
select
	department_id,
	job_id,
	sum(salary)	
	from employees
where
	job_id not in ('AD_ASST','HR_REP','MK_MAN')
	and department_id in (90,100,110)
group by cube (department_id, job_id)
order by 
	grouping(department_id),
	grouping(job_id)
