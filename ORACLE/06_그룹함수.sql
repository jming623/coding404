--�׷�(����)�Լ� SUM , AVG, MIN ,MAX, COUNT 
SELECT SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(SALARY) FROM EMPLOYEES;

SELECT SUM(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 50; --�μ��� 50�� ������� ������ ��

SELECT COUNT(*) FROM EMPLOYEES;--EMPLOYEES���̺��� ��ü �� ��
SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES; --COMMISSION_PCT�� NULL�� �ƴ� ���� ����
SELECT COUNT(MANAGER_ID) FROM EMPLOYEES;--MANAGER_ID�� ���� NULL�� �ƴ� ���� ����

-- �׷��Լ��� �Ϲ� �÷��� ���� �� �� ����.
--EX) SELECT SUM(SALARY), SALARY FROM EMPLOYEES (X)

--group by��

-- ��, GROUP BY�� �Բ��ִٸ� GROUPING�� �Ϲ� �÷��� �׷��Լ��� �Բ� �� �� �ִ�. 
-- EX) department_id , avg(salary) from employees group by dipartment_id; (O) 

select job_id  from employees group by job_id; --job_id�� �׷���
select job_id , salary from employees group by job_id; --(X)
--job_id�� �׷��������� select�ڿ� �� �� ���� �ٸ� �÷��� ���Ұ���

select job_id , avg(salary) from employees group by job_id; --job_id�� �޿����

select department_id , avg(salary), sum(salary) , count(salary) from employees group by department_id; --�μ��� �޿� ���

--��������
--�׷����� ���� ������ �׷��Լ��� �Ϲ��÷��� ���ÿ� ������� ����.
select count(*), job_id from employees; --(X)
--group by ���� ����� �� group���� ������ ������ �ٸ� Ŀ�� ��ȸ�� �� �� ����.
select job_id from employees group by department_id; --(X)

--2�� �̻��� group by��

select * from employees;

select department_id , job_id , count(job_id) from employees group by department_id, job_id
order by department_id asc;
--department_id�� �׷����� �ѹ��ϰ� �ٽ� job_id���� �׷����� �Ͽ���.

select department_id , job_id , avg(salary)
from employees
group by department_id, job_id
order by department_id asc;

-- group by ���� ���� having(where���� �Ϲ��࿡ ���� ����)

select department_id, sum(salary)
from employees
group by department_id
having sum(salary) > 100000;
 
 --job_id�� ����
select job_id , count(*)
from employees 
group by job_id
having count(*) >= 5
order by count(*) desc;

--�μ����̵� 50�̻��� ���� �׷����ϰ� ,�μ��� ��ձ޿� 5000�̻� ��ȸ,����

select department_id, trunc(avg(salary)) as ��ձ޿�
from employees
group by department_id
having trunc(avg(salary))  >= 5000 and department_id >= 50
order by trunc(avg(salary)) desc;


--��Ǯ��
select department_id as �μ� , trunc(avg(salary)) as ��ձ޿� from employees
group by department_id
having department_id >=50 and avg(salary) >= 5000 
order by department_id asc;

--������ Ǯ��
select department_id, avg(salary) as �μ���� 
from employees
where department_id >= 50
group by department_id
having avg(salary) >= 5000
order by �μ���� desc;

--�Ʒ��� ���� �׷��Լ��� over()�� �־ �Ϲ��Լ��� �Բ� ����� ���� �ִµ� ������ ���̾󸶾ȵǼ� �������� 
--�ε��ϴ� �ӵ��� ���� ����ϰ� �� ���� ���� ���ɼ��� ���� 
--count(*)over() �׷�ȭ ���� �ʾƵ�, ���������� �� ���� ���� �ٿ��� ��ȸ�ϴ� �����Դϴ�. (�˾Ƹ��Ѱ�) 
select department_id , first_name, count(*)over() , avg(salary)over() from employees;


