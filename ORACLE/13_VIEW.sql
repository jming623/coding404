--view�� �������� �ڷḸ ���� ���ؼ� ����ϴ� ���̺��Դϴ�.
--��� ���������̺�(�������̺�)�� �̿��� �������̺��̱� ������ �ʿ��� �����͸� �����صθ� ��ȸ�� ������ �����ϴ�.
--�並 �̿��ؼ� �����Ϳ� �����ϸ� ���������ʹ� �����ϰ� ��ȣ�� �� �ֽ��ϴ�.

select * from user_role_privs; --���� ����ϴ� ������ ���� Ȯ��
--granted_role�� resource�� �Ǿ��ִ�. �ظ��Ѱ� �� �� �� �ִ�.

--�ܼ���(�ϳ��� ���̺��� �ʿ��� �����͸� ������ ��)
--���� �÷����� �Լ����� ����ǥ�������� �ȵ˴ϴ�. 
create /*or replace*/ view view_emp  --or replace�� ������ �Ⱥ����� ��.
as (select employee_id,
           first_name || ' ' || last_name as name, --�̷��̸��� ������� ���� ����������Ѵ�.
           job_id,
           salary
    from employees
    where department_id = 60
    );
    
select * from view_emp;




--���պ� (�������̺��� �����ؼ� �ʿ��� �����͸� ������ ��)
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

--�� ������ ���� �־��ش�.
select e.employee_id,
       e.first_name || ' ' || last_name as name,
       e.salary,
       d.department_name,
       j.job_title
from employees e
join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id;

--Ȯ��
select * from view_emp_dept_job order by employee_id;


--���� ���� (create or replace view)
--������ �̸����� ����� �����Ͱ� ����˴ϴ�.

create or replace view view_emp_dept_job
as(select e.employee_id,
          first_name || ' ' || last_name as name,
          e.hire_date, --�߰�
          e.salary,
          d.department_name,
          j.job_title
    from employees e
    join departments d on e.department_id = d.department_id
    join jobs j on e.job_id= j.job_id
   );
   
select * from view_emp_dept_job;

--�並 ������ �̿��ϸ� �����͸� ���� ��ȸ�� �� �ִ�.
select job_title, avg(salary)
from view_emp_dept_job
group by job_title;

--�� ����
drop view view_emp_dept_job;

--���� �������� 
--��� ���� ���� ��ȸ�� ���� ����Ѵ�. ���� ������ ���� ����.
--name����(first_name||' '||last_name)�� ���ϰ� �ִ� ��� ���ԺҰ�.
select * from view_emp;
insert into view_emp values(108,'test','IT_PROG',5000);
--last_name or hire_date���� �������̺��� null�� ������� �ʴ� �÷��� �ִٸ� ���� �Ұ�.
insert into view_emp (employee_id,job_id,salary) values(108,'IT_PROG',5000);
--���պ��� ��쿡 �ѹ��� ���� ���̺� ���� ������ �Ұ�.
select * from view_emp_dept_job;
insert into view_emp_dept_job
(employee_id, hire_date, salary, department_name, job_title)
values(300, sysdate, 8000, 'TEST', 'TEST');

--with check option (������ Į���� ������ ���� ����)
create or replace view view_emp_test
as(select employee_id, first_name,last_name,email,job_id,department_id
    from employees
    where department_id = 100)
with check option constraint view_emp_test_ck;

update view_emp_test set department_id = 60;
--department_id�� �����Ϸ��ϸ�  (WITH CHECK OPTION�� ���ǿ� ����) ���������� �ɸ���,������ �� ����.


--with read only(�б� ���� ��)
create or replace view view_emp_test
as(select employee_id,
          first_name|| ' ' ||last_name as name
   from employees) with read only;

--���� ��� ������ ������ �� ���� Ư���� ���Ἲ �������ǿ� ���� ������ ������ �� ������.
update view_emp_test set name = '����' where employee_id = 100; 

   

select * from view_emp_test;

