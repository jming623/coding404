--서브쿼리(where절에 들어가는) 
--서브쿼리 사용법
--1. ( )안에 반드시 작성함.
--2. 단일행 서브쿼리 절의 결과는 반드시 1행,1열 이어야 합니다.
--3. 조건절보다 오른쪽에 위치합니다.
--4. 중첩이 되면 안쪽에서부터 서브쿼리절을 먼저 해석하면 됩니다.

--낸시의 급여보다 월급을 많이 받는 사람을 조회

--낸시의 급여
select salary from employees where first_name = 'Nancy'; --12008

select * from employees where salary > 12008; --하면 낸시의 급여보다 많이 받는 사람들의 목록이 나올것이다.
--12008 자리에 12008이라는 값을 불러올 수있는 서브쿼리를 넣어준다

select * 
from employees
where salary > (select  salary from employees where first_name = 'Nancy');

--직원아이디가 103번 직원과 같은 job을 같는사람

--직원아이디가 103번인 사람의 job
select job_id from employees where employee_id = 103; --IT_PROG

select *
from employees
where job_id = (select job_id from employees where employee_id = 103);

-- 단일행 서브쿼리 절의 결과가 1열이 넘는 경우
select *
from employees
where job_id = (select job_id , first_name from employees where employee_id = 103);--(X)
--where job_id = IT_PROG, Alexander와 같은 뜻이 되는것임. 

-- 단일행 서브쿼리 절의 결과가 1행이 넘는 경우
--job_id가 it_prog인 직원
select first_name from employees where job_id = 'IT_PROG'; --Alexander,Bruce,David,Valli,Diana

select * 
from employees
where first_name = (select first_name from employees where job_id = 'IT_PROG');--(X)
--where first_name = Alexander,Bruce,David,Valli,Diana와 같은 뜻이 되는것임.
--(select first_name from employees where job_id = 'IT_PROG')에 리턴되는 값은 하나여야 한다.

--만약 여러행의 비교를 하고싶다면 어떻게 해야할까?
--다중행 서브쿼리 (in, any, all)

--in 다중행 서브쿼리에서 여러값중에 하나라도 일치하면 반환

select salary from employees where first_name='David'; --성이 데이빗인 사람들의 급여 
--성이 데이빗인 사람들의 급여와 같은 급여를 받는 모든사람
select * 
from employees
where salary in(select salary from employees where first_name='David');

--아까 위에 구문에 아래처럼 in을 써주면 오류가 해결된다.
select first_name from employees where job_id = 'IT_PROG';

select * 
from employees
where first_name in (select first_name from employees where job_id = 'IT_PROG');
--first_name이 IT_PROG라는 직업을 가진 모든 사람들의 first_name과 같은경우 

--any 최소값보다 크다, 최대값보다 작다.
--비교대상이 any보다 크다? 최소값보다 크다
--비교대상이 any보다 작다? 최대값보다 작다
select salary from employees where first_name = 'David'; --성이 데이빗인 사람들의 급여 4800,6800,9500이 나옴

--나는 급여가 4800보다 높은사람을 찾겠다.
select * 
from employees 
where salary > any(select salary from employees where first_name = 'David'); -- >any() 최소값(4800)보다 큰 경우

select *
from employees
where salary < any(select salary from employees where first_name = 'David'); -- <any() 최대값(9500)보다 작은 경우

--all 최대값보다 크다, 최소값보다 작다
--비교대상이 all보다 크다? 최대값보다 크다
--비교대상이 all보다 작다? 최소값보다 작다

select *
from employees
where salary > all(select salary from employees where first_name = 'David'); -- > all() 최대값(9500)보다 큰 경우

select * 
from employees
where salary < all(select salary from employees where first_name = 'David'); -- < all() 최소값(4800)보다 작은 경우

------------------스칼라 쿼리 (select 리스트에 select절이 들어가는 구문) ---------------------
--left outer join과 동일한 결과

select e.* ,
(select department_name from departments d where e.department_id=d.department_id)as department_name,
(select job_title from jobs j where e.job_id=j.job_id)as job_id
from employees e 
order by first_name desc;
--만약 left join으로 3개의 테이블을 조인하려면 훨씬 긴 구문으로 써야했을 것이다.

select e.*,
       d.department_name,
       j.job_title
from employees e
left outer join departments d on e.department_id=d.department_id
left outer join jobs j on e.job_id=j.job_id
order by e.first_name desc;

select * from jobs;

-- left join(부서장의 이름) manager_id를 구하겠다면?
select d.* , e. first_name
from departments d
left outer join employees e on d.manager_id = e.employee_id
order by d.department_id asc;

--위의 구문을 스칼라쿼리를 사용해서 만들어보자.
select d.*,
       (select concat(e.first_name||' ' ,e.last_name) from employees e where d.manager_id=e.employee_id)
from departments d; --왜 자동정렬이 될까? --concat, || 사용가능 



--스칼라 쿼리로 locations테이블의 city와 street_address를 department테이블과 붙혀서 출력해보세요.
select * from departments;
select * from locations;

select d.*,
       (select l.city from locations l where d.location_id = l.location_id)as city,
       (select l.street_address from locations l where d.location_id = l.location_id) as st
from departments d;

-- 각 부서별 사원수 --employee그룹핑
select * from employees;
select * from departments;

--방법1 departments테이블에 스칼라쿼리를 이용해서 employees테이블을 가져오는 동시에 그룹핑을 통해 사원수를 count로 구한다.
select d.*,
       nvl((select count(first_name) from employees e where d.department_id=e.department_id group by e.department_id),0) as 사원수
from departments d;

