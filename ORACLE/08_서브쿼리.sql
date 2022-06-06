--��������(where���� ����) 
--�������� ����
--1. ( )�ȿ� �ݵ�� �ۼ���.
--2. ������ �������� ���� ����� �ݵ�� 1��,1�� �̾�� �մϴ�.
--3. ���������� �����ʿ� ��ġ�մϴ�.
--4. ��ø�� �Ǹ� ���ʿ������� ������������ ���� �ؼ��ϸ� �˴ϴ�.

--������ �޿����� ������ ���� �޴� ����� ��ȸ

--������ �޿�
select salary from employees where first_name = 'Nancy'; --12008

select * from employees where salary > 12008; --�ϸ� ������ �޿����� ���� �޴� ������� ����� ���ð��̴�.
--12008 �ڸ��� 12008�̶�� ���� �ҷ��� ���ִ� ���������� �־��ش�

select * 
from employees
where salary > (select  salary from employees where first_name = 'Nancy');

--�������̵� 103�� ������ ���� job�� ���»��

--�������̵� 103���� ����� job
select job_id from employees where employee_id = 103; --IT_PROG

select *
from employees
where job_id = (select job_id from employees where employee_id = 103);

-- ������ �������� ���� ����� 1���� �Ѵ� ���
select *
from employees
where job_id = (select job_id , first_name from employees where employee_id = 103);--(X)
--where job_id = IT_PROG, Alexander�� ���� ���� �Ǵ°���. 

-- ������ �������� ���� ����� 1���� �Ѵ� ���
--job_id�� it_prog�� ����
select first_name from employees where job_id = 'IT_PROG'; --Alexander,Bruce,David,Valli,Diana

select * 
from employees
where first_name = (select first_name from employees where job_id = 'IT_PROG');--(X)
--where first_name = Alexander,Bruce,David,Valli,Diana�� ���� ���� �Ǵ°���.
--(select first_name from employees where job_id = 'IT_PROG')�� ���ϵǴ� ���� �ϳ����� �Ѵ�.

--���� �������� �񱳸� �ϰ�ʹٸ� ��� �ؾ��ұ�?
--������ �������� (in, any, all)

--in ������ ������������ �������߿� �ϳ��� ��ġ�ϸ� ��ȯ

select salary from employees where first_name='David'; --���� ���̺��� ������� �޿� 
--���� ���̺��� ������� �޿��� ���� �޿��� �޴� �����
select * 
from employees
where salary in(select salary from employees where first_name='David');

--�Ʊ� ���� ������ �Ʒ�ó�� in�� ���ָ� ������ �ذ�ȴ�.
select first_name from employees where job_id = 'IT_PROG';

select * 
from employees
where first_name in (select first_name from employees where job_id = 'IT_PROG');
--first_name�� IT_PROG��� ������ ���� ��� ������� first_name�� ������� 

--any �ּҰ����� ũ��, �ִ밪���� �۴�.
--�񱳴���� any���� ũ��? �ּҰ����� ũ��
--�񱳴���� any���� �۴�? �ִ밪���� �۴�
select salary from employees where first_name = 'David'; --���� ���̺��� ������� �޿� 4800,6800,9500�� ����

--���� �޿��� 4800���� ��������� ã�ڴ�.
select * 
from employees 
where salary > any(select salary from employees where first_name = 'David'); -- >any() �ּҰ�(4800)���� ū ���

select *
from employees
where salary < any(select salary from employees where first_name = 'David'); -- <any() �ִ밪(9500)���� ���� ���

--all �ִ밪���� ũ��, �ּҰ����� �۴�
--�񱳴���� all���� ũ��? �ִ밪���� ũ��
--�񱳴���� all���� �۴�? �ּҰ����� �۴�

select *
from employees
where salary > all(select salary from employees where first_name = 'David'); -- > all() �ִ밪(9500)���� ū ���

select * 
from employees
where salary < all(select salary from employees where first_name = 'David'); -- < all() �ּҰ�(4800)���� ���� ���

------------------��Į�� ���� (select ����Ʈ�� select���� ���� ����) ---------------------
--left outer join�� ������ ���

select e.* ,
(select department_name from departments d where e.department_id=d.department_id)as department_name,
(select job_title from jobs j where e.job_id=j.job_id)as job_id
from employees e 
order by first_name desc;
--���� left join���� 3���� ���̺��� �����Ϸ��� �ξ� �� �������� ������� ���̴�.

select e.*,
       d.department_name,
       j.job_title
from employees e
left outer join departments d on e.department_id=d.department_id
left outer join jobs j on e.job_id=j.job_id
order by e.first_name desc;

select * from jobs;

-- left join(�μ����� �̸�) manager_id�� ���ϰڴٸ�?
select d.* , e. first_name
from departments d
left outer join employees e on d.manager_id = e.employee_id
order by d.department_id asc;

--���� ������ ��Į�������� ����ؼ� ������.
select d.*,
       (select concat(e.first_name||' ' ,e.last_name) from employees e where d.manager_id=e.employee_id)
from departments d; --�� �ڵ������� �ɱ�? --concat, || ��밡�� 



--��Į�� ������ locations���̺��� city�� street_address�� department���̺�� ������ ����غ�����.
select * from departments;
select * from locations;

select d.*,
       (select l.city from locations l where d.location_id = l.location_id)as city,
       (select l.street_address from locations l where d.location_id = l.location_id) as st
from departments d;

-- �� �μ��� ����� --employee�׷���
select * from employees;
select * from departments;

--���1 departments���̺� ��Į�������� �̿��ؼ� employees���̺��� �������� ���ÿ� �׷����� ���� ������� count�� ���Ѵ�.
select d.*,
       nvl((select count(first_name) from employees e where d.department_id=e.department_id group by e.department_id),0) as �����
