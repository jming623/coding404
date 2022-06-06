--view는 제한적인 자료만 보기 위해서 사용하는 테이블입니다.
--뷰는 물리적테이블(원본테이블)을 이용한 가상테이블이기 때문에 필요한 데이터만 저장해두면 조회에 이점을 가집니다.
--뷰를 이용해서 데이터에 접근하면 원본데이터는 안전하게 보호할 수 있습니다.

select * from user_role_privs; --지금 사용하는 계정의 권한 확인
--granted_role이 resource로 되어있다. 왠만한건 다 할 수 있다.

--단순뷰(하나의 테이블에서 필요한 데이터만 추출한 뷰)
--뷰의 컬럼명은 함수같은 가상표현형식은 안됩니다. 
create /*or replace*/ view view_emp  --or replace는 붙혀도 안붙혀도 됨.
as (select employee_id,
           first_name || ' ' || last_name as name, --이런이름은 엘리어스를 통해 정리해줘야한다.
           job_id,
           salary
    from employees
    where department_id = 60
    );
    
select * from view_emp;




--복합뷰 (여러테이블에을 조인해서 필요한 데이터만 저장한 뷰)
create or replace view view_emp_dept_job
as (select e.employee_id,
       e.first_name || ' ' || last_name as name,
       e.salary,
       d.department_name,
       j.job_title
    from employees e
    join departments d on e.department_id = d.department_id
    join jobs j on e.job_id = j.job_id
    );

--이 조건을 위에 넣어준다.
select e.employee_id,
       e.first_name || ' ' || last_name as name,
       e.salary,
       d.department_name,
       j.job_title
from employees e
join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id;

--확인
select * from view_emp_dept_job order by employee_id;


--뷰의 수정 (create or replace view)
--동일한 이름으로 만들면 데이터가 변경됩니다.

create or replace view view_emp_dept_job
as(select e.employee_id,
          first_name || ' ' || last_name as name,
          e.hire_date, --추가
          e.salary,
          d.department_name,
          j.job_title
    from employees e
    join departments d on e.department_id = d.department_id
    join jobs j on e.job_id= j.job_id
   );
   
select * from view_emp_dept_job;

--뷰를 적절히 이용하면 데이터를 쉽게 조회할 수 있다.
select job_title, avg(salary)
from view_emp_dept_job
group by job_title;

--뷰 삭제
drop view view_emp_dept_job;

--뷰의 수정제약 
--뷰는 보통 빠른 조회를 위해 사용한다. 거의 수정할 일이 없음.
--name가상열(first_name||' '||last_name)을 지니고 있는 경우 삽입불가.
select * from view_emp;
insert into view_emp values(108,'test','IT_PROG',5000);
--last_name or hire_date같이 원본테이블의 null을 허용하지 않는 컬럼이 있다면 삽입 불가.
insert into view_emp (employee_id,job_id,salary) values(108,'IT_PROG',5000);
--복합뷰의 경우에 한번에 여러 테이블에 대한 삽입이 불가.
select * from view_emp_dept_job;
insert into view_emp_dept_job
(employee_id, hire_date, salary, department_name, job_title)
values(300, sysdate, 8000, 'TEST', 'TEST');

--with check option (조건절 칼럼의 수정을 막는 제약)
create or replace view view_emp_test
as(select employee_id, first_name,last_name,email,job_id,department_id
    from employees
    where department_id = 100)
with check option constraint view_emp_test_ck;

update view_emp_test set department_id = 60;
--department_id를 변경하려하면  (WITH CHECK OPTION의 조건에 위배) 제약조건이 걸리며,변경할 수 없다.


--with read only(읽기 전용 뷰)
create or replace view view_emp_test
as(select employee_id,
          first_name|| ' ' ||last_name as name
   from employees) with read only;

--위에 뷰는 가상열은 수정할 수 없는 특성과 무결성 제약조건에 의해 원래도 수정할 수 없긴함.
update view_emp_test set name = '뭐요' where employee_id = 100; 

   

select * from view_emp_test;