--방법2 employees테이블을 그룹핑해서 부서별 사원수를 구한뒤 스칼라쿼리를 이용해 departments테이블의 부서명을 가져온다.
select (select department_name from departments d where e.department_id=d.department_id) as 부서명,
       count(first_name) as 사원수       
from employees e
group by department_id;


-----------------인라인 뷰 (from절에 select문이 들어가는 형태 ,from절 이하문을 가상의 테이블로 생각하면됩니다.)-------------------------
select * from (select * from employees); --이런형태로 무한중첩이 가능

-- rownum이 섞이는 문제
select rownum, first_name , job_id , salary from employees 
order by salary;

--인라인뷰로 해결
select rownum , e.* from(select first_name , job_id , salary from employees order by salary) e;

--인라인뷰로 나온 결과에 대해서 10행까지만 출력
select rownum, a.*
from(select first_name , job_id , salary
     from employees
     order by salary) a
where rownum <= 10;

--인라인뷰로 나온결과에 대해서 10행~20행까지 출력
select rownum, a.*
from(select first_name , job_id , salary
     from employees
     order by salary) a
where rownum between 10 and 20 ; --결과 호출되지않음. 이유:rownum은 첫번째 행부터만 조회가 가능합니다.

--해결방법 다시한번 인라인뷰를 이용해서 rownum을 rownum특성이 작용하지않게 하나의 컬럼으로 뽑아오면 됨(3중 쿼리).
select first_name , job_id , salary from employees order by salary;
select rownum , a.* from(select first_name , job_id , salary from employees order by salary) a;

select * 
from(select rownum as rnum , a.* --굳이 rownum에 엘리어스를 사용하는 이유는 밖에서 rownum으로 그냥 호출하면 안쪽rownum인지 바깥쪽 rownum인지 구별이 안되기 때문인듯;;
        from(select first_name , job_id , salary from employees order by salary)
    a)
where rnum between 11 and 20 ; 

--정렬 방식
select * 
from(select rownum as rn,
      first_name,
      job_id,
      salary
      from(select *
            from employees
            order by salary)
      )
where rn > 10 and 20 > rn;



--인라인 뷰(이 가상테이블 기준, 03월01일 데이터만 추출.(where조건에 03-01로 조회할 수 있도록)
select *
from (select '홍길동' as name , '20200211' as test from dual union all
select '이순신' , '20200301' from dual union all
select '강감찬' , '20200314' from dual union all
select '김유신' , '20200403' from dual union all
select '홍길자' , '20200301' from dual )
where test like '%0301';

select *
from(select name,
     to_char(to_date(test,'YYYYMMDD'), 'MM-DD') as mm
     from(select '홍길동' as name , '20200211' as test from dual union all
         select '이순신' , '20200301' from dual union all
         select '강감찬' , '20200314' from dual union all
         select '김유신' , '20200403' from dual union all
         select '홍길자' , '20200301' from dual) 
    )
where mm = '03-01';

--응용 (join테이블의 위치로 인라인뷰 삽입가능 or 스칼라 퀴리와 혼합해서 사용가능.
--salary가 10000이상인 직원의 이름,부서명, 부서의주소 , 직업(job_title)을 출력.
--조건 salary기준으로 내림차순

select * from locations;
select * from jobs;
select * from departments;

select a.사원이름,
       a.부서명,      
       l.street_address as 주소,
       a.직무,
       a.월급 as 월급
from(select concat(e.first_name||' ',e.last_name)as 사원이름, 
    (select d.department_name from departments d where e.department_id = d.department_id) as 부서명,
    (select dd.location_id from departments dd where e.department_id = dd.department_id) as 부서아이디,
    (select j.job_title from jobs j where e.job_id = j.job_id)as 직무,
       e.salary as 월급
          from employees e
          where salary >= 10000
          order by salary desc) a
left outer join locations l on a.부서아이디 = l.location_id;

--1번 조인으로 만드는법
select e.first_name as 이름,
       d.department_name as 부서이름,
       l.street_address as 주소,
       j.job_title as 직무,
       e.salary as 월급
from employees e
left outer join departments d on d.department_id=e.department_id
left outer join locations l on d.location_id=l.location_id
left outer join jobs j on e.job_id = j.job_id
where salary >=10000
order by salary desc;

--2번 스칼라쿼리로만 만드는법
select e.first_name as이름,
       (select department_name from departments d where e.department_id = d.department_id) as 부서명,
       (select street_address from locations l 
            where(select location_id from departments d where e.department_id = d.department_id) = l.location_id) as주소, 
       (select job_title from jobs j where e.job_id=j.job_id) as직무
from employees e
where salary >= 10000; 

--3번 인라인뷰와 스칼라쿼리를 같이쓰는법
select a.first_name as 이름,
       a.department_name as 부서명,
       (select street_address from locations l where a.location_id = l.location_id) as 주소,
       (select job_title from jobs j where a.job_id=j.job_id)as 직무
from(select *
     from employees e
     left outer join departments d
     on e.department_id = d.department_id
     where salary >= 10000
) a;


--정리
--where절에 들어가는 서브쿼리문 단일행 vs 다중행(in,any,all)

--스칼라쿼리 -select리스트에 들어가는 서브쿼리(단일 행의 결과로 쓰여야함,left outer join과 같은역할)
  --한테이블에서 하나의 행만 불러오고싶다면 스칼라쿼리가 유용

--인라인 뷰 - from절에 들어가는 서브쿼리(안쪽에서 필요한 쿼리문을 작성, 가상테이블의 형태)
  --불러오고자하는 행이 많다면 인라인뷰가 유용
  
  
  
  