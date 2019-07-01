-- day 12 : DDL (Data Definition Language)
--          ������ ���Ǿ�
-- 1. ���̺��� �����ϴ� ��ɾ� => ���̺��� DBMS�� OBJECT�� �ϳ�
-- 2. DBMS �� OBJECT(��ü) �� ����/�ν� �ϴ� �����
--    ����, ����, ���� �ϴ� ��ɾ�

-- ���� : CREATE
-- ���� : ALTER
-- ���� : DROP

-- vs. DML (Date Mainpulation Language) ������ ���۾�
-- ���� : INSERT
-- ���� : UPDATE
-- ���� : DELETE

---------------------------------------------------------------------
/* DDL ������ ����

   CREATE | ALTER | DROP {������ ��ü�� Ÿ�Ը�}
   
   DBMS�� OBJECT(��ü)�� ����
   SHEMA, DOMAIN, TABLE, VIEW, INDEX, SEQUENCE, USER, DATABASE  
/*

-- CREATE TABLE ���� ���� 
CREATE TABLE ���̺� �̸�
( �÷�1�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]
 [,�÷�2�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
 ......
 [,�÷�n�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
);

/* ------------------------------
    �÷��� ���� ����
    -----------------------------
    1. PRIMARY KEY : �� �÷��� �ԷµǴ� ���� �ߺ����� �ʰ�
                     �� ���� �ĺ��� �� �ִ� ������ �����ؾ� �ϸ�
                     NULL ������ �Է��� �Ұ����� ���̾�� �Ѵ�.
   
    2. FOREIGN KEY : �ַ� JOIN�� ���Ǵ� ������������
                     �ٸ� ���̺��� PRIMARY KEY �� ���Ǿ��� ����
                     �����ؾ߸� �Ѵ�.

    3. UNIQUE      : �� �÷��� �ԷµǴ� ���� �ߺ����� ������ �����ؾ� �Ѵ�.
                     NULL ������ �Է��� �����ϴ�.
                     ==> �����Ͱ� NULL(���ų�) �̰ų�
                         NULL�� �ƴϸ� �ݵ�� ������ ���̾�� ��.
   
    4. NOT NULL    : �� �÷��� �ԷµǴ� ���� �ߺ��� ���������
                     NULL ���´� ���� �ʵ��� �����Ѵ�.
                     
    ==> PK : UNIQUE + NOT NULL �� ���յ� ���¶�� ���� �� �� �ִ�.
*/

-- ��) û���� ���� �����ο� ������ ������ ���̺��� ����
/*
   ���̺��̸� : member
   1. ������̵�       : member_id    : ���� : VARCHAR2 : PK
   2. ��� �̸�        : member_name  : ���� : VARCHAR2 : NOT NULL
   3. ��ȭ��ȣ ���ڸ�  : phone        : ���� : VARCHAR2
   4. �ý��۵����     : reg_date     : ��¥ : DATE
   5. ��� ��(���̸�)  : address      : ���� : VARCHAR2
   6. �����ϴ� ����    : like_number  : ���� : NUMBER
   7. ����            : major        : ���� : VARCHAR2
*/


-- 1. ���̺� ���� ���� : member
CREATE TABLE member
(  member_id     VARCHAR2(4)  PRIMARY KEY
 , member_name   VARCHAR2(15) NOT NULL 
 , phone         VARCHAR2(4)  --NULL ����Ϸ��� ���������� �Ⱦ��� �ȴ�.
 , reg_date      DATE         DEFAULT sysdate
 , address       VARCHAR2(30) 
 , like_number   NUMBER
 , major         VARCHAR2(50)
);
-- Table MEMBER��(��) �����Ǿ����ϴ�.

-- 2. ���̺� ���� ����
DROP TABLE ���̺��̸�;

DROP TABLE member;
-- Table MEMBER��(��) �����Ǿ����ϴ�.

-- 3. ���̺� ���� ����
/* -------------------
   ������ ����
   --------------------------------
   1. �÷��� �߰� : ADD
   2. �÷��� ���� : MODIFY
   3. �÷��� ���� : DROP COLUMN
   ------------------------------
*/
ALTER TABLE ���̺��̸� {ADD | MODIFY | DROP COLUMN| .... ;

-- 1) ADD
-- ��) ������ member ���̺� �÷� 2���� �߰�

