---------테이블 생성과 제약조건 ---------------------
--primary key (테이블의 고유 키 중복X, null허용X (unique와 not null의 특성을 합친것과같음.))
--unique key (중복X,null값은 들어갈 수 있음.)
--not null (null값 허용X)
--foreign key (참조하는 테이블의 pk를 저장하는 컬럼,참조테이블의 pk가 없다면 등록X,단 null은 허용한다.)
--check (정의된 형식만 저장되도록 제한)

create table dept2( --열레벨 제약조건 (컬럼생성시 옆에 바로 제약조건을 작성함.)   
    dept_no number(2) constraint dept2_dept_no_pk primary key,
    dept_name varchar(15) not null,
    loca number(4) constraint dept2_loca_locid_fk references locations(location_id) ,
    dept_date date default sysdate, --DEFAULT가 선언되어있다면 열생성시 아무값도 넣어주지않으면 자동으로 DEFAULT값이 저장된다.
    dept_bonus number(10),
    dept_phone varchar2(20) not null constraint dept2_dept_phone_uk unique,--NOT NULL조건과 UNIQUE KEY조건을 함께 들고있다.
    dept_gender char(1) constraint dept2_dept_gender_ck check( dept_gender in('M','F') )
    );
    
DESC LOCATIONS; 
SELECT * FROM LOCATIONS;
 
--위에구문은 이렇게 constraint부분이 생략될 수 있다.(이렇게 되면 제약조건 이름이 다 자동으로 지정된다.)  
create table dept2(
    dept_no number(2)  primary key,
    dept_name varchar(15) not null,
    loca number(4)  references locations(location_id) ,
    dept_date date default sysdate,
    dept_bonus number(10),
    dept_phone varchar2(20) not null  unique,
    dept_gender char(1)  check( dept_gender in('M','F') )
    );
  
drop table dept2;    
drop table dept3;     
--테이블레벨 제약조건

create table dept2 (
    dept_no number(2),
    dept_name varchar2(15) not null,
    loca number(4),
    dept_date date default sysdate,
    dept_bonus number(10),
    dept_phone varchar2(20) not null,
    dept_gender char(1),
--테이블 레벨 제약조건은 아래쪽에 제약조건만 분리해서 작성 (테이블 레벨에서 제약조건을 걸면 슈퍼키의 선언이 가능합니다.)
    constraint dept2_dept_no_pk primary key (dept_no/*,dept_name*/), --슈퍼키는 후보키 두개를 합쳐서 기본키로 사용하는 것을 의미합니다.
--    constraint dept2_dept_name_null not null(dept_name), 안됨
    constraint dept2_loca_locid_fk foreign key(loca) references locations(location_id),
    constraint dept2_dept_phone_uk unique(dept_phone),
    constraint dpet2_dept_gender_ck check(dept_gender in('M','F') )
);

select * from dept2;
select * from employees; --where employee_id = 100;
desc employees;

--개체무결성 제약조건(null과 중복을 허용하지 않는다는 제약)

--PK중복 예
insert into employees
(employee_id, last_name, email, hire_date,job_id)
values(100,'test','test',sysdate,'test'); --개체무결성 (null과 중복을 허용하지 않는다는 제약)
--employee_id가 pk로 지정되어 중복값이 들어올 수 없는데 employee_id로 이미 작성되있는 100을 넣어주려고 하니 오류발생.

--UK중복 예
insert into employees
(employee_id, last_name, email, hire_date,job_id)
values(207,'test','SKING',sysdate,'test');--개체무결성 (null과 중복을 허용하지 않는다는 제약)
--email이 unique로 지정되어 중복값이 들어올 수 없는데 email로 이미 작성되있는 'SKING'을 넣어주려고 하니 오류발생.

--null오류 예
insert into employees
(employee_id, last_name, hire_date,job_id)
values(207,'test',sysdate,'test');
--employees테이블의 email컬럼은 not null조건이 걸려있는데 열을 삽입할때 email값을 주지않으면 오류가 발생한다.
--NULL을 ("HR"."EMPLOYEES"."EMAIL") 안에 삽입할 수 없습니다 오류발생

--참조무결성 제약조건 (FK에는 참조테이블이 PK로 가지고있는 값만 들어올 수 있다.)
insert into employees
(employee_id, last_name, email, hire_date,job_id,department_id)
values(207,'test','test',sysdate,'AD_PRES',9); --department_id로 9라는 값을 준다.
--departments테이블의 pk값 department_id중 9라는 값은 들어가 있지않기 때문에 무결성 제약조건에 위배됨.

--도메인 무결성 제약조건(값이 컬럼에 정의된 속한 값이여야 한다는 제약)
--employees테이블의 salary컬럼에는 check조건으로 salary>0이라는 조건이 있다.
insert into employees (employee_id, last_name, email, hire_date, job_id, salary)
values(501,'test','test',sysdate,'test',-10);
--이때 salary에 음수값을 넣으려고 하면 체크 제약조건(HR.EMP_SALARY_MIN)이 위배되었습니다 라는 오류가 발생한다.

--제약조건 추가,삭제 alter table~
drop table dept2;

create table dept2(
    dept_no number(2),
    dept_name varchar(15),
    loca number(4) ,
    dept_date date default sysdate,
    dept_bonus number(10),
    dept_phone varchar2(20) ,
    dept_gender char(1)
);

--pk추가
alter table dept2 add constraint dept2_dept_no_pk primary key (dept_no); --여기서도 슈퍼키 적용 가능 
--fk추가
alter table dept2 add constraint dept2_loca_fk foreign key (loca) references locations(location_id);
--check추가
alter table dept2 add constraint dept2_dept_gender_ck check (dept_gender in('M','F') );
--unique추가
alter table dept2 add constraint dept2_dept_phone_uk unique(dept_phone);
--not null추가 (modify문으로 추가) 일반적으로 열레벨의 정의
alter table dept2 modify dept_phone varchar2(20) not null;
desc dept2

--제약조건 확인
select * from user_constraints; --hr이 가지고있는 모든테이블의 모든 제약조건을 조회
select * from user_constraints where table_name = 'DEPT2'; 

--제약조건 삭제 (이름으로 삭제)
alter table dept2 drop constraint DEPT2_DEPT_NO_PK;

drop table dept2;
drop table members;

create table members (
        m_name varchar(10) not null,
        m_num number(3),
        reg_date date,
        gender char(1),
        loca number(5) --fk로 사용할 컬럼은 참조테이블의 pk속성과 똑같이 만드는것이 좋다.
);

alter table members add constraint members_m_num_pk primary key (m_num);
alter table members add constraint members_reg_date_uk unique(reg_date);
alter table members modify reg_date date default sysdate not null;
alter table members add constraint members_loca_fk foreign key(loca) references locations(location_id);
alter table members modify gender varchar(5);

insert into members values ('AAA',1,'2018/07/01','m' ,1800 );
update members set gender = 'M' where m_num = 1;
insert into members values ('BBB',2,'2018-07-02','F' ,1900 );
insert into members values ('CCC',3,'2018-07-03','M' ,2000 );
insert into members (m_name, m_num, gender, loca) values ('DDD',4,'M' ,2000 );

select * from user_constraints where lower(table_name) = 'members';
desc members;
select * from members;

select m.m_num,
       m.m_name,
       l.street_address,
       m.loca
from members m
inner join locations l on m.loca = l.location_id
order by m.m_num asc;