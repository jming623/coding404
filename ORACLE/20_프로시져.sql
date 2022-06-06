/*
���� ���ν��� - �ϳ��� �Լ�ó�� �����ϱ� ���� ������ ����

����� ������, �����ϴ� ������ ������ �ۼ��մϴ�.

*/

--���ν��� ����
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC 
/*  (

     ) --�Ű����� ���𿵿� */
IS --������ ���� ����
BEGIN --���࿵��
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD!');
END;

--���ν��� ����
EXEC NEW_JOB_PROC;

--���ν����� �Ű����� IN����
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN JOBS.JOB_ID%TYPE,
     P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
     P_MIN_SAL IN JOBS.MIN_SALARY%TYPE,
     P_MAX_SAL IN JOBS.MAX_SALARY%TYPE
    ) --�Ű����� ���� 
IS
BEGIN
    INSERT INTO JOBS VALUES(P_JOB_ID,P_JOB_TITLE,P_MIN_SAL,P_MAX_SAL);
END;

EXEC NEW_JOB_PROC('SA_MAN1','SAMPLE TEST', 1000, 5000);

SELECT * FROM JOBS;

-------- ���ν��� IN������ Ȱ��(Ű���� �ִٸ� UPDATE, ���ٸ� INSERT)
--�Ű������� ���� JOB_ID�� ������ �ִٸ� INSERT������ ����, �ƴ϶�� UPDATE�� ����

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN JOBS.JOB_ID%TYPE,
     P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
     P_MIN_SAL IN JOBS.MIN_SALARY%TYPE,
     P_MAX_SAL IN JOBS.MAX_SALARY%TYPE
    )
IS
    V_COUNT NUMBER := 0; --��������
BEGIN
    --�ߺ��� �˻� (�Ű������� ���� ���� ������ ���� ���̸� COUNT�� 0 )
    SELECT COUNT(*) 
    INTO V_COUNT
    FROM JOBS 
    WHERE JOB_ID = P_JOB_ID;--���ν����� �Ű������� ������ ��
   
   IF V_COUNT = 0 THEN --ī��Ʈ�� 0�̸� ������ ���°������� INSERT�� ����,�ƴ϶�� ���� ID���� �ٸ��÷��� ���� UPDATE.
   -- INSERT
        INSERT INTO JOBS VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SAL, P_MAX_SAL);
   ELSE
   --UPDATE
        UPDATE JOBS 
        SET JOB_TITLE = P_JOB_TITLE,
            MIN_SALARY = P_MIN_SAL,
            MAX_SALARY = P_MAX_SAL
        WHERE JOB_ID = P_JOB_ID;
   END IF;
END;

--���ν����� ���
EXEC NEW_JOB_PROC('SA_MAN1', 'SAMPLE TEST', 10000, 20200);

SELECT * FROM JOBS;

----------------------------------------------------------------
--���� �Ű����� 4���� �־�����ϴ� ���ν����� �Ű����� 2���� �־���ٸ�??
EXEC NEW_JOB_PROC('SA_MAN2', 'SAMPLE TEST'); --����
--SQL������ �ڹٿʹ� �ٸ��� ���ν����� �����Ҷ� �⺻���� �����༭
--�Ű������� ���� ���޵��� ������ �⺻���� ����� �� �ְ� ������ �� �ֽ��ϴ�.

--���ν����� ����Ʈ �Ű��� ����(Ÿ���� ��ġ�ϰ� ��������� �մϴ�.)
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN JOBS.JOB_ID%TYPE,
     P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
     P_MIN_SAL IN JOBS.MIN_SALARY%TYPE := 0, --���� �ƹ����� ���޵��� ������ �⺻���� 0
     P_MAX_SAL IN JOBS.MAX_SALARY%TYPE := 1000 --���� �ƹ����� ���޵��� ������ �⺻���� 1000
    )
IS
    V_COUNT NUMBER := 0;
BEGIN
    SELECT COUNT(*) 
    INTO V_COUNT
    FROM JOBS 
    WHERE JOB_ID = P_JOB_ID;
   
    IF V_COUNT = 0 THEN
        INSERT INTO JOBS VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SAL, P_MAX_SAL);
    ELSE
        UPDATE JOBS 
        SET JOB_TITLE = P_JOB_TITLE,
            MIN_SALARY = P_MIN_SAL,
            MAX_SALARY = P_MAX_SAL
        WHERE JOB_ID = P_JOB_ID;
    END IF;
END;

EXEC NEW_JOB_PROC('SA_MAN1','�Ű���4��',1 , 2000);

EXEC NEW_JOB_PROC('SA_MAN2','�Ű���2��');
SELECT * FROM JOBS;

DESC JOBS;

