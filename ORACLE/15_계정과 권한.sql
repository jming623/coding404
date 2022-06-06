--SYS 계정에서 작성됨.
--XEPDB 데이터베이스에 sys계정 DBA권한으로 접속

--DCL문 (Database Control Language)

--사용자 계정 생성
create user user1 identified by user1;

--사용자 계정에 권한부여 (grant 권한 to 계정)
grant create session,create table, create view, create sequence, create procedure to user1;--기본적인 권한 procedure은 

--테이블 스페이스를 생성 or 기존에 있는 테이블 스페이스를 지정
--alter user 계정명 default tablespace 테이블스페이스명 quota unlimited on 테이블스페이스명
alter user user1 default tablespace users quota unlimited on users;
--user1에 users의 테이블스페이스를 주고 ~~ 

--사용자 계정에 권한을 회수   grant <-> revoke
--(revoke 권한 from 계정
revoke create session,create table, create view, create sequence, create procedure from user1;

--계정 삭제 (굉장히 위험한 작업, 연습할때만 사용해야함.)
drop user user1 CASCADE;

--2nd (롤을 이용한 권한 부여)
create user user1 identified by user1;

grant connect, resource to user1; 
--connect는 연결관련 권한이 담긴 롤
--resource는 입력 수정관련 권한이 담긴 롤
--DBA는 모든 권한이 담긴 롤
alter user user1 default tablespace USERS quota unlimited on USERS;

--마우스로도 계정생성, 권한부여, 테이블스페이스 지정이 가능합니다. (보기탭 -> DBA ->