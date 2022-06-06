--반복문(WHILE, FOR IN),탈출문(EXIT, CONTINUE)
SET SERVEROUTPUT ON;

DECLARE
    I NUMBER := 1;
    
BEGIN
    
    WHILE I <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    
       I:=I+1;  --제어변수 증감식(자바처럼 I+=1같은 표현형식이 불가능)
    END LOOP;
    
END;

--구구단 3단
DECLARE
    DAN NUMBER := 3;
    I NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('구구단 '||DAN|| '단');
    
    WHILE I <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN||'*'||I||'='||DAN*I);
        I := I+1;
    END LOOP;
END;

--탈출문 EXIT WHEN 조건
--1부터 10까지 10바퀴 회전중에 5가되면 탈출
DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I <= 10           
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        
        EXIT WHEN I = 5; --탈출
        
        I := I+1;
    END LOOP;
END;

--CONTINUE문 (CONTINUE WHEN 조건)
--1~10까지 수 중에서 짝수만 출력

DECLARE
    I NUMBER := 0;
BEGIN
    WHILE I <10
    LOOP
    I := I+1;
    
    CONTINUE WHEN MOD(I,2) = 1 ; --자바에서 I%2 == 1 이다와 같은의미
    
    DBMS_OUTPUT.PUT_LINE(I);
      
    END LOOP;

END;

--FOR문 FOR I IN범위

DECLARE     
BEGIN
    FOR I IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(3||'*'||I||'='||3*I);
        --이안에서 DML문의 사용도 가능하다.
    END LOOP;
END;


--연습문제1
--2단부터 9단까지 모든 구구단 출력
DECLARE
    DAN NUMBER := 2;
    I NUMBER:=1;
BEGIN
    WHILE DAN<=9
    LOOP
        DBMS_OUTPUT.PUT_LINE('구구단 '||DAN||'단');
        
        WHILE I<=9
        LOOP
        DBMS_OUTPUT.PUT_LINE(DAN||'*'||I||'='||DAN*I);
        
        I := I+1;
        END LOOP;
        I :=1;
        DAN := DAN+1;    
    END LOOP;
END;

--for
DECLARE

BEGIN
    FOR I IN 2..9
    LOOP 
        DBMS_OUTPUT.PUT_LINE('구구단'||I||' 단');
    
        FOR J IN 1..9        
        LOOP
            DBMS_OUTPUT.PUT_LINE(i || '*'|| J || '='||i*J);
        END LOOP;
    END LOOP;
    
END;


--연습문제2
--아래 테이블에 시퀀스를 이용해서 300행의 더미데이터를 입력해주세요.
CREATE TABLE TEST1(
    BNO NUMBER(10) PRIMARY KEY,
    WRITER VARCHAR2(30),
    TITLE VARCHAR2(30)
);

CREATE SEQUENCE TEST1_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 300
    NOCACHE
    NOCYCLE
;
--WHILE문
DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I<=300
    LOOP
        INSERT INTO TEST1 VALUES(TEST1_SEQ.NEXTVAL,'김XX','TEST'||TEST1_SEQ.CURRVAL);
    
        I := I+1;
    END LOOP;
END;

SELECT * FROM TEST1;

DROP TABLE TEST1;
DROP SEQUENCE TEST1_SEQ;
--FOR문
DECLARE

BEGIN
    FOR I IN 1..300
    LOOP
        INSERT INTO TEST2 VALUES(TEST2_SEQ.NEXTVAL , '박xx', TEST2_SEQ.CURRVAL);
    END LOOP;
END;

SELECT * FROM TEST2;