-- ��� �� : birth_month : NUMBER
-- ����    : gender      : VARCHAR2(1) : F,M �� ���� �� �ϳ��� �Է°����ϵ���
--  member ���̺� ���� �� �Ʒ� ���� ����
ALTER TABLE member ADD
(  birth_month NUMBER
 , gender      VARCHAR2(1) CHECK (gender IN ('F', 'M'))
);
-- Table MEMBER��(��) ����Ǿ����ϴ�.

-- 2) MODIFY
-- ��) ��� �� �÷��� ����2 �ڸ������� ���ѵǵ��� ����

ALTER TABLE ���̺��̸� MODIFY �÷��̸� ������Ÿ��(ũ��);
ALTER TABLE member MODIFY birth_month NUMBER(2);
-- Table MEMBER��(��) ����Ǿ����ϴ�.

-- 3) DROP COLUMN
-- ��) ������ ���̺� member���� like_number �÷��� ����
ALTER TABLE ���̺��̸� DROP COLUMN �÷��̸�;
ALTER TABLE member DROP COLUMN like_number;

-----------------------------------------------------------------------------
-- ���� ����� member ���̺��� ��������
CREATE TABLE member
(  member_id     VARCHAR2(4)  PRIMARY KEY
 , member_name   VARCHAR2(15) NOT NULL 
 , phone         VARCHAR2(4)  --NULL ����Ϸ��� ���������� �Ⱦ��� �ȴ�.
 , reg_date      DATE         DEFAULT sysdate
 , address       VARCHAR2(30) 
 , major         VARCHAR2(50)
 , birth_month   NUMBER
 , gender        VARCHAR2(1) CHECK (gender IN ('F', 'M'))
);

-- ���� �ܼ�ȭ�� ���̺� ���� ����
-- ���������� �� �÷� �ڿ� �ٷ� �������� �̸� ���� ����

-- �������ǿ� �̸��� �ο��ؼ� ����:
-- �÷��� ���ǰ� ���� �� �������� ���Ǹ� ���Ƽ� �ۼ�

-- ���̺� ����
DROP TABLE member;
DROP TABLE new_nembeer;
-- �������� �̸��� �־� number ���̺� ����
CREATE TABLE member
(  member_id     VARCHAR2(4) 
 , member_name   VARCHAR2(15) NOT NULL 
 , phone         VARCHAR2(4)  --NULL ����Ϸ��� ���������� �Ⱦ��� �ȴ�.
 , reg_date      DATE         DEFAULT sysdate
 , address       VARCHAR2(30) 
 , major         VARCHAR2(50)
 , birth_month   NUMBER
 , gender        VARCHAR2(1) 
-- , CONSTRAINT ���������̸� �������� Ÿ�� (�������� ������ �÷�)
 , CONSTRAINT pk_member         PRIMARY KEY (member_id)
 , CONSTRAINT ck_member_gender  CHECK       (gender IN ('M', 'F'))
);
-- Table MEMBER��(��) �����Ǿ����ϴ�.

-- ���̺� ������ DDL �� ������ ������ �ý��� īŻ�α׿� �����.
-- user_tables, user_constraints 
-- �� ���� �ý��� īŻ�α� ���̺��� ��ȸ

-- 1) �� ���̺��� ����(�÷� �̸�) ��ȸ
DESC user_tables;
/*
�̸�                        ��?       ����             
------------------------- -------- -------------- 
TABLE_NAME                NOT NULL VARCHAR2(128)  
*/
-- ���� ����(SCOTT)�� ������ �ִ� ���̺� ����� ��ȸ
SELECT t.table_name
  FROM user_tables t
;
/* 
TABLE_NAME
---------
DEPT
EMP
BONUS
SALGRADE
MEMBER
*/

DROP TABLE member;

DESC user_constraints;
/*
�̸�                  ��? ����             
------------------- -- -------------- 
OWNER                  VARCHAR2(128)  
CONSTRAINT_NAME        VARCHAR2(128)  
CONSTRAINT_TYPE        VARCHAR2(1)    
TABLE_NAME             VARCHAR2(128)  
*/
-- ���� ����(SCOTT)�� ������ �ִ� �������� ��ȸ
SELECT c.constraint_name
     , c.constraint_type
     , c.table_name
  FROM user_constraints c
