##주석 (마이에스큐엘은 대소문자를 구별합니다.)
##( oracle -> mysql ) NUMBER -> int , varchar2 -> varchar, date -> datetime , sysdate -> current_timestamp

##게시글 테이블
create table FREEBOARD(
    bno int(10) primary key auto_increment, ## mysql에 시퀀스 사용방법
    title varchar(200) not null,
    writer varchar(200) not null,
    content varchar(2000) not null,
    regdate datetime default current_timestamp,
    updatedate datetime default current_timestamp
);

##오라클의 게시글 시퀀스
##create sequence freeboard_seq increment by 1 start with 1 nocache;

##=================================================================================================================

##댓글 테이블(논리적 구조에서는 글과 댓글이 1:n관계를 가지기 때문에 freeboard에 pk가 freereply에 fk가 되어야하지만,
##물리적 구조에서 fk로 잡아주면 글을 삭제할때 댓글이 존재해 삭제되지 못하는 문제가 발생됨 그래서 테이블 생성시 bno는 fk로잡지않고 그냥 선언함.

create table FREEREPLY(
    rno int(10) primary key auto_increment,
    bno int(10),
    reply varchar(1000),
    replyid varchar(200),
    replypw varchar(200),
    replydate datetime default current_timestamp, 
    updatedate datetime default current_timestamp
);

##댓글 시퀀스
##create sequence freereply_seq increment by 1 start with 1 nocache;

##=================================================================================================================

##유저 테이블
create table USERS(
    userId varchar(50) primary key,
    userPw varchar(50) not null,
    userName varchar(50) not null,
    userEmail1 varchar(50),
    userEmail2 varchar(50),
    addrZipNum varchar(50),
    addrBasic varchar(300),
    addrDetail varchar(300),
    regdate datetime default current_timestamp
);

##=================================================================================================================

##파일 업로드 게시글

create table SNSBOARD(
    bno int(10) primary key auto_increment,
    writer varchar(50) not null,
    content varchar(2000),
    uploadpath varchar(100) not null, 
    fileloca varchar(100) not null,
    filename varchar(100) not null, 
    filerealname varchar(100) not null,
    regdate datetime default current_timestamp    
);

##create sequence snsboard_seq start with 1 increment by 1 nocache;

