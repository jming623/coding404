--���̺� ���� Ȯ�� desc (���̺��);
desc departments;

--DML�� (Data Manipuration Language)
--insert,update,delete,merge,ctas       

--insert��

--1st insert into (���̺��)(�÷��� ����)values(�߰��ϰ���� ��)
--(�ۼ��ϰ��� �ϴ� �÷��� �����ϰ� values�ڿ� �߰��ϰ��� �ϴ� ���� �־��ش�)
insert into departments(department_id,department_name,manager_id,location_id) values (290,'������',200 ,1700);
insert into departments(department_id,department_name,location_id) values(300,'�����̳�',1700);
insert into departments(department_id,department_name) values(310,'DBA');
insert into departments(department_name,department_id) values('����������' , 320);

select * from departments;

insert into departments values(280,'������',100,1700);
update departments
set department_id = 290,
    department_name = '����',
    manager_id = 200,
    location_id = 2000
where department_id = 280;


delete from departments where department_id = 290;                    

--2ed(����÷��� ���� �������ְ� �������� �÷������� ������ �� �ִ�. )
--(values �ڿ� �÷� ������� ���� �����ݴϴ�.)
insert into departments values(330,'�ۺ���',200,1700);
insert into departments values(340,'������ �м���',200,1700);

--DML ������ Ʈ������� ���ؼ� DML�������� �ǵ��� �� �ֽ��ϴ�.
rollback;
select * from departments;

--���̺� ���� ����
create table managers as (select * from employees where 1 = 2); 
select * from managers ;

--3nd (�ٸ����̺��� Ư�� ��, ���������� insert) 

--����÷��� ���� �߰��Ҷ����� �÷������� ������ �� �ִ�.
--���������� �����°�� values�� �����ʴ´�.
insert into managers (select * from employees where job_id = 'IT_PROG');
--���ϴ� �÷��� ���� �߰��ϰ������ ���� �������� �� �ִ�.
insert into managers(employee_id, last_name, email, hire_date, job_id)
      (select employee_id, last_name, email, hire_date, job_id from employees where job_id = 'FI_ACCOUNT');
--���������� NULL���� �����Ե�. �׷��� NULL�̵��ü� ���� �÷��� ������ �������־����.

select * from managers ;

--UPDATE�� 
desc employees;

create table emps as (select * from employees where 1 = 1);

select * from emps;

update emps set salary = 30000;
--���� �߸��ؼ� where���� ������ �������� �ʰ� ������ �����ߴ�?
--��翭�� salary �÷��� ���� ���� �� �ٲ�. 

--UPDATE���� �������� �ݵ�� ����ؾ� �մϴ�.
select * from emps where employee_id = 100; --���� �ϳ����� Ȯ���ϰ� �����Ѵ�. --���� �������̵�100�� ����� ������ 24000
update emps set salary = salary* 1.1 where employee_id = 100; --pk����

select * from emps where employee_id = 100;-- 26400���� �ٲ�

UPDATE EMPS
SET PHONE_NUMBER = '511.123.1111', ---���� �÷��� �ٲ��ְ������ ,�� ����ϸ� �ȴ�.
    HIRE_DATE = SYSDATE,           --��� �ٲ��ְ� �; *�� ����� ���� ����.
    COMMISSION_PCT = 0.1
WHERE EMPLOYEE_ID = 100;
            
select * from emps where employee_id = 100; 


--JOB_ID�� IT_PROG�� ����� Ŀ�̼� 0.1�� ������Ʈ

UPDATE EMPS SET COMMISSION_PCT = 0.1 WHERE JOB_ID = 'IT_PROG';
            
SELECT * FROM EMPS WHERE JOB_ID = 'IT_PROG';            


--WHERE���� ��������            
UPDATE EMPS 
SET COMMISSION_PCT = 0.2 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPS WHERE FIRST_NAME ='Donald') ;

SELECT * FROM EMPS WHERE DEPARTMENT_ID = 50;

--SET���� ��������
--UPDATE EMPS SET () = (��������) WHERE ����

UPDATE EMPS SET (JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID ) =
                (SELECT JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 102;
--���������� ����ϱ����� �׻� ���� Ȯ������ �ѹ� Ȯ���ϴ°��� ����.

SELECT JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 UNION ALL
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 102;

ROLLBACK;

--DELETE
SELECT * FROM DEPARTMENTS;

--(EMPLOYEES���̺��� 50���μ��� �����Ͽ� ������̱� ������ �����̻�)- �������Ἲ�������� ����
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID =50; 

SELECT * FROM EMPS WHERE EMPLOYEE_ID = 105;
DELETE FROM EMPS WHERE EMPLOYEE_ID = 105;

SELECT * FROM EMPS;


--WHERE���� ��������
SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping';

delete from emps where department_id = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping');
--���� ������ �����ϸ� department_id�� 50�� 45���� ������ �������.

select * from emps;

rollback;


--���̺� ����(Create Table AS)
CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES WHERE 1=2);  --WHERE 1=2�� ������ ����
SELECT * FROM EMPS_IT;
CREATE TABLE EMPS_ITT AS (SELECT * FROM EMPLOYEES WHERE 1=1); -- 1=1�� �����͵� ���� �����ϰ� �Ǹ� �ڵ����� 1=1
SELECT * FROM EMPS_ITT;

