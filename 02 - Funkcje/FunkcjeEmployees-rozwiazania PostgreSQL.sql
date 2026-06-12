--1
select 
	job_id, 
	employee_id, 
	concat(substring(job_id,1,2),employee_id) code 
from employees

--2
select 
	last_name, 
	replace(
		replace(
			replace(last_name, 'L','X')
									, 'M','X')
											, 'K','X') replace_, 
	translate(last_name, 'lmk','xxx') translate_ 
from employees

--3
select last_name, (salary + (salary * coalesce(commission_pct,0)))*1.15 more_money from employees
order by more_money desc

--4
show datestyle

select 
	last_name, 
	now()::date - hire_date diff ,
	CASE 
		WHEN now()::date - hire_date::date > 3500
		THEN 'Pracuje więcej niż 3500 dni'
		ELSE '---------'
		END result
	from employees
	

--5
select
ROUND(
((power((134%8 * sqrt(81))/244,4))+0.0097)::numeric, 4) result

/*
6. Pokaż last name w taki sposób, by ostatnie trzy litery były w odwróconej kolejności.

*/

select
	last_name,
	substring(last_name, 1, case 
								when length(last_name) - 3 < 0 then 0 
								else length(last_name) - 3 end) ||
	reverse(right(last_name, 3))
	from employees
	



/*
7. Wiedząc, że do emerytury trzeba pracować 30 lat pokaż dane: datę zatrudnienia, ile
lat pracy, ile lat do emerytury oraz informacje o tym, że ktoś już jest emerytem. Stan
na 17-04-2023.
*/

SELECT
   last_name,
   hire_date ,
   DATE_PART('year', age('2025-04-24', hire_date )) liczba_lat,
   10 - DATE_PART('year', age('2025-04-24', hire_date )) ile_do_premii,
   case
   		when 10 - DATE_PART('year', age('2025-04-24', hire_date )) < 0 then 'premiowany'
   		when 10 - DATE_PART('year', age('2025-04-24', hire_date )) = 0 then 'premia w tym roku'
   		else 'jeszcze ' || 10 - DATE_PART('year', age('2025-04-24', hire_date )) || ' lat/a'
   end   result
   from employees e 
																			
--8
SELECT
    last_name,
    case
    	when substring(last_name,2,1) = 'i' then replace(last_name,'i','XXX')
    	when substring(last_name,2,1) = 'o' then replace(last_name,'o','YYY')
    end zmiana    
FROM
    employees
where 
	substring(last_name,2,1) in ('i','o')


--9
select
	first_name, 
    last_name
FROM
    employees
where 
	position ('m' in concat(first_name , last_name))   > 0
	or position ('k' in concat(first_name , last_name))  > 0
	

--10
SELECT 
	last_name,
	to_char(hire_date, 'Month, Day, YYYY') hire_date,
	job_id,
	department_id,
	CONCAT(substring(job_id,2,1), 
	RIGHT(department_id::varchar, length(department_id::varchar))) code
	from employees
order by hire_date
