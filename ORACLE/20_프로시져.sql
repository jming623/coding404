/*
저장 프로시저 - 하나의 함수처리 실행하기 위한 쿼리의 집합

만드는 과정과, 실행하는 구문이 나누어 작성합니다.

*/

--프로시저 생성
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC 
/*  (

     ) --매개변수 선언영역 */
IS --변수의 선언 영역
BEGIN --실행영역
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD!');
END;

--프로시저 실행
EXEC NEW_JOB_PROC;

--프로시저의 매개변수 IN구문
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN JOBS.JOB_ID%TYPE,
     P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
     P_MIN_SAL IN JOBS.MIN_SALARY%TYPE,
     P_MAX_SAL IN JOBS.MAX_SALARY%TYPE
    ) --매개변수 선언 
IS
BEGIN
    INSERT INTO JOBS VALUES(P_JOB_ID,P_JOB_TITLE,P_MIN_SAL,P_MAX_SAL);
END;

EXEC NEW_JOB_PROC('SA_MAN1','SAMPLE TEST', 1000, 5000);

SELECT * FROM JOBS;

-------- 프로시저 IN변수를 활용(키값이 있다면 UPDATE, 없다면 INSERT)
--매개변수로 들어온 JOB_ID가 기존에 있다면 INSERT구문이 실행, 아니라면 UPDATE문 실행

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN JOBS.JOB_ID%TYPE,
     P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
     P_MIN_SAL IN JOBS.MIN_SALARY%TYPE,
     P_MAX_SAL IN JOBS.MAX_SALARY%TYPE
    )
IS
    V_COUNT NUMBER := 0; --지역변수
BEGIN
    --중복값 검사 (매개변수로 들어온 값이 기존에 없는 값이면 COUNT가 0 )
    SELECT COUNT(*) 
    INTO V_COUNT
    FROM JOBS 
    WHERE JOB_ID = P_JOB_ID;--프로시저의 매개변수로 들어오는 값
   
   IF V_COUNT = 0 THEN --카운트가 0이면 기존에 없는값임으로 INSERT문 실행,아니라면 기존 ID값에 다른컬럼의 값을 UPDATE.
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

--프로시저의 사용
EXEC NEW_JOB_PROC('SA_MAN1', 'SAMPLE TEST', 10000, 20200);

SELECT * FROM JOBS;

----------------------------------------------------------------
--만약 매개값을 4개를 넣어줘야하는 프로시저에 매개값을 2개만 넣어줬다면??
EXEC NEW_JOB_PROC('SA_MAN2', 'SAMPLE TEST'); --오류
--SQL에서는 자바와는 다르게 프로시저를 선언할때 기본값을 정해줘서
--매개변수로 값이 전달되지 않으면 기본값이 저장될 수 있게 선언할 수 있습니다.

--프로시저의 디폴트 매개값 설정(타입은 일치하게 지정해줘야 합니다.)
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN JOBS.JOB_ID%TYPE,
     P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
     P_MIN_SAL IN JOBS.MIN_SALARY%TYPE := 0, --만약 아무값도 전달되지 않으면 기본값은 0
     P_MAX_SAL IN JOBS.MAX_SALARY%TYPE := 1000 --만약 아무값도 전달되지 않으면 기본값은 1000
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

EXEC NEW_JOB_PROC('SA_MAN1','매개값4개',1 , 2000);

EXEC NEW_JOB_PROC('SA_MAN2','매개값2개');
SELECT * FROM JOBS;

DESC JOBS;

--------------------------------------------------

--OUT매개변수
--프로시저가 OUT변수를 가지고 있다면, 실행구문을 익명블록에서 실행합니다.

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN JOBS.JOB_ID%TYPE,
     P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
     P_MIN_SAL IN JOBS.MIN_SALARY%TYPE := 0,
     P_MAX_SAL IN JOBS.MAX_SALARY%TYPE :=1000,
     P_RESULT OUT VARCHAR2
    )
IS
    V_COUNT NUMBER := 0; --지역변수

BEGIN
    SELECT COUNT(*)
    INTO V_COUNT --지역변수
    FROM JOBS
    WHERE JOB_ID = P_JOB_ID;
    
    IF V_COUNT = 0 THEN
        INSERT INTO JOBS
        VALUES(P_JOB_ID,P_JOB_TITLE,P_MIN_SAL,P_MAX_SAL);
        
        P_RESULT := P_JOB_ID; --성공인 경우에는 아웃변수에 아이디를 저장
    ELSE
        UPDATE JOBS 
        SET JOB_TITLE = P_JOB_TITLE ,
            MIN_SALARY = P_MIN_SAL,
            MAX_SALARY = P_MAX_SAL
        WHERE JOB_ID = P_JOB_ID;
        
        P_RESULT := '존재하는 값이기 때문에 업데이트 되었습니다.';
    
    END IF;
    
    
END;
-------------------------------------------------------------------
DECLARE
    STR VARCHAR2(100); --OUT변수의 결과를 돌려받을 변수 선언
BEGIN
    NEW_JOB_PROC('TEST01', 'TEST02', 1000, 2000, STR); --EXEC빼고 
    DBMS_OUTPUT.PUT_LINE(STR);--결과
END;

