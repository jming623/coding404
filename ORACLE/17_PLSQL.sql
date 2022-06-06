--PL/SQL�� (Program Language)

--������ SQL�� ������ �����ȿ��� �������ϴ� �������� �����մϴ�.

--�������� �� ���
SET SERVEROUTPUT ON; -- ��¹� �ܼ� Ȱ��ȭ
--������ declare�κк��� end�κб��� �巡���ѵڿ� ctrl+enter �� F5������ ����

DECLARE -- ���� ����
    VI_NUM NUMBER; --(������)(Ÿ��) - ���ڸ� ������ �� �ִ� ����
BEGIN -- ����
    VI_NUM := 10; -- :=�� ���� 
    DBMS_OUTPUT.PUT_LINE(VI_NUM); --��¹�
END; --��

--������  (+, -, /, *, <>, =, **(����) )
DECLARE
   A NUMBER := (2 * 3 + 2) ** 2;
BEGIN
    DBMS_OUTPUT.PUT_LINE('A='||A);
END;

--DML���� ȥ���ؼ� ���(������ ���Ǵ� QL�� ����)
--DDL������ ����� �� ���� �Ϲ������� SELECT������ ����մϴ�. 
--Ư���� ���� SELECT�� �Ʒ��� INTO���� ���ϴ�.
--SELECT�� ��ȸ�ؿ� �����͸� INTO�� ���� ������ �����մϴ�. �̶� ������Ÿ���� ��ġ�ؾ��ϰ� ���� �ϳ��� ���;� �մϴ�.
DECLARE
    EMP_NAME VARCHAR2(50);
    DEP_NAME VARCHAR2(50);
BEGIN
    SELECT E.FIRST_NAME , D.DEPARTMENT_NAME
    INTO EMP_NAME, DEP_NAME
    FROM EMPLOYEES E
    LEFT OUTER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME || '�� �μ���' || DEP_NAME);
END;

/*
������ ������ SELECT �� ��ȸ�� ����� ������Ÿ���� �ٸ���, ������ �߻���Ű�µ�,
�ش� ���̺��� �÷��� ������ Ÿ���� ������ �����Ϸ��� ���̺�.�÷���%TYPE���� ����մϴ�. 
*/

DECLARE
    EMP_NAME EMPLOYEES.FIRST_NAME%TYPE; --EMPLOYEES���̺��� FIRST_NAME�� ���� Ÿ������ �����ϰڴ� ��� �ǹ� 
    EMP_HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE;
    EMP_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT FIRST_NAME , HIRE_DATE , SALARY
    INTO EMP_NAME,EMP_HIRE_DATE,EMP_SALARY
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME||'���� �Ի�����'||EMP_HIRE_DATE||'�̰�, ������'||EMP_SALARY||'�Դϴ�.');
END;
  
/*
SELECT���� INSERT�� DML���� ���� ����� �� �ֽ��ϴ�.
*/

CREATE TABLE EMP_SAL(
    EMP_YEARS VARCHAR2(50),
    EMP_SALARY NUMBER(10)
);

DESC EMP_SAL;

DECLARE
    EMP_SUM EMPLOYEES.SALARY%TYPE;
    EMP_YEARS EMP_SAL.EMP_YEARS%TYPE := 2008;
BEGIN
    --SELECT 
    SELECT SUM(SALARY)
    INTO EMP_SUM
    FROM EMPLOYEES
    WHERE TO_CHAR(HIRE_DATE , 'YYYY') = EMP_YEARS ;
    --INSERT 
    INSERT INTO EMP_SAL VALUES(EMP_YEARS , EMP_SUM);
    --COMMIT
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE(EMP_SUM);
END;

SELECT * FROM EMP_SAL;



