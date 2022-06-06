/*
Ʈ����(TRIGGER)
Ʈ���Ŵ� ���̺� �����ؼ� ����ϴ� ���·� INSERT, DELETE, UPDATE�۾��� ����ɶ�
Ư�� �ڵ尡 �����ϵ��� �ϴ� �����Դϴ�.

Ʈ���� ����
AFTER - DML�� ���Ŀ� �����ϴ� Ʈ����
BEFORE - DML�� ������ �����ϴ� Ʈ����
INSTEAD OF - �信 �����ϴ� Ʈ���� 

Ʈ���� ����
CREATE OR REPLACE TRIGGER Ʈ���Ÿ�
    Ʈ����Ÿ��
    ON ������ų ���̺�
    OPTION(FOR EACH ROW) --�ɼ��̱������� ���� ������ �����ٰ� �����ϸ� ��.
    BEGIN
    END;
*/

CREATE TABLE TBL_TEST(
    ID VARCHAR2(10),
    TEXT VARCHAR2(50)
);

CREATE OR REPLACE TRIGGER TBL_TEST_TRI
    AFTER DELETE OR UPDATE -- ���� OR ������Ʈ ���Ŀ� ����
    ON TBL_TEST -- ������ ���̺�
    FOR EACH ROW --����࿡ �����ϴ� OPTION
BEGIN
    DBMS_OUTPUT.PUT_LINE('Ʈ���Ű� ������');
END;

--Ʈ���� ���� Ȯ��

--INSERT���������� �������� ����
INSERT INTO TBL_TEST VALUES (1,'ȫ�浿');
INSERT INTO TBL_TEST VALUES (2,'�̼���');
--UPDATE������ DELETE���������� Ʈ���Ű� �����ϸ� ��¹��� ��µ�.
UPDATE TBL_TEST SET TEXT = 'ȫ����' WHERE ID = 1;
DELETE FROM TBL_TEST WHERE ID = 2;

/*
Ʈ���� �������� Ű����
:OLD - ������ COLUMN �� (INSERT:�Է��� �ڷ�, UPDATE:������ �ڷ� , DELETE:������ �ڷ�)
:NEW - ������ COLUMN �� (INSERT:�Է��� �ڷ�, UPDATE:������ �ڷ�)

UPDATE OR DELETE�� �õ��ϸ� �����ڷḦ ������̺� �����Ҷ� ���

AFTERƮ���Ŵ� ���� UPDATE,DELETE���(:OLD, :NEW)
BEFOREƮ���Ŵ� ���� INSERT��� (:NEW)
*/

CREATE TABLE TBL_USER(
    ID VARCHAR2(30) PRIMARY KEY,
    NAME VARCHAR2(30)
);

CREATE TABLE TBL_USER_BACKUP(
    ID VARCHAR2(30),
    NAME VARCHAR2(30),
    UPDATE_DATE DATE DEFAULT SYSDATE,--���泯¥
    MODIFY_TYPE CHAR(1), --����OR���� Ÿ��
    MODIFY_USER VARCHAR2(30) --������ ���
);
DROP TABLE TBL_USER_BACKUP;
--AFTERƮ����
CREATE OR REPLACE TRIGGER USER_BACKUP_TRI
    AFTER UPDATE OR DELETE
    ON TBL_USER
    FOR EACH ROW
DECLARE --���������� ������ �ʿ��ϴٸ� DECLARE������ �߰��ϰ� ���𰡴�
    V_TYPE VARCHAR2(10); --Ʈ���ſ��� ����� ����
BEGIN
    --INSERTING, UPDATING, DELETING Ʈ���ſ��� �����ϴ� ���ǰ˻� Ű����?
    IF UPDATING THEN --UPDATE������ �����
        V_TYPE := 'U';
    ELSIF DELETING THEN --DELETE������ �����
        V_TYPE := 'D';
    END IF;

    --BACKUP���̺� ������ ���
    INSERT INTO TBL_USER_BACKUP VALUES(:OLD.ID,:OLD.NAME,SYSDATE,V_TYPE,USER()); --USER()�� ����������� ��.
END;