SET SERVEROUTPUT ON;

--------------------------------------------------------------
--IN OUT변수
CREATE OR REPLACE PROCEDURE TEST_PROC
    (P_VAR1 IN VARCHAR2, --입력변수(반환불가)
     P_VAR2 OUT VARCHAR2, --출력변수(프로시저가 끝나기 전에는 값의 할당이 안됨.)
     P_VAR3 IN OUT VARCHAR2 --입,출력변수(둘다 가능)
    )
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('P_VAR1의 값: '||P_VAR1);
    DBMS_OUTPUT.PUT_LINE('P_VAR2의 값: '||P_VAR2);
    DBMS_OUTPUT.PUT_LINE('P_VAR3의 값: '||P_VAR3);
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
    (P_VAR1 IN VARCHAR2, --입력변수(반환불가)
     P_VAR2 OUT VARCHAR2, --출력변수(프로시저가 끝나기 전에는 값의 할당이 안됨.)
     P_VAR3 IN OUT VARCHAR2 --입,출력변수(둘다 가능)
    )
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('P_VAR1의 값: '||P_VAR1);
    DBMS_OUTPUT.PUT_LINE('P_VAR2의 값: '||P_VAR2);
    DBMS_OUTPUT.PUT_LINE('P_VAR3의 값: '||P_VAR3);
    
--    P_VAR1 := '결과1';  --(IN변수 할당불가)
    P_VAR2 := '결과2';
    P_VAR3 := '결과3';
    
END;

DECLARE
    V_A VARCHAR2(100) := 'A';
    V_B VARCHAR2(100) := 'B';
    V_C VARCHAR2(100) := 'C';
BEGIN
    TEST_PROC(V_A, V_B, V_C);
    DBMS_OUTPUT.PUT_LINE('P_VAR1의 값: '|| V_A);
    DBMS_OUTPUT.PUT_LINE('P_VAR2의 값: '|| V_B);
    DBMS_OUTPUT.PUT_LINE('P_VAR3의 값: '||V_C);
END;

-----------------------------------------------------

--프로시저의 종료 RETURN 키워드

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN JOBS.JOB_ID%TYPE    
    )
IS
    V_COUNT NUMBER:=0;
    V_MIN_TOTAL NUMBER := 0; --최소급여 전체합.
BEGIN
    --값이 없다면 출력후에 프로시저를 종료, 있다면 P_JOB_ID의 최소급여 전체합 출력
    SELECT COUNT(*)
    INTO V_COUNT
    FROM JOBS
    WHERE JOB_ID LIKE '%'|| P_JOB_ID ||'%' ; --P_JOB_ID로 들어온 값을 포함한모든 행조회
     
    IF V_COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE(P_JOB_ID||'값이 없습니다. 프로시저를 종료합니다.');
        RETURN;--프로시저의 종료
    ELSE
        --P_JOB_ID의 최소급여 전체합
        SELECT SUM(MIN_SALARY)
        INTO V_MIN_TOTAL
        FROM JOBS 
        WHERE JOB_ID LIKE  '%'||P_JOB_ID||'%';
        
        DBMS_OUTPUT.PUT_LINE(P_JOB_ID||'의 MIN_SALARY의 합: '||V_MIN_TOTAL);
    END IF;
      
    DBMS_OUTPUT.PUT_LINE('이 구문이 실행되었다면 IF문에서 RETURN을 타지않고 아래로 내려온 것입니다.');
END;

EXEC NEW_JOB_PROC('SSSSSSS');  --없는값

EXEC NEW_JOB_PROC('TEST'); --있는값

--연습문제

/*
EMPLOYEE_ID를 받아서 EMPLOYEES에 존재하면, 근속년수를 출력
없다면, 없습니다를 출력하는 프로시저를 만들어보세요.
*/

--IN을 사용하여 출력
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
       DBMS_OUTPUT.PUT_LINE(EMP_ID||' 번 아이디를 가진 직원은 없습니다.');
    ELSE
        SELECT TRUNC((SYSDATE-HIRE_DATE)/365,1)||'년'
        INTO EMP_DATE
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = EMP_ID; 
        
        DBMS_OUTPUT.PUT_LINE(EMP_ID||'번 직원의 근속년수는 '||EMP_DATE||'입니다.');
    END IF;
    
END;

EXEC EMP_PROC(100);
EXEC EMP_PROC(500);

--OUT을 사용하여 출력
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
       EMP_DATE := '해당 아이디를 가진 직원이 없습니다.';
       
    ELSE 
        SELECT EMP_ID||'번 직원의 근속년수는 '||TRUNC((SYSDATE-HIRE_DATE)/365,1)||'년'||'입니다.'
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

--선생님 풀이 

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
        DBMS_OUTPUT.PUT_LINE(P_EMP_ID||'는 없습니다.');
    ELSE
        SELECT TRUNC((SYSDATE - HIRE_DATE)/365)
        INTO V_YEAR
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = P_EMP_ID;
        
        DBMS_OUTPUT.PUT_LINE(P_EMP_ID||'의 근속년수: '||V_YEAR);
    END IF;

    --예외처리
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('예외발생');
END;

EXEC EMP_YEAR_PROC(100);
EXEC EMP_YEAR_PROC(500);


