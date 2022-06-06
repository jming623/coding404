--PL/SQL문 (Program Language)

--절차형 SQL은 지정된 구문안에서 컴파일하는 형식으로 실행합니다.

--변수선언 및 출력
SET SERVEROUTPUT ON; -- 출력문 콘솔 활성화
--실행은 declare부분부터 end부분까지 드래그한뒤에 ctrl+enter 나 F5번으로 실행

DECLARE -- 변수 선언문
    VI_NUM NUMBER; --(변수명)(타입) - 숫자를 저장할 수 있는 변수
BEGIN -- 시작
    VI_NUM := 10; -- :=은 대입 
    DBMS_OUTPUT.PUT_LINE(VI_NUM); --출력문
END; --끝

--연산자  (+, -, /, *, <>, =, **(제곱) )
DECLARE
   A NUMBER := (2 * 3 + 2) ** 2;
BEGIN
    DBMS_OUTPUT.PUT_LINE('A='||A);
END;

--DML문과 혼용해서 사용(실제로 사용되는 QL문 형식)
--DDL문장은 사용할 수 없고 일반적으로 SELECT구문을 사용합니다. 
--특이한 점은 SELECT절 아래에 INTO절이 들어갑니다.
--SELECT로 조회해온 데이터를 INTO를 통해 변수에 저장합니다. 이때 데이터타입이 일치해야하고 값은 하나만 들어와야 합니다.
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
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME || '의 부서는' || DEP_NAME);
END;

/*
선언한 변수와 SELECT 로 조회한 결과의 데이터타입이 다르면, 오류를 발생시키는데,
해당 테이블의 컬럼과 동일한 타입의 변수를 선언하려면 테이블.컬럼명%TYPE문을 사용합니다. 
*/

DECLARE
    EMP_NAME EMPLOYEES.FIRST_NAME%TYPE; --EMPLOYEES테이블의 FIRST_NAME과 같은 타입으로 지정하겠다 라는 의미 
    EMP_HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE;
    EMP_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT FIRST_NAME , HIRE_DATE , SALARY
    INTO EMP_NAME,EMP_HIRE_DATE,EMP_SALARY
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME||'님의 입사일은'||EMP_HIRE_DATE||'이고, 월급은'||EMP_SALARY||'입니다.');
END;
  
/*
SELECT문과 INSERT문 DML문을 같이 사용할 수 있습니다.
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