--------------------------------------------------

--OUT�Ű�����
--���ν����� OUT������ ������ �ִٸ�, ���౸���� �͸��Ͽ��� �����մϴ�.

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN JOBS.JOB_ID%TYPE,
     P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
     P_MIN_SAL IN JOBS.MIN_SALARY%TYPE := 0,
     P_MAX_SAL IN JOBS.MAX_SALARY%TYPE :=1000,
     P_RESULT OUT VARCHAR2
    )
IS
    V_COUNT NUMBER := 0; --��������

BEGIN
    SELECT COUNT(*)
    INTO V_COUNT --��������
    FROM JOBS
    WHERE JOB_ID = P_JOB_ID;
    
    IF V_COUNT = 0 THEN
        INSERT INTO JOBS
        VALUES(P_JOB_ID,P_JOB_TITLE,P_MIN_SAL,P_MAX_SAL);
        
        P_RESULT := P_JOB_ID; --������ ��쿡�� �ƿ������� ���̵� ����
    ELSE
        UPDATE JOBS 
        SET JOB_TITLE = P_JOB_TITLE ,
            MIN_SALARY = P_MIN_SAL,
            MAX_SALARY = P_MAX_SAL
        WHERE JOB_ID = P_JOB_ID;
        
        P_RESULT := '�����ϴ� ���̱� ������ ������Ʈ �Ǿ����ϴ�.';
    
    END IF;
    
    
END;
-------------------------------------------------------------------
DECLARE
    STR VARCHAR2(100); --OUT������ ����� �������� ���� ����
BEGIN
    NEW_JOB_PROC('TEST01', 'TEST02', 1000, 2000, STR); --EXEC���� 
    DBMS_OUTPUT.PUT_LINE(STR);--���
END;

SET SERVEROUTPUT ON;

--------------------------------------------------------------
--IN OUT����
CREATE OR REPLACE PROCEDURE TEST_PROC
    (P_VAR1 IN VARCHAR2, --�Էº���(��ȯ�Ұ�)
     P_VAR2 OUT VARCHAR2, --��º���(���ν����� ������ ������ ���� �Ҵ��� �ȵ�.)
     P_VAR3 IN OUT VARCHAR2 --��,��º���(�Ѵ� ����)
    )
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('P_VAR1�� ��: '||P_VAR1);
    DBMS_OUTPUT.PUT_LINE('P_VAR2�� ��: '||P_VAR2);
    DBMS_OUTPUT.PUT_LINE('P_VAR3�� ��: '||P_VAR3);
END;

DECLARE
    V_A VARCHAR2(100) := 'A';
    V_B VARCHAR2(100) := 'B';
    V_C VARCHAR2(100) := 'C';
BEGIN
    TEST_PROC(V_A, V_B, V_C);
END;
----------------------------------------------------
CREATE OR REPLACE PROCEDURE TEST_PROC
    (P_VAR1 IN VARCHAR2, --�Էº���(��ȯ�Ұ�)
     P_VAR2 OUT VARCHAR2, --��º���(���ν����� ������ ������ ���� �Ҵ��� �ȵ�.)
     P_VAR3 IN OUT VARCHAR2 --��,��º���(�Ѵ� ����)
    )
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('P_VAR1�� ��: '||P_VAR1);
    DBMS_OUTPUT.PUT_LINE('P_VAR2�� ��: '||P_VAR2);
    DBMS_OUTPUT.PUT_LINE('P_VAR3�� ��: '||P_VAR3);
    
--    P_VAR1 := '���1';  --(IN���� �Ҵ�Ұ�)
    P_VAR2 := '���2';
    P_VAR3 := '���3';
    
END;

DECLARE
    V_A VARCHAR2(100) := 'A';
    V_B VARCHAR2(100) := 'B';
    V_C VARCHAR2(100) := 'C';
BEGIN
    TEST_PROC(V_A, V_B, V_C);
    DBMS_OUTPUT.PUT_LINE('P_VAR1�� ��: '|| V_A);
    DBMS_OUTPUT.PUT_LINE('P_VAR2�� ��: '|| V_B);
    DBMS_OUTPUT.PUT_LINE('P_VAR3�� ��: '||V_C);
END;

-----------------------------------------------------

--���ν����� ���� RETURN Ű����

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN JOBS.JOB_ID%TYPE    
    )
IS
    V_COUNT NUMBER:=0;
    V_MIN_TOTAL NUMBER := 0; --�ּұ޿� ��ü��.
