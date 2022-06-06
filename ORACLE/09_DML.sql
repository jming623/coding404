--테이블 구조 확인 desc (테이블명);
desc departments;

--DML문 (Data Manipuration Language)
--insert,update,delete,merge,ctas       

--insert문

--1st insert into (테이블명)(컬럼명 지정)values(추가하고싶은 값)
--(작성하고자 하는 컬럼을 지정하고 values뒤에 추가하고자 하는 값을 넣어준다)
insert into departments(department_id,department_name,manager_id,location_id) values (290,'개발자',200 ,1700);
insert into departments(department_id,department_name,location_id) values(300,'디자이너',1700);
insert into departments(department_id,department_name) values(310,'DBA');
insert into departments(department_name,department_id) values('서버관리자' , 320);

select * from departments;

insert into departments values(280,'영업부',100,1700);
update departments
set department_id = 290,
    department_name = '금융',
    manager_id = 200,
    location_id = 2000
where department_id = 280;


delete from departments where department_id = 290;                    

--2ed(모든컬럼의 값을 지정해주고 싶을때는 컬럼지정을 생략할 수 있다. )
--(values 뒤에 컬럼 순서대로 값을 적어줍니다.)
insert into departments values(330,'퍼블리셔',200,1700);
insert into departments values(340,'데이터 분석가',200,1700);

--DML 문장은 트랜잭션을 통해서 DML이전으로 되돌릴 수 있습니다.
rollback;
select * from departments;

--테이블 구조 복사
create table managers as (select * from employees where 1 = 2); 
select * from managers ;

--3nd (다른테이블의 특정 행, 서브쿼리절 insert) 

--모든컬럼의 값을 추가할때에는 컬럼지정을 생략할 수 있다.
--서브쿼리가 들어오는경우 values가 들어가지않는다.
insert into managers (select * from employees where job_id = 'IT_PROG');
--원하는 컬럼의 값만 추가하고싶으면 직접 지정해줄 수 있다.
insert into managers(employee_id, last_name, email, hire_date, job_id)
      (select employee_id, last_name, email, hire_date, job_id from employees where job_id = 'FI_ACCOUNT');
--나머지값은 NULL값이 들어오게됨. 그러니 NULL이들어올수 없는 컬럼은 무조건 선택해주어야함.

select * from managers ;

--UPDATE문 
desc employees;

create table emps as (select * from employees where 1 = 1);

select * from emps;

update emps set salary = 30000;
--만약 잘못해서 where절로 조건을 정의하지 않고 구문을 실행했다?
--모든열의 salary 컬럼의 값이 전부 다 바뀜. 

--UPDATE문은 조건절을 반드시 명시해야 합니다.
select * from emps where employee_id = 100; --값이 하나임을 확인하고 실행한다. --기존 직원아이디100인 사람의 월급은 24000
update emps set salary = salary* 1.1 where employee_id = 100; --pk기준

select * from emps where employee_id = 100;-- 26400으로 바뀜

UPDATE EMPS
SET PHONE_NUMBER = '511.123.1111', ---여러 컬럼을 바꿔주고싶으면 ,를 사용하면 된다.
    HIRE_DATE = SYSDATE,           --모두 바꿔주고 싶어도 *를 사용할 수는 없다.
    COMMISSION_PCT = 0.1
WHERE EMPLOYEE_ID = 100;
            
select * from emps where employee_id = 100; 


--JOB_ID가 IT_PROG인 사람의 커미션 0.1로 업데이트

UPDATE EMPS SET COMMISSION_PCT = 0.1 WHERE JOB_ID = 'IT_PROG';
            
SELECT * FROM EMPS WHERE JOB_ID = 'IT_PROG';            


--WHERE절에 서브쿼리            
UPDATE EMPS 
SET COMMISSION_PCT = 0.2 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPS WHERE FIRST_NAME ='Donald') ;

