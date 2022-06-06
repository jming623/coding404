--SYS �������� �ۼ���.
--XEPDB �����ͺ��̽��� sys���� DBA�������� ����

--DCL�� (Database Control Language)

--����� ���� ����
create user user1 identified by user1;

--����� ������ ���Ѻο� (grant ���� to ����)
grant create session,create table, create view, create sequence, create procedure to user1;--�⺻���� ���� procedure�� 

--���̺� �����̽��� ���� or ������ �ִ� ���̺� �����̽��� ����
--alter user ������ default tablespace ���̺����̽��� quota unlimited on ���̺����̽���
alter user user1 default tablespace users quota unlimited on users;
--user1�� users�� ���̺����̽��� �ְ� ~~ 

--����� ������ ������ ȸ��   grant <-> revoke
--(revoke ���� from ����
revoke create session,create table, create view, create sequence, create procedure from user1;

--���� ���� (������ ������ �۾�, �����Ҷ��� ����ؾ���.)
drop user user1 CASCADE;

--2nd (���� �̿��� ���� �ο�)
create user user1 identified by user1;

grant connect, resource to user1; 
--connect�� ������� ������ ��� ��
--resource�� �Է� �������� ������ ��� ��
--DBA�� ��� ������ ��� ��
alter user user1 default tablespace USERS quota unlimited on USERS;

--���콺�ε� ��������, ���Ѻο�, ���̺����̽� ������ �����մϴ�. (������ -> DBA ->