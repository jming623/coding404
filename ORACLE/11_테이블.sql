--DDL�� (�����ͺ��̽� ���ǹ�)
--Ʈ������� ������ �� �����ϴ�.(rollback�Ұ���)

--����Ŭ�� ���̺���� ��ҹ��ڸ� ������ �ʽ��ϴ�.
--���̺���� create table (���̺��) ~~
create table DEPT2(
    dept_no number(2,0), -- dept_no��� �÷��� ���ڸ������� ���ڰ� ����� �� �ִ�.(�Ҽ��� ���X)
    dept_name varchar2(14), --dept_name��� �÷��� 14����Ʈ������ ���ڿ��� ������ �� �ִ�.(���� 14�ڸ� , �ѱ� 7�ڸ����� ���)
    loca varchar2(10),
    dept_date date,
    dept_bonus number(10),
    del_yn char(1) -- �������� 1��
);

desc dept2;
insert into dept2 values(99, '����' , '����' , '21/04/06', 1000000000 , 'Y');

select * from dept2;

--���̺� �÷� �߰�,����,�̸�����, ����. 

--alter table(���̺��) (add/ modify/ rename column/ drop column) ~~~

--���߰� add
alter table dept2 add (dept_count number(3) );--dept2���̺� dept_count��� �̸��� ����, ���ڼ��ڸ����� ���� �� �ִ� �÷��� ����ڴ�.

--�� �̸� ���� rename
alter table dept2 rename column dept_count to emp_count;

--�� ���� modify ���� �Ӽ�?Ÿ��?�� ����
alter table dept2 modify (emp_count number(10) );

--�� ���� drop
alter table dept2 drop column emp_count;

--���̺� ���� (drop�� �����ϴ� ����)
--drop table (���̺��);
drop table dept2;
drop table employees;--�������� �ʴ� ���� employees�� �� �ٸ����̺��� �⺻Ű�� ������ �ִ� �ܷ�Ű�� �ֱ⶧���� 
--drop table employees cascade constaints �������Ǹ�; ������ Ű���� ������ ����鼭 ����(�������� ����ϸ� �ȵ�.)

--���̺� ������ ����
--truncate table ���̺��

select * from dept2;
truncate table dept2; 
drop table dept2;
--drop,truncate,cascade �̷������ ��� �ݱ�� �Դϴ�!!!!!!