--Ʈ���� Ȯ��
INSERT INTO TBL_USER VALUES('TEST1', 'ADMIN1');
INSERT INTO TBL_USER VALUES('TEST2', 'ADMIN2');
INSERT INTO TBL_USER VALUES('TEST3', 'ADMIN3');

UPDATE TBL_USER SET NAME = 'ȫ�浿' WHERE ID = 'TEST1';--Ʈ���� ����
DELETE FROM TBL_USER WHERE ID = 'TEST3';

SELECT * FROM TBL_USER;
SELECT * FROM TBL_USER_BACKUP;

---------------------------------------------------------------------
--BEFOREƮ����
--TBL_USER���̺� �̸��� ����� ��, **�� �ٿ��� ����

CREATE OR REPLACE TRIGGER USER_INSERT_TRI
    BEFORE  INSERT 
    ON TBL_USER
    FOR EACH ROW
DECLARE

BEGIN
-- INSERT���� :OLD�� ���� NULL
    :NEW.NAME := SUBSTR(:NEW.NAME,1,1)||'***'   ;
    DBMS_OUTPUT.PUT_LINE(:NEW.NAME);
END;

SELECT * FROM TBL_USER;
DELETE FROM TBL_USER WHERE ID ='KKK123';
--Ʈ���� ����
INSERT INTO TBL_USER VALUES ('KKK123','ȫ�浿');
INSERT INTO TBL_USER VALUES ('PPP123','�̼���');
INSERT INTO TBL_USER VALUES ('QQQ123','�Ż��Ӵ�');

--Ʈ���� ������
/*
�ֹ����̺� ����
�ֹ���� ���̺�: �ֹ���ȣ 50000��

*/
CREATE TABLE ORDER_DETAIL(
    DETAIL_NO NUMBER(5) PRIMARY KEY,
    O_NO NUMBER(5), --FK(�ֹ���ȣ)
    P_NO NUMBER(5), --FK(��ǰ��ȣ)
    DETAIL_TOTAL NUMBER(5), --�ֹ�����
    DETAIL_PRICE NUMBER(10) --�ݾ�
);

CREATE TABLE PRODUCT(
    P_NO NUMBER(5) PRIMARY KEY,
    P_NAME VARCHAR2(20),
    P_TOTAL NUMBER(5), --��������
    P_PRICE NUMBER(10) --����
);
SELECT * FROM PRODUCT;
SELECT * FROM ORDER_DETAIL;

INSERT INTO PRODUCT (P_NO,P_NAME,P_TOTAL,P_PRICE)VALUES(1,'����',100,10000);
INSERT INTO PRODUCT (P_NO,P_NAME,P_TOTAL,P_PRICE)VALUES(2,'ġŲ',100,15000);
INSERT INTO PRODUCT (P_NO,P_NAME,P_TOTAL,P_PRICE)VALUES(3,'�ܹ���',100,5000);

--�ֹ��� ������, ��ǰ���̺��� ���� ���� Ʈ����
CREATE OR REPLACE TRIGGER ORDER_DETAIL_TRI
    AFTER INSERT
    ON ORDER_DETAIL
    FOR EACH ROW
DECLARE
    V_NO NUMBER(5) := :NEW.P_NO;
    V_DETAIL_TOTAL NUMBER(5) := :NEW.DETAIL_TOTAL; --�ֹ��� ������ ����
BEGIN
    --��ǰ���̺� ����� UPDATE��
    UPDATE PRODUCT SET P_TOTAL = (P_TOTAL - V_DETAIL_TOTAL) WHERE P_NO = V_NO;

END;
--Ʈ���� ����Ȯ�� (EX:50000�� �ֹ��� ���Ͽ�..)
INSERT INTO ORDER_DETAIL VALUES(1,50000,1,5,(SELECT P_PRICE FROM PRODUCT WHERE P_NO = 1)*5 ); 
INSERT INTO ORDER_DETAIL VALUES(2,50000,2,2,(SELECT P_PRICE FROM PRODUCT WHERE P_NO = 2)*2 ); 
INSERT INTO ORDER_DETAIL VALUES(3,50000,3,10,(SELECT P_PRICE FROM PRODUCT WHERE P_NO = 3)*10 ); 

