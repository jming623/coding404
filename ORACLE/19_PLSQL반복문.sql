--�ݺ���(WHILE, FOR IN),Ż�⹮(EXIT, CONTINUE)
SET SERVEROUTPUT ON;

DECLARE
    I NUMBER := 1;
    
BEGIN
    
    WHILE I <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    
       I:=I+1;  --����� ������(�ڹ�ó�� I+=1���� ǥ�������� �Ұ���)
    END LOOP;
    
END;

--������ 3��
DECLARE
    DAN NUMBER := 3;
    I NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('������ '||DAN|| '��');
    
    WHILE I <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN||'*'||I||'='||DAN*I);
        I := I+1;
    END LOOP;
END;

--Ż�⹮ EXIT WHEN ����
--1���� 10���� 10���� ȸ���߿� 5���Ǹ� Ż��
DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I <= 10           
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        
        EXIT WHEN I = 5; --Ż��
        
        I := I+1;
    END LOOP;
END;

--CONTINUE�� (CONTINUE WHEN ����)
--1~10���� �� �߿��� ¦���� ���

DECLARE
    I NUMBER := 0;
BEGIN
    WHILE I <10
    LOOP
    I := I+1;
    
    CONTINUE WHEN MOD(I,2) = 1 ; --�ڹٿ��� I%2 == 1 �̴ٿ� �����ǹ�
    
    DBMS_OUTPUT.PUT_LINE(I);
      
    END LOOP;

END;

--FOR�� FOR I IN����

DECLARE     
BEGIN
    FOR I IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(3||'*'||I||'='||3*I);
        --�̾ȿ��� DML���� ��뵵 �����ϴ�.
    END LOOP;
END;


--��������1
--2�ܺ��� 9�ܱ��� ��� ������ ���
DECLARE
    DAN NUMBER := 2;
    I NUMBER:=1;
BEGIN
    WHILE DAN<=9
    LOOP
        DBMS_OUTPUT.PUT_LINE('������ '||DAN||'��');
        
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
        DBMS_OUTPUT.PUT_LINE('������'||I||' ��');
    
        FOR J IN 1..9        
        LOOP
            DBMS_OUTPUT.PUT_LINE(i || '*'|| J || '='||i*J);
        END LOOP;
    END LOOP;
    
END;


--��������2
--�Ʒ� ���̺� �������� �̿��ؼ� 300���� ���̵����͸� �Է����ּ���.
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
--WHILE��
DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I<=300
    LOOP
        INSERT INTO TEST1 VALUES(TEST1_SEQ.NEXTVAL,'��XX','TEST'||TEST1_SEQ.CURRVAL);
    
        I := I+1;
    END LOOP;
END;

SELECT * FROM TEST1;

DROP TABLE TEST1;
DROP SEQUENCE TEST1_SEQ;
--FOR��
DECLARE

BEGIN
    FOR I IN 1..300
    LOOP
        INSERT INTO TEST2 VALUES(TEST2_SEQ.NEXTVAL , '��xx', TEST2_SEQ.CURRVAL);
    END LOOP;
END;

SELECT * FROM TEST2;



