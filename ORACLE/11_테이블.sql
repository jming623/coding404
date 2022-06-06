--DDL문 (데이터베이스 정의문)
--트랜잭션을 적용할 수 없습니다.(rollback불가능)

--오라클은 테이블명의 대소문자를 가리지 않습니다.
--테이블생성 create table (테이블명) ~~
create table DEPT2(
    dept_no number(2,0), -- dept_no라는 컬럼은 두자리까지의 숫자가 저장될 수 있다.(소숫점 허용X)
    dept_name varchar2(14), --dept_name라는 컬럼은 14바이트까지의 문자열을 저장할 수 있다.(영어 14자리 , 한글 7자리까지 허용)
    loca varchar2(10),
    dept_date date,
    dept_bonus number(10),
    del_yn char(1) -- 고정문자 1개
);

desc dept2;
insert into dept2 values(99, '영업' , '서울' , '21/04/06', 1000000000 , 'Y');

select * from dept2;

--테이블 컬럼 추가,수정,이름변경, 삭제. 

--alter table(테이블명) (add/ modify/ rename column/ drop column) ~~~

--열추가 add
alter table dept2 add (dept_count number(3) );--dept2테이블에 dept_count라는 이름을 가진, 숫자세자리까지 들어올 수 있는 컬럼을 만들겠다.

--열 이름 변경 rename
alter table dept2 rename column dept_count to emp_count;

--열 수정 modify 열의 속성?타입?을 수정
alter table dept2 modify (emp_count number(10) );

--열 삭제 drop
alter table dept2 drop column emp_count;

--테이블 삭제 (drop은 위험하니 조심)
--drop table (테이블명);
drop table dept2;
drop table employees;--지워지지 않는 이유 employees에 또 다른테이블이 기본키로 가지고 있는 외래키가 있기때문에 
--drop table employees cascade constaints 제약조건명; 연관된 키제약 조건을 지우면서 삭제(절대절대 사용하면 안됨.)

--테이블 데이터 비우기
--truncate table 테이블명

select * from dept2;
truncate table dept2; 
drop table dept2;
--drop,truncate,cascade 이런얘들은 모두 금기어 입니다!!!!!!


