--주석은 사용
--오라클에서 SQL문은 대소문자를 가리지 않습니다.
--구문 마지막에 ; 마감합니다.
--실행명령 CTRL + ENTER
--문자열,날짜는 왼쪽정렬, 숫자는 오른쪽 정렬.

SELECT * FROM Employees;  --임플로이 테이블의 *(모든값)

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME FROM EMPLOYEES;

SELECT EMPLOYEE_ID , HIRE_DATE, SALARY FROM EMPLOYEES;

--NULL 값 확인
SELECT EMPLOYEE_ID, SALARY, COMMISSION_PCT FROM EMPLOYEES;

--숫자 컬럼은 연산이 가능
SELECT EMPLOYEE_ID , SALARY , SALARY + SALARY * 0.1 FROM EMPLOYEES;

--엘리어스, 컬럼명의 별칭 정의 (AS)
SELECT EMPLOYEE_ID , SALARY , SALARY + SALARY * 0.1 AS 보너스 FROM EMPLOYEES;
SELECT FIRST_NAME AS 이름 , SALARY AS 급여 FROM EMPLOYEES;

SELECT EMPLOYEE_ID AS 사원아이디, 
       FIRST_NAME AS  이름 , 
       LAST_NAME AS 성,
       SALARY + SALARY*0.1 AS 급여 
       FROM EMPLOYEES;
       
--컬럼 연결 || , 문자열 표현의 '', 문자열안에서 인용부호 '를 쓰고싶다면 두번 쓰면 됩니다.
SELECT FIRST_NAME || LAST_NAME FROM EMPLOYEES;  --컬럼이 합쳐지고 컬럼명도 합쳐졌다.
SELECT FIRST_NAME || ' ' || LAST_NAME FROM EMPLOYEES;

SELECT first_name||' ' || LAST_NAME || '''s salary is $' || SALARY AS 급여내역
       FROM EMPLOYEES;

-- 행 중복 제거 distinct
select distinct department_id from employees;
select distinct salary from employees;

-- 출력순서(rownum) , 데이터위치(rowid)
select rowid, rownum, employee_id , first_name from employees;

select rownum, first_name from employees;
--employees테이블의 pk(기본키)는 employee_id인데 pk를 호출할때와 호출하지 않을때의 순서가 다를 수 있음.
--일반적으로 pk를 호출하면 더 빠름


--테이블정보 보기
desc employees;

