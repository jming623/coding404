--�ּ��� ���
--����Ŭ���� SQL���� ��ҹ��ڸ� ������ �ʽ��ϴ�.
--���� �������� ; �����մϴ�.
--������ CTRL + ENTER
--���ڿ�,��¥�� ��������, ���ڴ� ������ ����.

SELECT * FROM Employees;  --���÷��� ���̺��� *(��簪)

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME FROM EMPLOYEES;

SELECT EMPLOYEE_ID , HIRE_DATE, SALARY FROM EMPLOYEES;

--NULL �� Ȯ��
SELECT EMPLOYEE_ID, SALARY, COMMISSION_PCT FROM EMPLOYEES;

--���� �÷��� ������ ����
SELECT EMPLOYEE_ID , SALARY , SALARY + SALARY * 0.1 FROM EMPLOYEES;

--�����, �÷����� ��Ī ���� (AS)
SELECT EMPLOYEE_ID , SALARY , SALARY + SALARY * 0.1 AS ���ʽ� FROM EMPLOYEES;
SELECT FIRST_NAME AS �̸� , SALARY AS �޿� FROM EMPLOYEES;

SELECT EMPLOYEE_ID AS ������̵�, 
       FIRST_NAME AS  �̸� , 
       LAST_NAME AS ��,
       SALARY + SALARY*0.1 AS �޿� 
       FROM EMPLOYEES;
       
--�÷� ���� || , ���ڿ� ǥ���� '', ���ڿ��ȿ��� �ο��ȣ '�� ����ʹٸ� �ι� ���� �˴ϴ�.
SELECT FIRST_NAME || LAST_NAME FROM EMPLOYEES;  --�÷��� �������� �÷��� ��������.
SELECT FIRST_NAME || ' ' || LAST_NAME FROM EMPLOYEES;

SELECT first_name||' ' || LAST_NAME || '''s salary is $' || SALARY AS �޿�����
       FROM EMPLOYEES;

-- �� �ߺ� ���� distinct
select distinct department_id from employees;
select distinct salary from employees;

-- ��¼���(rownum) , ��������ġ(rowid)
select rowid, rownum, employee_id , first_name from employees;

select rownum, first_name from employees;
--employees���̺��� pk(�⺻Ű)�� employee_id�ε� pk�� ȣ���Ҷ��� ȣ������ �������� ������ �ٸ� �� ����.
--�Ϲ������� pk�� ȣ���ϸ� �� ����


--���̺����� ����
desc employees;