BEGIN
    --���� ���ٸ� ����Ŀ� ���ν����� ����, �ִٸ� P_JOB_ID�� �ּұ޿� ��ü�� ���
    SELECT COUNT(*)
    INTO V_COUNT
    FROM JOBS
    WHERE JOB_ID LIKE '%'|| P_JOB_ID ||'%' ; --P_JOB_ID�� ���� ���� �����Ѹ�� ����ȸ
     
    IF V_COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE(P_JOB_ID||'���� �����ϴ�. ���ν����� �����մϴ�.');
        RETURN;--���ν����� ����
    ELSE
        --P_JOB_ID�� �ּұ޿� ��ü��
        SELECT SUM(MIN_SALARY)
        INTO V_MIN_TOTAL
        FROM JOBS 
        WHERE JOB_ID LIKE  '%'||P_JOB_ID||'%';
        
        DBMS_OUTPUT.PUT_LINE(P_JOB_ID||'�� MIN_SALARY�� ��: '||V_MIN_TOTAL);
    END IF;
      
    DBMS_OUTPUT.PUT_LINE('�� ������ ����Ǿ��ٸ� IF������ RETURN�� Ÿ���ʰ� �Ʒ��� ������ ���Դϴ�.');
END;

EXEC NEW_JOB_PROC('SSSSSSS');  --���°�

EXEC NEW_JOB_PROC('TEST'); --�ִ°�

--��������

/*
EMPLOYEE_ID�� �޾Ƽ� EMPLOYEES�� �����ϸ�, �ټӳ���� ���
���ٸ�, �����ϴٸ� ����ϴ� ���ν����� ��������.
*/

--IN�� ����Ͽ� ���
CREATE OR REPLACE PROCEDURE EMP_PROC
    (EMP_ID IN EMPLOYEES.EMPLOYEE_ID%TYPE
    )
IS
    EMP_COUNT NUMBER := 0;
    EMP_DATE VARCHAR2(50);
BEGIN
    SELECT COUNT(*)
    INTO EMP_COUNT
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = EMP_ID;
    
    IF EMP_COUNT = 0 THEN
       DBMS_OUTPUT.PUT_LINE(EMP_ID||' �� ���̵� ���� ������ �����ϴ�.');
    ELSE
        SELECT TRUNC((SYSDATE-HIRE_DATE)/365,1)||'��'
        INTO EMP_DATE
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = EMP_ID; 
        
        DBMS_OUTPUT.PUT_LINE(EMP_ID||'�� ������ �ټӳ���� '||EMP_DATE||'�Դϴ�.');
    END IF;
    
END;

EXEC EMP_PROC(100);
EXEC EMP_PROC(500);

--OUT�� ����Ͽ� ���
CREATE OR REPLACE PROCEDURE EMP_PROC1
    (EMP_ID IN EMPLOYEES.EMPLOYEE_ID%TYPE,
     EMP_DATE OUT VARCHAR2
    )
IS 
    E_COUNT NUMBER :=0;
BEGIN
    SELECT COUNT(*)
    INTO E_COUNT
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = EMP_ID;
    
    IF E_COUNT = 0 THEN
       EMP_DATE := '�ش� ���̵� ���� ������ �����ϴ�.';
       
    ELSE 
        SELECT EMP_ID||'�� ������ �ټӳ���� '||TRUNC((SYSDATE-HIRE_DATE)/365,1)||'��'||'�Դϴ�.'
        INTO EMP_DATE
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = EMP_ID; 
    END IF;
END;

DECLARE
    RESULT1 VARCHAR2(50);
    RESULT2 VARCHAR2(50);
    RESULT3 VARCHAR2(50);
BEGIN
    EMP_PROC1(100,RESULT1);
    EMP_PROC1(200,RESULT2);
    EMP_PROC1(300,RESULT3);
    DBMS_OUTPUT.PUT_LINE(RESULT1);
    DBMS_OUTPUT.PUT_LINE(RESULT2);
    DBMS_OUTPUT.PUT_LINE(RESULT3);
END;

--������ Ǯ�� 

CREATE OR REPLACE PROCEDURE EMP_YEAR_PROC
    (P_EMP_ID IN EMPLOYEES.EMPLOYEE_ID%TYPE    
    )
IS
    V_COUNT NUMBER := 0;
    V_YEAR NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO V_COUNT
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = P_EMP_ID;
    
    IF V_COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE(P_EMP_ID||'�� �����ϴ�.');
    ELSE
        SELECT TRUNC((SYSDATE - HIRE_DATE)/365)
        INTO V_YEAR
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = P_EMP_ID;
        
        DBMS_OUTPUT.PUT_LINE(P_EMP_ID||'�� �ټӳ��: '||V_YEAR);
    END IF;

    --����ó��
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('���ܹ߻�');
END;

EXEC EMP_YEAR_PROC(100);
EXEC EMP_YEAR_PROC(500);


