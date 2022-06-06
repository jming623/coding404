--데이터 행제한 where절

select * from employees;

select first_name, last_name, job_id, department_id from employees where job_id = 'IT_PROG';
select * from employees where first_name = 'Valli';
select * from employees where salary >= 15000;
select * from employees where department_id = 60;
select * from employees where hire_date >= '08/01/01'; --날짜 형식(년/월/일) 대소비교가 가능
select * from employees where hire_date = '08/01/24';

-- where 연산자 (between, in, like)
select * from employees where salary between 10000 and 20000;
select * from employees where hire_date between '05/01/01' and '05/12/31';

-- in연산자
select * from employees where manager_id in (101, 102, 103);
select * from employees where job_id in ('AD_ASST', 'FI_MGR', 'IT_PROG'); 

-- like연산자 (검색할때)
select * from employees where first_name like 'A%'; --A로 시작하는
select * from employees where hire_date like '05%'; --05로 시작하는
select * from employees where hire_date like '%15'; --15로 끝나는
select * from employees where hire_date like '%07%'; --07이 포함된
select * from employees where hire_date like '___07%'; -- (_는 위치를 의미함) 세칸띄고 07로시작하는

-- is null(null값 확인)
--select * from employees where commission_pct = null; (안됨)
select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

-- and, or조건 (and가 or보다 빠름)
select * from employees where job_id = 'IT_PROG' and salary >= 6000;
select * from employees where salary >= 10000 and salary <= 20000;
select * from employees where job_id = 'AD_VP' or salary >= 15000;
-- 우선순위를 결정하려면 ()를 이용하시면 됩니다.
select * from employees where (job_id = 'IT_PROG' or job_id = 'AD_VP') and salary >= 6000;


-- 데이터 정렬 order by문
select * from employees order by first_name asc;
select * from employees order by hire_date asc;
select * from employees order by hire_date desc;

select * from employees where job_id in ('IT_PROG', 'AD_VP') order by salary asc;
--급여가 5000이상들 중에서 직원아이디 기준으로 내림차순정렬
select * from employees where salary >= 5000 order by employee_id desc;
-- 커미션이 null이 아닌 사람들 직원아이디 기준으로 오름차순정렬
select * from employees where commission_pct is not null order by employee_id asc;

-- job_id기준 오름차순, 급여기준 내림차순 (여러 기준으로 정렬하려면 , )
select * from employees order by job_id asc, salary desc;

-- order by문에서 엘리어스 를 이용해서 정렬이 가능합니다.
select first_name || ' ' || last_name as 이름, 
       salary, 
       salary * 12 as 연봉  
from employees
order by 연봉 desc;



















