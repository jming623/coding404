---------���̺� ������ �������� ---------------------
--primary key (���̺��� ���� Ű �ߺ�X, null���X (unique�� not null�� Ư���� ��ģ�Ͱ�����.))
--unique key (�ߺ�X,null���� �� �� ����.)
--not null (null�� ���X)
--foreign key (�����ϴ� ���̺��� pk�� �����ϴ� �÷�,�������̺��� pk�� ���ٸ� ���X,�� null�� ����Ѵ�.)
--check (���ǵ� ���ĸ� ����ǵ��� ����)

create table dept2( --������ �������� (�÷������� ���� �ٷ� ���������� �ۼ���.)   
    dept_no number(2) constraint dept2_dept_no_pk primary key,
    dept_name varchar(15) not null,
    loca number(4) constraint dept2_loca_locid_fk references locations(location_id) ,
    dept_date date default sysdate, --DEFAULT�� ����Ǿ��ִٸ� �������� �ƹ����� �־����������� �ڵ����� DEFAULT���� ����ȴ�.
    dept_bonus number(10),
    dept_phone varchar2(20) not null constraint dept2_dept_phone_uk unique,--NOT NULL���ǰ� UNIQUE KEY������ �Բ� ����ִ�.
    dept_gender char(1) constraint dept2_dept_gender_ck check( dept_gender in('M','F') )
    );
    
DESC LOCATIONS; 
SELECT * FROM LOCATIONS;
 
--���������� �̷��� constraint�κ��� ������ �� �ִ�.(�̷��� �Ǹ� �������� �̸��� �� �ڵ����� �����ȴ�.)  
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
--���̺��� ��������

create table dept2 (
    dept_no number(2),
    dept_name varchar2(15) not null,
    loca number(4),
    dept_date date default sysdate,
    dept_bonus number(10),
    dept_phone varchar2(20) not null,
    dept_gender char(1),
--���̺� ���� ���������� �Ʒ��ʿ� �������Ǹ� �и��ؼ� �ۼ� (���̺� �������� ���������� �ɸ� ����Ű�� ������ �����մϴ�.)
    constraint dept2_dept_no_pk primary key (dept_no/*,dept_name*/), --����Ű�� �ĺ�Ű �ΰ��� ���ļ� �⺻Ű�� ����ϴ� ���� �ǹ��մϴ�.
--    constraint dept2_dept_name_null not null(dept_name), �ȵ�
    constraint dept2_loca_locid_fk foreign key(loca) references locations(location_id),
    constraint dept2_dept_phone_uk unique(dept_phone),
    constraint dpet2_dept_gender_ck check(dept_gender in('M','F') )
);

select * from dept2;
select * from employees; --where employee_id = 100;
desc employees;

--��ü���Ἲ ��������(null�� �ߺ��� ������� �ʴ´ٴ� ����)

--PK�ߺ� ��
insert into employees
(employee_id, last_name, email, hire_date,job_id)
values(100,'test','test',sysdate,'test'); --��ü���Ἲ (null�� �ߺ��� ������� �ʴ´ٴ� ����)
--employee_id�� pk�� �����Ǿ� �ߺ����� ���� �� ���µ� employee_id�� �̹� �ۼ����ִ� 100�� �־��ַ��� �ϴ� �����߻�.

--UK�ߺ� ��
insert into employees
(employee_id, last_name, email, hire_date,job_id)
values(207,'test','SKING',sysdate,'test');--��ü���Ἲ (null�� �ߺ��� ������� �ʴ´ٴ� ����)
--email�� unique�� �����Ǿ� �ߺ����� ���� �� ���µ� email�� �̹� �ۼ����ִ� 'SKING'�� �־��ַ��� �ϴ� �����߻�.

--null���� ��
insert into employees
(employee_id, last_name, hire_date,job_id)
values(207,'test',sysdate,'test');
--employees���̺��� email�÷��� not null������ �ɷ��ִµ� ���� �����Ҷ� email���� ���������� ������ �߻��Ѵ�.
--NULL�� ("HR"."EMPLOYEES"."EMAIL") �ȿ� ������ �� �����ϴ� �����߻�

--�������Ἲ �������� (FK���� �������̺��� PK�� �������ִ� ���� ���� �� �ִ�.)
insert into employees
(employee_id, last_name, email, hire_date,job_id,department_id)
values(207,'test','test',sysdate,'AD_PRES',9); --department_id�� 9��� ���� �ش�.
--departments���̺��� pk�� department_id�� 9��� ���� �� �����ʱ� ������ ���Ἲ �������ǿ� �����.

--������ ���Ἲ ��������(���� �÷��� ���ǵ� ���� ���̿��� �Ѵٴ� ����)
--employees���̺��� salary�÷����� check�������� salary>0�̶�� ������ �ִ�.
insert into employees (employee_id, last_name, email, hire_date, job_id, salary)
values(501,'test','test',sysdate,'test',-10);
--�̶� salary�� �������� �������� �ϸ� üũ ��������(HR.EMP_SALARY_MIN)�� ����Ǿ����ϴ� ��� ������ �߻��Ѵ�.

--�������� �߰�,���� alter table~
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

--pk�߰�
alter table dept2 add constraint dept2_dept_no_pk primary key (dept_no); --���⼭�� ����Ű ���� ���� 
--fk�߰�
alter table dept2 add constraint dept2_loca_fk foreign key (loca) references locations(location_id);
--check�߰�
alter table dept2 add constraint dept2_dept_gender_ck check (dept_gender in('M','F') );
--unique�߰�
alter table dept2 add constraint dept2_dept_phone_uk unique(dept_phone);
--not null�߰� (modify������ �߰�) �Ϲ������� �������� ����
alter table dept2 modify dept_phone varchar2(20) not null;
desc dept2

--�������� Ȯ��
select * from user_constraints; --hr�� �������ִ� ������̺��� ��� ���������� ��ȸ
select * from user_constraints where table_name = 'DEPT2'; 

--�������� ���� (�̸����� ����)
alter table dept2 drop constraint DEPT2_DEPT_NO_PK;

drop table dept2;
drop table members;

create table members (
        m_name varchar(10) not null,
        m_num number(3),
        reg_date date,
        gender char(1),
        loca number(5) --fk�� ����� �÷��� �������̺��� pk�Ӽ��� �Ȱ��� ����°��� ����.
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