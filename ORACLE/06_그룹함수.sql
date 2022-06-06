--그룹(집계)함수 SUM , AVG, MIN ,MAX, COUNT 
SELECT SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(SALARY) FROM EMPLOYEES;

SELECT SUM(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 50; --부서가 50인 사람들의 월급의 합

SELECT COUNT(*) FROM EMPLOYEES;--EMPLOYEES테이블의 전체 행 수
SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES; --COMMISSION_PCT중 NULL이 아닌 행의 갯수
SELECT COUNT(MANAGER_ID) FROM EMPLOYEES;--MANAGER_ID의 값중 NULL이 아닌 행의 갯수

-- 그룹함수는 일반 컬럼과 같이 쓸 수 없다.
--EX) SELECT SUM(SALARY), SALARY FROM EMPLOYEES (X)

--group by절

-- 단, GROUP BY와 함께있다면 GROUPING할 일반 컬럼은 그룹함수와 함께 쓸 수 있다. 
-- EX) department_id , avg(salary) from employees group by dipartment_id; (O) 

select job_id  from employees group by job_id; --job_id별 그룹핑
select job_id , salary from employees group by job_id; --(X)
--job_id를 그룹핑했으니 select뒤에 쓸 수 있음 다른 컬럼은 사용불가능

select job_id , avg(salary) from employees group by job_id; --job_id별 급여평균

select department_id , avg(salary), sum(salary) , count(salary) from employees group by department_id; --부서별 급여 평균

--주의할점
--그룹핑이 되지 않으면 그룹함수와 일반컬럼을 동시에 사용하지 못함.
select count(*), job_id from employees; --(X)
--group by 절을 사용할 때 group절에 묶이지 않으면 다른 커럼 조회를 할 수 없음.
select job_id from employees group by department_id; --(X)

--2개 이상의 group by절

select * from employees;

select department_id , job_id , count(job_id) from employees group by department_id, job_id
order by department_id asc;
--department_id로 그룹핑을 한번하고 다시 job_id별로 그룹핑을 하였다.

select department_id , job_id , avg(salary)
from employees
group by department_id, job_id
order by department_id asc;

-- group by 절의 조건 having(where절은 일반행에 대한 조건)

select department_id, sum(salary)
from employees
group by department_id
having sum(salary) > 100000;
 
 --job_id별 개수
select job_id , count(*)
from employees 
group by job_id
having count(*) >= 5
order by count(*) desc;

--부서아이디가 50이상인 행을 그룹핑하고 ,부서별 평균급여 5000이상만 조회,정렬

select department_id, trunc(avg(salary)) as 평균급여
from employees
group by department_id
having trunc(avg(salary))  >= 5000 and department_id >= 50
order by trunc(avg(salary)) desc;


--내풀이
select department_id as 부서 , trunc(avg(salary)) as 평균급여 from employees
group by department_id
having department_id >=50 and avg(salary) >= 5000 
order by department_id asc;

--선생님 풀이
select department_id, avg(salary) as 부서평균 
from employees
where department_id >= 50
group by department_id
having avg(salary) >= 5000
order by 부서평균 desc;

--아래와 같이 그룹함수에 over()를 넣어서 일반함수와 함께 사용할 수도 있는데 지금은 행이얼마안되서 괜찮지만 
--로딩하는 속도가 느려 사용하게 될 일이 없을 가능성이 높음 
--count(*)over() 그룹화 하지 않아도, 예외적으로 총 행의 수를 붙여서 조회하는 구문입니다. (알아만둘것) 
select department_id , first_name, count(*)over() , avg(salary)over() from employees;