from departments d;

--���2 employees���̺��� �׷����ؼ� �μ��� ������� ���ѵ� ��Į�������� �̿��� departments���̺��� �μ����� �����´�.
select (select department_name from departments d where e.department_id=d.department_id) as �μ���,
       count(first_name) as �����       
from employees e
group by department_id;


-----------------�ζ��� �� (from���� select���� ���� ���� ,from�� ���Ϲ��� ������ ���̺�� �����ϸ�˴ϴ�.)-------------------------
select * from (select * from employees); --�̷����·� ������ø�� ����

-- rownum�� ���̴� ����
select rownum, first_name , job_id , salary from employees 
order by salary;

--�ζ��κ�� �ذ�
select rownum , e.* from(select first_name , job_id , salary from employees order by salary) e;

--�ζ��κ�� ���� ����� ���ؼ� 10������� ���
select rownum, a.*
from(select first_name , job_id , salary
     from employees
     order by salary) a
where rownum <= 10;

--�ζ��κ�� ���°���� ���ؼ� 10��~20����� ���
select rownum, a.*
from(select first_name , job_id , salary
     from employees
     order by salary) a
where rownum between 10 and 20 ; --��� ȣ���������. ����:rownum�� ù��° ����͸� ��ȸ�� �����մϴ�.

--�ذ��� �ٽ��ѹ� �ζ��κ並 �̿��ؼ� rownum�� rownumƯ���� �ۿ������ʰ� �ϳ��� �÷����� �̾ƿ��� ��(3�� ����).
select first_name , job_id , salary from employees order by salary;
select rownum , a.* from(select first_name , job_id , salary from employees order by salary) a;

select * 
from(select rownum as rnum , a.* --���� rownum�� ������� ����ϴ� ������ �ۿ��� rownum���� �׳� ȣ���ϸ� ����rownum���� �ٱ��� rownum���� ������ �ȵǱ� �����ε�;;
        from(select first_name , job_id , salary from employees order by salary)
    a)
where rnum between 11 and 20 ; 

--���� ���
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



--�ζ��� ��(�� �������̺� ����, 03��01�� �����͸� ����.(where���ǿ� 03-01�� ��ȸ�� �� �ֵ���)
select *
from (select 'ȫ�浿' as name , '20200211' as test from dual union all
select '�̼���' , '20200301' from dual union all
select '������' , '20200314' from dual union all
select '������' , '20200403' from dual union all
select 'ȫ����' , '20200301' from dual )
where test like '%0301';

select *
from(select name,
     to_char(to_date(test,'YYYYMMDD'), 'MM-DD') as mm
     from(select 'ȫ�浿' as name , '20200211' as test from dual union all
         select '�̼���' , '20200301' from dual union all
         select '������' , '20200314' from dual union all
         select '������' , '20200403' from dual union all
         select 'ȫ����' , '20200301' from dual) 
    )
where mm = '03-01';

--���� (join���̺��� ��ġ�� �ζ��κ� ���԰��� or ��Į�� ������ ȥ���ؼ� ��밡��.
--salary�� 10000�̻��� ������ �̸�,�μ���, �μ����ּ� , ����(job_title)�� ���.
--���� salary�������� ��������

select * from locations;
select * from jobs;
select * from departments;

select a.����̸�,
       a.�μ���,      
       l.street_address as �ּ�,
       a.����,
       a.���� as ����
from(select concat(e.first_name||' ',e.last_name)as ����̸�, 
    (select d.department_name from departments d where e.department_id = d.department_id) as �μ���,
    (select dd.location_id from departments dd where e.department_id = dd.department_id) as �μ����̵�,
    (select j.job_title from jobs j where e.job_id = j.job_id)as ����,
       e.salary as ����
          from employees e
          where salary >= 10000
          order by salary desc) a
left outer join locations l on a.�μ����̵� = l.location_id;

--1�� �������� ����¹�
select e.first_name as �̸�,
       d.department_name as �μ��̸�,
       l.street_address as �ּ�,
       j.job_title as ����,
       e.salary as ����
from employees e
left outer join departments d on d.department_id=e.department_id
left outer join locations l on d.location_id=l.location_id
left outer join jobs j on e.job_id = j.job_id
where salary >=10000
order by salary desc;

--2�� ��Į�������θ� ����¹�
select e.first_name as�̸�,
       (select department_name from departments d where e.department_id = d.department_id) as �μ���,
       (select street_address from locations l 
            where(select location_id from departments d where e.department_id = d.department_id) = l.location_id) as�ּ�, 
       (select job_title from jobs j where e.job_id=j.job_id) as����
from employees e
where salary >= 10000; 

--3�� �ζ��κ�� ��Į�������� ���̾��¹�
select a.first_name as �̸�,
       a.department_name as �μ���,
       (select street_address from locations l where a.location_id = l.location_id) as �ּ�,
       (select job_title from jobs j where a.job_id=j.job_id)as ����
from(select *
     from employees e
     left outer join departments d
     on e.department_id = d.department_id
     where salary >= 10000
) a;


--����
--where���� ���� ���������� ������ vs ������(in,any,all)

--��Į������ -select����Ʈ�� ���� ��������(���� ���� ����� ��������,left outer join�� ��������)
  --�����̺��� �ϳ��� �ุ �ҷ�����ʹٸ� ��Į�������� ����

--�ζ��� �� - from���� ���� ��������(���ʿ��� �ʿ��� �������� �ۼ�, �������̺��� ����)
  --�ҷ��������ϴ� ���� ���ٸ� �ζ��κ䰡 ����
  
  
  
  