--������ ������ where��

select * from employees;

select first_name, last_name, job_id, department_id from employees where job_id = 'IT_PROG';
select * from employees where first_name = 'Valli';
select * from employees where salary >= 15000;
select * from employees where department_id = 60;
select * from employees where hire_date >= '08/01/01'; --��¥ ����(��/��/��) ��Һ񱳰� ����
select * from employees where hire_date = '08/01/24';

-- where ������ (between, in, like)
select * from employees where salary between 10000 and 20000;
select * from employees where hire_date between '05/01/01' and '05/12/31';

-- in������
select * from employees where manager_id in (101, 102, 103);
select * from employees where job_id in ('AD_ASST', 'FI_MGR', 'IT_PROG'); 

-- like������ (�˻��Ҷ�)
select * from employees where first_name like 'A%'; --A�� �����ϴ�
select * from employees where hire_date like '05%'; --05�� �����ϴ�
select * from employees where hire_date like '%15'; --15�� ������
select * from employees where hire_date like '%07%'; --07�� ���Ե�
select * from employees where hire_date like '___07%'; -- (_�� ��ġ�� �ǹ���) ��ĭ��� 07�ν����ϴ�

-- is null(null�� Ȯ��)
--select * from employees where commission_pct = null; (�ȵ�)
select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

-- and, or���� (and�� or���� ����)
select * from employees where job_id = 'IT_PROG' and salary >= 6000;
select * from employees where salary >= 10000 and salary <= 20000;
select * from employees where job_id = 'AD_VP' or salary >= 15000;
-- �켱������ �����Ϸ��� ()�� �̿��Ͻø� �˴ϴ�.
select * from employees where (job_id = 'IT_PROG' or job_id = 'AD_VP') and salary >= 6000;


-- ������ ���� order by��
select * from employees order by first_name asc;
select * from employees order by hire_date asc;
select * from employees order by hire_date desc;

select * from employees where job_id in ('IT_PROG', 'AD_VP') order by salary asc;
--�޿��� 5000�̻�� �߿��� �������̵� �������� ������������
select * from employees where salary >= 5000 order by employee_id desc;
-- Ŀ�̼��� null�� �ƴ� ����� �������̵� �������� ������������
select * from employees where commission_pct is not null order by employee_id asc;

-- job_id���� ��������, �޿����� �������� (���� �������� �����Ϸ��� , )
select * from employees order by job_id asc, salary desc;

-- order by������ ����� �� �̿��ؼ� ������ �����մϴ�.
select first_name || ' ' || last_name as �̸�, 
       salary, 
       salary * 12 as ����  
from employees
order by ���� desc;



















