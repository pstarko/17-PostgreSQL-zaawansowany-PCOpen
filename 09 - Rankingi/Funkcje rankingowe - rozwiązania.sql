
--1
select 
	e.last_name,
	e.salary,
	l.city,
	rank() over (order by e.salary DESC) rank
	from employees e join departments d on e.department_id=d.department_id
						  join locations l on d.location_id=l.location_id

						  

--2
select
	*
	from (
		select 
		    e.last_name,
		    e.salary,
		    l.city,
		    rank() over (order by e.salary) rank,
		    dense_rank() over (order by e.salary) rank_d
			from employees e join departments d on e.department_id=d.department_id
								  join locations l on d.location_id=l.location_id ) t1
where 
	t1.rank_d not in (4,5,8)
						  
--3
select
	*
	from (
		select 
		    e.last_name,
		    e.salary,
		    l.city,
		    rank() over (partition by l.city order by e.salary desc) rank,
		    dense_rank() over (order by e.salary) rank_d
			from employees e join departments d on e.department_id=d.department_id
								  join locations l on d.location_id=l.location_id ) t1
where 
	t1.rank in (1,2,3)


--4
select
	t1.department_name,
	t1.ilosc_pracownikow,
	case
		when t1.ilosc_pracownikow = (select max(t2.ilosc) from (select count(*) ilosc from employees group by department_id) t2)
			then 'Departament z największą ilością pracowników'
		when t1.ilosc_pracownikow = (select min(t2.ilosc) from (select count(*) ilosc from employees group by department_id) t2)
			then 'Departament z najniższą ilością pracowników'
		else t1.opis
	end	
	from (
		select 
		        d.department_name,
				COUNT(*) ilosc_pracownikow,
		        percent_rank() over (order by count(*) DESC)*100 || ' % departamentów z większą ilością pracowników' opis
		        from employees e join departments d on e.department_id=d.department_id
		group by d.department_name) t1


/*
5. Pokaż najlepiej zarabiającego pracownika w każdym mieście (7 wierszy) 
*/
select 
	t1.last_name, 
	t1.city 
	from (
		select 
				e.last_name,
				l.city,
				rank() over (partition by l.city order by salary DESC) ranking
				from employees e join departments d on e.department_id=d.department_id
								 join locations l on d.location_id = l.location_id ) t1
where 
	t1.ranking = 1


--6
select 
		d.department_name department_name,
		count(e.employee_id) ilosc,
		width_bucket(count(e.employee_id) , 0, 20, 4) podział_na_koszyki
		from employees e join departments d on e.department_id=d.department_id
group by d.department_name


--7
select 
	t1.last_name, 
	t1.salary  from (
					select 
						last_name,
						salary,
						rank() over (order by salary desc) rk
						from employees e
					union all
					select 
						last_name,
						salary,
						rank() over (order by salary) rk
						from employees e ) t1
where t1.rk =1

--8
select
	c.country_name ,
	l.city,
	count(e.employee_id),
	rank() over (order by count(e.employee_id) desc) rnk
	from employees e join departments d on e.department_id = d.department_id 
					 right join locations l on l.location_id = d.location_id 
					 right join countries c on c.country_id = l.country_id 
group by 
	c.country_name ,
	l.city