INSERT INTO EMPS_IT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES( 103, 'GILDONG' , 'KKKK' , SYSDATE ,  'IT_PROG') ;

UPDATE EMPS_IT SET LAST_NAME = 'GIL DONG' , FIRST_NAME = 'HONG' WHERE EMPLOYEE_ID = 103;
DROP TABLE EMPS_IT;
SELECT * FROM EMPS_IT;
DESC EMPS_IT;
INSERT INTO EMPS_IT VALUES(103,'T1','T2','T3','T4',SYSDATE,'T5',5000,1,100,150);
---------------------------MERGE--------------------------------------- 
--MERGE INTO Ÿ�� �����
--USING(���ս�ų ���̺��� ������)
--ON (�� ���̺��� ��������)
--WHEN MATCHED THEN (��ġ�� ��� ������ �۾�)
--WHEN NOT MATCHED THEN(��ġ���� ���� ��� ������ �۾�)

MERGE INTO EMPS_IT A
USING (SELECT *
       FROM EMPLOYEES
       WHERE JOB_ID = 'IT_PROG' ) B
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
WHEN MATCHED THEN
    UPDATE SET 
        A.FIRST_NAME = B.FIRST_NAME,
        A.EMAIL = B.EMAIL,
        A.PHONE_NUMBER = B.PHONE_NUMBER,
        A.MANAGER_ID = B.MANAGER_ID,
        A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHEN NOT MATCHED THEN 
    INSERT (EMPLOYEE_ID, FIRST_NAME , LAST_NAME , EMAIL , PHONE_NUMBER, MANAGER_ID, DEPARTMENT_ID, JOB_ID, HIRE_DATE)
    VALUES
        (B.EMPLOYEE_ID,
         B.FIRST_NAME ,
         B.LAST_NAME, 
         B.EMAIL,
         B.PHONE_NUMBER,
         B.MANAGER_ID,
         B.DEPARTMENT_ID,
         B.JOB_ID,
         B.HIRE_DATE
        );
        
        SELECT * FROM EMPS_IT;
        
        
--�ǽ� 
-- employees ���̺��� �Ź� �����Ǵ� ���̺��̶�� ����. �ָ��� emps_it �� ������Ʈ
-- ������ �����ʹ� email, phone , salary , commission, manager_id , department_id�� ������Ʈ �ǵ��� ó��
-- ���� ���Ե� �����ʹ� ��� �÷��� �״�� �߰�.
INSERT INTO EMPS_IT (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID) 
VALUES(102, 'ȫ', '�浿' , 'HONG' , '01/04/06' , 'AD_VP');
INSERT INTO EMPS_IT (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID) 
VALUES(101, '�ϳ�', 'Ŵ' , 'KIM' , '20/03/04' , 'AD_VP');

MERGE INTO EMPS_IT A
USING (SELECT * FROM EMPLOYEES) B
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
WHEN MATCHED THEN
    UPDATE SET
        A.EMAIL = B.EMAIL,
        A.PHONE_NUMBER = B.PHONE_NUMBER,
        A.SALARY = B.SALARY,
        A.COMMISSION_PCT = B.COMMISSION_PCT,
        A.MANAGER_ID = B.MANAGER_ID,
        A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHEN NOT MATCHED THEN
    INSERT
    VALUES(B.EMPLOYEE_ID,
           B.FIRST_NAME,
           B.LAST_NAME,
           B.EMAIL,
           B.PHONE_NUMBER,
           B.HIRE_DATE,
           B.JOB_ID,
           B.SALARY,
           B.COMMISSION_PCT,
           B.MANAGER_ID,
           B.DEPARTMENT_ID    
           );
        
--������ ID 104,5,6,7�� NULL���� ����EMPLOYEES���̺� 104,567�̰������ִ� ������ ���ð��̰�,
--�ϳ��� �浿�� �̸��� �״���λ��·� 101,102���� ����(��ȣ,����,���ʽ�,�Ŵ���,�μ�)�� ������̰�,
--��107�� ���� �������ִ� EMPLOYEES���̺��� �����Ű��  ���� �������ִ� 7���� ���� ������ ���̰�  ������ 100������ �߰��� ���̴�.
--������?
SELECT * FROM EMPS_IT ORDER BY EMPLOYEE_ID;


--CTAS (�纻���̺�) --PK,FK�� ���� Ű�� Ư�������� �������� �ʽ��ϴ�. (NULL�� ���θ� ����)
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS /*WHERE 1=1*/) --�����ϸ� �ڵ����� 1=1(������ ���� ����) ,1=2�� ������ ����