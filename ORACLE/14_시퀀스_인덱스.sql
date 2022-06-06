--������ (���������� �����ϴ� ��)
select * from user_sequences;


--������ ������
create sequence dept2_seq; --�̷��Ը� �ĵ� �������� ������.

create sequence dept2_seq
    increment by 1 --������
    start with 1 --���۰�
    maxvalue 10 --�ִ밪
    nocache --ĳ�û��X
    nocycle; --�������� ���������� �ٽ�ó������ ���ư� X
    
drop table dept2;

create table dept2 (
    dept_no number(5) /*defualt dept2_seq.nextval */ primary key,
    dept_name varchar2(20),
    loca number(4)
);
--�������� ���
insert into dept2 values(dept2_seq.nextval, 'TEST' , 300);
--3���߰���.
select * from dept2;

--���� ������ Ȯ��
select dept2_seq.currval from dual;
select dept2_seq.nextval from dual;

select * from auth;
delete from auth where ID = 1;
insert into auth values(dept2_seq.nextval, 'test','test'); 
--�ٸ����̺� ���� �������� ������ġ�� ���̵�.
--��������.nextval ��ɹ��� ������ ���� ���ڰ� �ö�.

--������ ���� alter
alter sequence dept2_seq maxvalue 100000; --�ִ밪 100000����
alter sequence dept2_seq increment by 100; --������ 100����
alter sequence dept2_seq minvalue 1; --�ּҰ� 1����

alter table dept2 modify dept_no number(5);
select * from dept2;

--������ ���� drop
drop sequence dept2_seq;

--�������� �ٽ� ó������ �ǵ����� ���
create sequence dept2_seq 
    increment by 10
    nocache
    nocycle;
    
select dept2_seq.nextval from dual; 
--1.��������� Ȯ��
select dept2_seq.currval from dual;--���� 51
--2.�������� �����������ŭ-1��ŭ -(����)
alter sequence dept2_seq increment by -51;
--3.�ѹ� nextval
select dept2_seq.nextval from dual;
--4.�������� 1�� ����
alter sequence dept2_seq increment by 1;

--������ Ȱ�� pk�� ����: 20210408-������
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
--�ε���

--�ε����� primary key,unique ���������� ����� �� �ڵ����� �����ǰ�, �Ǵ� �������� ���� ������ �� �ֽ��ϴ�.
--�׷��� ���� ��ȸ�Ҷ��� pk�� uk�� ����ؼ� ��ȸ�ϴ� ���� ����.
--�ε����� �ε����� �����ϴ� �߰����� ������ ������ �����ǰ�, ��ȸ�� ������ �մϴ�.
--�ٸ� ����,����,������ ����ϰ� �Ͼ�� �÷��� �����ϸ� ������ ���ɺ��ϸ� ����ų�� �ֽ��ϴ�.

select * from emps where first_name = 'Nancy';
--first_name�� �ε����� ����Ǿ� �����ʾ� ��ȸ�Ϸ��� ���̺��� ó������ ������ �ϳ��ϳ� �˻��ؾ��Ѵ�.
--������ ���� �󸶵����ʾ� �ð��� �󸶰ɸ��������� index�� �������ָ� �� ������ ��ȸ�� �� �ִ�.
--������,�ε������� ��������� �����ϴ� �������̱⶧���� ���������� �ε����� ������ ������ ����߸���.

--emps�� first_name�� �ε��� �ο�
create index emp_first_name_idx on emps(first_name);
drop index emp_first_name_idx;

select * from emps where first_name = 'Nancy';
--F10���� ���� options�κ��� Ȯ���غ��� 
--index�� �����Ű�������� options�κ��� full�̶�� �����ִ�.
--index�� �����Ų�Ŀ��� options�κ��� �ٲ�� �� ���ִ�.

--�ε��� ����(�ε����� ����������, ���̺� ���� ������ ��ġ�� �ʽ��ϴ�.
drop index emp_first_name_idx;

--�ε����� hint�� ����ϴ� SQL��
create table t_board (
    bno number(10) primary key,
    writer varchar2(20)
);
create sequence t_board_seq;
insert into t_board values (t_board_seq.nextval,'TEST');--x100
COMMIT;

--40~50��° �����͸� ������. 
--�������
select *
from(select rownum as RN,
            BNO,
            WRITER
     from(select *
          from T_BOARD
          order by BNO desc) 
    )
where rn > 40 and rn <= 50;
--�� ������ index�� �̿��ϸ� ���� ª�� �����ϰ� ���� �� �ִ�. (���� pk bno�� �ڵ������� �ε��� �̸��� SYS_C007879�̴�.)

--�ε��� �̸� ����
alter index SYS_C007879 rename to t_board_idx;

select *
from(select /*+INDEX_DESC (T_BOARD t_board_idx) */
       rownum rn,
       bno,
       writer
from t_board)
where rn > 40 and rn <= 50; --���� �۾��� 3�߿��� 2������ ���� �� �ִ�

--sql���� ��Ʈ�� �ִ� Ű����(?) /*+  */


