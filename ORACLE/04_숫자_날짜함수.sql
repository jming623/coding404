--���� �Լ�

--round (�ݿø�)
select 45.923 from dual;
select round(45.923,2), round(45.923) , round(45.923, 0) ,round(45.923,-1) from dual;
--.�������� 2�� �Ҽ���2�ڸ����� ������ �Ҽ���0��° ���� -1�� �Ҽ������� �������� ù��° �� 1���ڸ� -2�� 10���ڸ� �ݿø�

--trunc(����)
select trunc(45.923,2), trunc(45.923) , trunc(45.923,0) , trunc(45.923,-1) from dual;

--abs (���밪)
select abs(-34) from dual;

--ceil(�ø�), floor(����)
select ceil(3.14), floor(3.14) from dual; --���� �ø�����, round�� trunc�� ��ü�� �����Ͽ� �� ����������

--mod(������)
select 10/3 as ������, mod(10,3) as ������ from dual; --sql������ %�� ����� �������� ���� �� ����. ��� mod�� ���

--��¥�Լ�
--SYSDATE �ſ��߿�
select sysdate from dual; --��,��,�� 

--SYSTIMESTAMP
select systimestamp from dual; --��,��,��,��,��,��,�и���,ǥ�ؽð�

--��¥�� ������ �����մϴ�.
select sysdate-hire_date from employees;  --��¥ ���� ��¥�� �ϼ�
select (sysdate - hire_date) / 7 from employees; --����
select (sysdate - hire_date) /365 from employees; --���
select trunc((sysdate - hire_date) /365) from employees;

--��¥���� trunc, round ������ �����մϴ�.
select round(sysdate) from dual;

select round(sysdate , 'year') from dual; --"��" �ݿø�
select round(sysdate, 'month') from dual; --"��" �ݿø�
select round(sysdate , 'day') from dual; --day�� �Ͽ����� �������� �ݿø���. 
select round(systimestamp) from dual;

select trunc(sysdate) from dual;
select trunc(sysdate, 'year') from dual; --�� �������� �ڸ�
select trunc(sysdate , 'month') from dual; --�� �������� �ڸ�
select trunc(sysdate, 'day') from dual; -- �� �������� �ڸ�(�Ͽ��� ����)