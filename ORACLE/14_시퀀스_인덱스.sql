--시퀀스 (순차적으로 증가하는 값)
select * from user_sequences;


--시퀀스 생성문
create sequence dept2_seq; --이렇게만 쳐도 시퀀스가 생성됨.

create sequence dept2_seq
    increment by 1 --증가값
    start with 1 --시작값
    maxvalue 10 --최대값
    nocache --캐시사용X
    nocycle; --마지막에 도달했을때 다시처음으로 돌아감 X
    
drop table dept2;

create table dept2 (
    dept_no number(5) /*defualt dept2_seq.nextval */ primary key,
    dept_name varchar2(20),
    loca number(4)
);
--시퀀스의 사용
insert into dept2 values(dept2_seq.nextval, 'TEST' , 300);
--3번추가함.
select * from dept2;

--현재 시퀀스 확인
select dept2_seq.currval from dual;
select dept2_seq.nextval from dual;

select * from auth;
delete from auth where ID = 1;
insert into auth values(dept2_seq.nextval, 'test','test'); 
--다른테이블에 들어가도 시퀀스의 현재위치로 값이들어감.
--시퀀스명.nextval 명령문은 오류가 나도 숫자가 올라감.

--시퀀스 변경 alter
alter sequence dept2_seq maxvalue 100000; --최대값 100000변경
alter sequence dept2_seq increment by 100; --증가값 100변경
alter sequence dept2_seq minvalue 1; --최소값 1변경

alter table dept2 modify dept_no number(5);
select * from dept2;

--시퀀스 삭제 drop
drop sequence dept2_seq;

--시퀀스를 다시 처음으로 되돌리는 방법
create sequence dept2_seq 
    increment by 10
    nocache
    nocycle;
    
select dept2_seq.nextval from dual; 
--1.현재시퀀스 확인
select dept2_seq.currval from dual;--현재 51
--2.증가값을 현재시퀀스만큼-1만큼 -(빼기)
alter sequence dept2_seq increment by -51;
--3.한번 nextval
select dept2_seq.nextval from dual;
--4.증가값을 1로 변경
alter sequence dept2_seq increment by 1;

--시퀀스 활용 pk의 형식: 20210408-시퀀스
create table dept3 (
    dept_no varchar2(30) primary key,
    dept_name varchar(30)
);

insert into dept3
values( to_char(sysdate,'YYYYMMDD')||'-'|| lpad(dept2_seq.nextval,5,0) , 'TEST' );

insert into dept3
values( select to_char(sysdate,'YYYYMMDD')||'-'|| a.n,
               'TEST'||a.n
        from (select lpad(dept2_seq.nextval,5,0) n
              from dual) a
);

select * from dept3;

select employee_id||'1' from employees;
--인덱스

--인덱스는 primary key,unique 제약조건을 사용할 때 자동으로 생성되고, 또는 수동으로 직접 생성할 수 있습니다.
--그래서 값을 조회할때는 pk나 uk를 사용해서 조회하는 것이 좋다.
--인덱스는 인덱스를 저장하는 추가적인 공간을 가지고 생성되고, 조회를 빠르게 합니다.
--다만 수정,삭제,변경이 빈번하게 일어나는 컬럼에 적용하면 오히려 성능부하를 일으킬수 있습니다.

select * from emps where first_name = 'Nancy';
--first_name은 인덱스가 적용되어 있지않아 조회하려면 테이블을 처음부터 끝까지 하나하나 검색해야한다.
--지금은 열이 얼마되지않아 시간이 얼마걸리지않지만 index를 적용해주면 더 빠르게 조회할 수 있다.
--하지만,인덱스또한 저장공간을 차지하는 데이터이기때문에 무차별적인 인덱스의 생성은 성능을 떨어뜨린다.

--emps에 first_name에 인덱스 부여
create index emp_first_name_idx on emps(first_name);
drop index emp_first_name_idx;

select * from emps where first_name = 'Nancy';
--F10번을 눌러 options부분을 확인해보면 
--index를 적용시키기전에는 options부분이 full이라고 적혀있다.
--index를 적용시킨후에는 options부분이 바뀐걸 볼 수있다.

--인덱스 삭제(인덱스는 지워지더라도, 테이블에 전혀 영향을 미치지 않습니다.
drop index emp_first_name_idx;

--인덱스를 hint로 사용하는 SQL문
create table t_board (
    bno number(10) primary key,
    writer varchar2(20)
);
create sequence t_board_seq;
insert into t_board values (t_board_seq.nextval,'TEST');--x100
COMMIT;

--40~50번째 데이터만 꺼낸다. 
--원래방법
select *
from(select rownum as RN,
            BNO,
            WRITER
     from(select *
          from T_BOARD
          order by BNO desc) 
    )
where rn > 40 and rn <= 50;
--위 구문을 index를 이용하면 좀더 짧고 간단하게 만들 수 있다. (현재 pk bno에 자동생성된 인덱스 이름은 SYS_C007879이다.)

--인덱스 이름 변경
alter index SYS_C007879 rename to t_board_idx;

select *
from(select /*+INDEX_DESC (T_BOARD t_board_idx) */
       rownum rn,
       bno,
       writer
from t_board)
where rn > 40 and rn <= 50; --같은 작업을 3중에서 2중으로 끝낼 수 있다

--sql문의 힌트를 주는 키워드(?) /*+  */


