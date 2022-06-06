
select * from info;
select * from auth;

--INNER JOIN �̳�����
SELECT * FROM INFO  INNER JOIN AUTH ON INFO.ID = AUTH.ID;
--�̳������� NULL���� ������������ ��µ��� �ʴ´�.

select * from employees;

select * 
from employees e
inner join departments d
on e.department_id = d.department_id
where hire_date <= '10/01/01'
--GROUP BY
--HAVING
order by hire_date asc;

--SELECT���� ���� ������ �� ID�� ���ԵǸ� ��ȣ�ϴ�.(���� ���̺� ID�� �����ϱ� ������)
--�̷� �� �÷��� ���̺��̸�.�÷��� �� ���� ��Ī�ؼ� ���������� ��ȸ �մϴ�. 
SELECT BNO, TITLE , CONTENT , ID, NAME ,JOB
FROM INFO
INNER JOIN AUTH ON INFO.ID = AUTH.ID; 
--�̷���ȣ���� ��� ���� ���ǰ� �ָ��մϴ� ��� ������ �߻��Ѵ�.
--������ ID�� �ΰ��ε� � ID�� ȣ���� �������� �ָ��ؼ� �߻��Ѵ�. �Ʒ�ó�� �����ϸ� ����ȣ���.
SELECT BNO, TITLE , CONTENT , INFO.ID, NAME ,JOB
FROM INFO
INNER JOIN AUTH ON INFO.ID = AUTH.ID; 

--���̺���� ������� ���������� ��Ȳ�� ����Ͽ� ���̺��� ����� ������ �����ϴ�.
SELECT  BNO, TITLE, CONTENT , I.ID , NAME, JOB
FROM INFO I --INFO���̺��� I��� ��Ī���� ���ڴ�
INNER JOIN AUTH A --AUTH���̺��� I��� ��Ī���� ���ڴ�
ON I.ID = A.ID ;

--�������� INNER JOIN ~ ON ~ ���Ŀ� 
SELECT  BNO, TITLE, CONTENT , I.ID , NAME, JOB
FROM INFO I 
INNER JOIN AUTH A 
ON I.ID = A.ID
WHERE JOB ='�����ֺ�'
--GROUP BY
--HAVING
ORDER BY BNO DESC;

--�ƿ��� ����
--left outer join(���ʱ������� ����)
select * from info i left outer join auth a on i.id=a.id;

--right outer join(�����ʱ������� ����)
select * from info i right outer join auth a on i.id=a.id;

select * from employees e right outer join departments d on e.department_id = d.department_id;
--��� left,right join�� ������ �ٲ��൵ ��������.(�� ,���ļ����� �ٲ�)
select * from auth a left outer join info i on i.id=a.id;

--full outer join(���� ���̺��� �ٳ���.)
select * from info i full outer join auth a on i.id=a.id;
--from�ٷεڿ� ���� ���̺� �������� null�� ���� ȣ���ѵ� join�ڿ����� ���̺� �������� null�� ���� ȣ������.

--cross join (�߸��� ����)
select * from info i cross join auth a;

--3���� ���̺� ������ �ɱ��?
select * from employees;-- (pk:employee_id, fk:department_id)
select * from departments;--(pk:department_id , fk:location_id)
select * from locations;--(pk:location_id , fk:county_id)

select * 
from employees e 
left outer join departments d on e.department_id = d.department_id
left outer join locations l on d.location_id = l.location_id;