SELECT * FROM EMPS WHERE DEPARTMENT_ID = 50;

--SET절에 서브쿼리
--UPDATE EMPS SET () = (서브쿼리) WHERE 조건

UPDATE EMPS SET (JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID ) =
                (SELECT JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 102;
--서브쿼리를 사용하기전엔 항상 값이 확실한지 한번 확인하는것이 좋다.

SELECT JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 UNION ALL
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 102;

ROLLBACK;

--DELETE
SELECT * FROM DEPARTMENTS;

--(EMPLOYEES테이블에서 50번부서를 참조하여 사용중이기 때문에 삭제이상)- 참조무결성제약조건 위배
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID =50; 

SELECT * FROM EMPS WHERE EMPLOYEE_ID = 105;
DELETE FROM EMPS WHERE EMPLOYEE_ID = 105;

SELECT * FROM EMPS;


--WHERE절의 서브쿼리
SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping';

delete from emps where department_id = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping');
--위의 구문을 실행하면 department_id가 50인 45명의 정보가 사라진다.

select * from emps;

rollback;


--테이블 생성(Create Table AS)
CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES WHERE 1=2);  --WHERE 1=2는 구조만 복사
SELECT * FROM EMPS_IT;
CREATE TABLE EMPS_ITT AS (SELECT * FROM EMPLOYEES WHERE 1=1); -- 1=1은 데이터도 복사 생략하게 되면 자동으로 1=1
SELECT * FROM EMPS_ITT;

INSERT INTO EMPS_IT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES( 103, 'GILDONG' , 'KKKK' , SYSDATE ,  'IT_PROG') ;

UPDATE EMPS_IT SET LAST_NAME = 'GIL DONG' , FIRST_NAME = 'HONG' WHERE EMPLOYEE_ID = 103;
DROP TABLE EMPS_IT;
SELECT * FROM EMPS_IT;
DESC EMPS_IT;
INSERT INTO EMPS_IT VALUES(103,'T1','T2','T3','T4',SYSDATE,'T5',5000,1,100,150);
---------------------------MERGE--------------------------------------- 
--MERGE INTO 타겟 엘리어스
--USING(병합시킬 테이블의 데이터)
--ON (두 테이블의 연결조건)
--WHEN MATCHED THEN (일치할 경우 수행할 작업)
--WHEN NOT MATCHED THEN(일치하지 않을 경우 수행할 작업)

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
        
        
--실습 
-- employees 테이블이 매번 수정되는 테이블이라고 가정. 주마다 emps_it 를 업데이트
-- 기존의 데이터는 email, phone , salary , commission, manager_id , department_id는 업데이트 되도록 처리
-- 새로 유입된 데이터는 모든 컬럼을 그대로 추가.
INSERT INTO EMPS_IT (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID) 
VALUES(102, '홍', '길동' , 'HONG' , '01/04/06' , 'AD_VP');
INSERT INTO EMPS_IT (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID) 
VALUES(101, '니나', '킴' , 'KIM' , '20/03/04' , 'AD_VP');

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
        
--예상결과 ID 104,5,6,7은 NULL값에 기존EMPLOYEES테이블 104,567이가지고있는 값들이 들어올것이고,
--니나와 길동의 이름은 그대로인상태로 101,102번의 정보(번호,월급,보너스,매니저,부서)가 생길것이고,
--총107의 열을 가지고있는 EMPLOYEES테이블을 연결시키면  현재 가지고있는 7개의 열은 수정될 것이고  나머지 100개열은 추가될 것이다.
--맞을까?
SELECT * FROM EMPS_IT ORDER BY EMPLOYEE_ID;


--CTAS (사본테이블) --PK,FK와 같은 키의 특성까지는 복사하지 않습니다. (NULL의 여부만 복사)
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS /*WHERE 1=1*/) --생략하면 자동으로 1=1(데이터 까지 복사) ,1=2는 구조만 복사