;
/*
FK_DEPTNO	        R	EMP
PK_DEPT         	P	DEPT
PK_EMP          	P	EMP
CK_MEMBER_GENDER	C	MEMBER
PK_MEMBER	        P	MEMBER
SYS_C007516	        C	MEMBER
*/
-- MEMBER ���̺��� �������Ǹ� Ȯ��
SELECT c.constraint_name
     , c.constraint_type
     , c.table_name
  FROM user_constraints c
 WHERE c.table_name = 'MEMBER'
;

-- user_objects : ���� ����ڰ� ������ �ִ� object���� ������ ����Ǵ�
--                �ý��� īŻ�α� ���̺�
DESC user_objects;
/*
�̸�                ��? ����            
----------------- -- ------------- 
OBJECT_NAME          VARCHAR2(128) 
SUBOBJECT_NAME       VARCHAR2(128) 
OBJECT_ID            NUMBER        
DATA_OBJECT_ID       NUMBER        
OBJECT_TYPE          VARCHAR2(23)  
CREATED              DATE   
*/
SELECT o.object_name
     , o.object_id
     , o.object_type
  FROM user_objects o
;
/*
DEPT	    73559	TABLE
PK_DEPT	    73560	INDEX
PK_EMP	    73578	INDEX
EMP	        73577	TABLE
BONUS	    73579	TABLE
SALGRADE	73580	TABLE
PK_MEMBER	74533	INDEX
MEMBER	    74532	TABLE
*/

-- ���̺� ���� ����� �̹� �����ϴ� ���̺�κ��� ���� ����
-- ���̺� ���� ���� ���� ����
CREATE TABLE ���̺��̸�
AS
SELECT �÷��̸�....
  FROM ���������̺�
 WHERE �׻� ������ �Ǵ� ����
;

-- ��) �ռ� ������ member ���̺��� ���� : new_member
CREATE TABLE new_member
AS
SELECT m.*
  FROM member m
 WHERE 1 = 2 -- �׻� ������ �Ǵ� ����
;
-- PK ������ ������� �ʰ� ���̺� ����(��ȸ�� �÷���) �����

-- Table NEW_NEMBEER��(��) �����Ǿ����ϴ�.
-- new_member ���̺��� ������ ��ȸ
DESC new_member;
/*
�̸�          ��?       ����           
----------- -------- ------------ 
MEMBER_ID            VARCHAR2(4)  
MEMBER_NAME NOT NULL VARCHAR2(15) 
PHONE                VARCHAR2(4)  
REG_DATE             DATE         
ADDRESS              VARCHAR2(30) 
LIKE_NUMBER          NUMBER       
MAJOR                VARCHAR2(50) 
BIRTH_MONTH          NUMBER       
GENDER               VARCHAR2(1)  
*/
/*
-- member ���̺� ������ �߰�
*/
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M001', '������', '9155', '������', '����', '3', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M002', '������', '1418', '������', '�Ͼ�', '1', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M003', '�̺���', '0186', 'õ�Ƚ�', '�İ�', '3', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M004', '�蹮��', '1392', '���ֽ�', '�Ͼ�', '3', 'F')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M005', '����ȯ', '0322', '�Ⱦ��', '����', '3', 'M')
COMMIT;

-- 3������ ������ �����ؼ� �� ���̺��� ����
CREATE TABLE march_member
AS
SELECT m.*
  FROM member m
 WHERE m.birth_month = 3
;
-- Table MARCH_MEMBER��(��) �����Ǿ����ϴ�.

-- �����Ͽ� ���̺� ������ ���� �� �� �ִ� ������ �ָ�
-- �ش� ������ �����ϴ� ���� �����ͱ��� ����Ǹ鼭 ���̺� ����

-- �׻� ���� �Ǵ� ������ �ָ� ��� �����͸� �����ϸ鼭 ���̺� ����
CREATE TABLE full_member
AS
SELECT m.*
  FROM member m
 WHERE 1 = 1
;
-- Table FULL_MEMBER��(��) �����Ǿ����ϴ�.
-- full_member ����
DROP TABLE full_member;
CREATE TABLE full_member
AS
SELECT m.*
  FROM member m
;
  -- WHERE �������� �����ϸ�
  -- �׻� ���� ����� �����ϹǷ� ��� �����Ͱ� ����Ǹ� �� ���̺� ����









