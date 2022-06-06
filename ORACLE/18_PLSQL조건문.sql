--새로운 페이지로 넘어왔을때는 
SET SERVEROUTPUT ON;

--DB에서 랜덤수 추출
SELECT TRUNC(DBMS_RANDOM.VALUE(1,11)) FROM DUAL; --1~10까지 소숫점제거해서

--IF문 (IF THEN , ELSE , END IF)
DECLARE
    NUM1 NUMBER := 5;
    NUM2 NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,11)); --랜덤수 저장
BEGIN
    IF NUM1 > NUM2 
    THEN DBMS_OUTPUT.PUT_LINE( NUM1||'(이)가 큰 수입니다.');
    
    ELSE
        DBMS_OUTPUT.PUT_LINE(NUM2||'(이)가 큰 수입니다.');
    
    END IF;
END;

--ELSIF문
DECLARE
    RAN_NUM NUMBER(5) := TRUNC(DBMS_RANDOM.VALUE(1,101));
BEGIN
    IF RAN_NUM >= 90 THEN
    DBMS_OUTPUT.PUT_LINE('A학점 입니다.');    
    ELSIF RAN_NUM >= 80 THEN
    DBMS_OUTPUT.PUT_LINE('B학점 입니다.'); 
    ELSIF RAN_NUM >=70 THEN
    DBMS_OUTPUT.PUT_LINE('C학점 입니다.');
    ELSE
    DBMS_OUTPUT.PUT_LINE('D학점 입니다.'); 
        END IF;  
END;


/*
연습문제
첫번째 값은 ROWNUM을 이용하시면 됩니다.
1~120사이의 랜덤한 번호를 이용해서 랜덤DEPARTMENT_ID의 첫번째 행만 SELECT합니다.
뽑은 사람의 SALARY가 9000이상이면 높음, 5000이상이면 중간, 나머지는 낮음으로 출력.
*/

DECLARE
    EMP_SAL EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT SALARY
    INTO EMP_SAL
    FROM(SELECT ROWNUM RN, SALARY
        FROM EMPLOYEES 
        WHERE DEPARTMENT_ID = TRUNC(DBMS_RANDOM.VALUE(1,13))*10)
    WHERE RN = 1;
    
    IF EMP_SAL >=9000 THEN
    DBMS_OUTPUT.PUT_LINE('높음');
    ELSIF EMP_SAL >=5000 THEN
    DBMS_OUTPUT.PUT_LINE('중간');
    ELSE
    DBMS_OUTPUT.PUT_LINE('낮음');
    END IF;
END;

--선생님 풀이

SELECT ROUND(DBMS_RANDOM.VALUE(10,120),-1) FROM DUAL; --부서값이 될 랜덤값

DECLARE
    SAL EMPLOYEES.SALARY%TYPE;
    RAN NUMBER := ROUND(DBMS_RANDOM.VALUE(10,120),-1);
BEGIN
    SELECT SALARY
    INTO SAL
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = RAN AND ROWNUM=1;
    
    DBMS_OUTPUT.PUT_LINE('급여:'||SAL);
    
    IF SAL >=9000 THEN
       DBMS_OUTPUT.PUT_LINE('높음');
    ELSIF SAL >=5000 THEN
       DBMS_OUTPUT.PUT_LINE('중간'); 
    ELSE
       DBMS_OUTPUT.PUT_LINE('낮음'); 
    END IF;
END;

SELECT SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 70 AND ROWNUM = 1;

--CASE문
--위의 IF문으로 작성된 연습문제를 CASE문으로 바꿔보자

DECLARE
    SAL EMPLOYEES.SALARY%TYPE;
    RAN NUMBER := ROUND(DBMS_RANDOM.VALUE(10,120),-1); -- 
BEGIN
    SELECT SALARY
    INTO SAL
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = RAN AND ROWNUM =1;
    
    DBMS_OUTPUT.PUT_LINE(SAL);
--CASE WHEN 조건문 THEN    
    CASE WHEN SAL >= 9000 THEN
            DBMS_OUTPUT.PUT_LINE('높음');
         WHEN SAL >= 5000 THEN
            DBMS_OUTPUT.PUT_LINE('중간');
         ELSE
            DBMS_OUTPUT.PUT_LINE('낮음');
    END CASE;
END;

SET SERVEROUTPUT ON;

SELECT TRUNC(DBMS_RANDOM.VALUE(1,3)) FROM DUAL;

DECLARE
    NUM1 NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,3));
BEGIN
--CASE 변수 WHEN 값 THEN
    CASE NUM1 WHEN 1 THEN
    DBMS_OUTPUT.PUT_LINE('1입니다.');
    WHEN 2 THEN 
    DBMS_OUTPUT.PUT_LINE('2입니다.');
    ELSE 
    DBMS_OUTPUT.PUT_LINE('뭐죠.');
    END CASE;
END;

--예외처리구문 (EXCEPTION WHEN 예외종류 THEN)
DECLARE
    V_NUM NUMBER := 0;
BEGIN
    
    V_NUM := 10 / 0;
    
    EXCEPTION WHEN OTHERS THEN  -- OTHERS는 모든예외를 받아 처리해줄 수 있는 예외이름
        DBMS_OUTPUT.PUT_LINE('0으로는 나눌 수 없습니다.');
END;

--랜덤부서별 첫번째 사람의 연봉구하기
DECLARE 
    EMP_SAL NUMBER(5);
    EMP_DEPT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,13))*10 ;
BEGIN
    
    SELECT SALARY
    INTO EMP_SAL
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = EMP_DEPT AND ROWNUM=1;
    
    DBMS_OUTPUT.PUT_LINE('부서:'||EMP_DEPT);
    
    DBMS_OUTPUT.PUT_LINE('연봉:'||EMP_SAL);
    
    CASE WHEN EMP_SAL >= 9000 THEN
    DBMS_OUTPUT.PUT_LINE('높음');
    WHEN EMP_SAL >= 5000 THEN
    DBMS_OUTPUT.PUT_LINE('중간');
    ELSE
    DBMS_OUTPUT.PUT_LINE('낮음');
    END CASE; 
    
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('해당부서의 인원이 없습니다.');
END;


