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

---------------------------------------------
-- ���̺� ����(ALTER) ���ǻ���
-- 1) �÷��� ���� �� : 
--    ��� ���濡 �����ο�
--    ������ Ÿ�Ժ���, ������ ũ�⺯�� ��� �����ο�

-- 2) �÷��� �����Ͱ� ���� ��
--  : �����Ͱ� �ҽǵǸ� �ȵǹǷ� ���濡 ������ ����
--    Ÿ�� ������ ���� Ÿ�Գ������� ����
--    ���� Ÿ�԰��� CHAR -> VARCHAR2 ���� ����
--    ũ�� ������ ���� Ȥ�� Ŀ���� �������θ� ����
--    ���� Ÿ���� ũ�⺯���� ���е��� Ŀ���� �������θ� ����

-- ��) MARCH_MEMBER ���̺��� BIRTH_MONTH �÷���
--     ������ Ÿ���� ũ�⸦ NUMBER(1) �� ���̸�
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(1));
/*
ORA-01440: ���� �Ǵ� �ڸ����� ����� ���� ��� �־�� �մϴ�
01440. 00000 -  "column to be modified must be empty to decrease precision or scale"
*/
--         ���� �������� ���е��� �����ϴ� ������ �����ϸ�
--         2 -> 10�ڸ�, �� �� �Ҽ��� 2�ڸ�
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(10, 2));

-- ���� �������� BIRTH_MONTH �÷��� ���� �����ͷ� ����
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH VARCHAR2(1));
/*
ORA-01439: ������ ������ ������ ���� ��� �־�� �մϴ�
01439. 00000 -  "column to be modified must be empty to change datatype"
*/

-- MARCH_MEMBER ���̺��� ��� �࿡ ���ؼ�
-- BIRTH_MONTH �÷��� ���� NULL �����ͷ� �����ϴ� ���
UPDATE "SCOTT"."MARCH_MEMBER"
   SET BIRTH_MONTH = ''
;
COMMIT;
/*
6�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

Ŀ�ԿϷ�
*/
-- �����Ͱ� ���� �÷����� ���� ��
-- VARCHAR(2) �����÷����� ����
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH VARCHAR(2) );
-- Table MARCH_MEMBER��(��) ����Ǿ����ϴ�.

-- NUMBER(1) ����1�ڸ� �÷����� ����
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(1) );
-- Table MARCH_MEMBER��(��) ����Ǿ����ϴ�.

-- 3) �⺻ ��(DEFAULT) ������ ���� ���� ������ �����.

-- ��) 3�� ���� ����� ����� MARCH_MEMBER ���̺��� �����غ���.
--   : BIRTH_MEONT �÷��� ���� �׻� 3 ���� �����Ǿ �� �� ����.

-- a)
-- MARCH_MEMBER ���̺�
-- BIRTH_MONTH �÷��� ���� ���� ��� ���� 1�� �߰�
INSERT INTO "SCOTT"."MARCH_MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, GENDER) 
VALUES ('M006', '�Կ���', '0437', '������', '�İ�', 'F');
COMMIT;

-- b) a�� ��� ���� �߰� �� DEFAULT ���� �߰�
ALTER TABLE march_member MODIFY (BIRTH_MONTH DEFAULT 3);
-- tabel MARCH_MEMBER�� (��) ����Ǿ����ϴ�.

-- c) MARCH_MEMBER ���̺� DEFAULT ���� �߰� ��
--    �� ����� �߰�
INSERT INTO "SCOTT"."MARCH_MEMBER" (MEMBER_ID, MEMBER_NAME, ADDRESS, MAJOR, GENDER) 
VALUES ('M007', 'ȫ�浿', '������', '����', 'M');
COMMIT;

--------------------------------------------------------
-- ���̺� ���Ἲ ���� ���� ó����� 4����

/*
  MAIN_TABLE
  -------------------------------------------
  ID        VARCHAR2(10)    PRIMARY KEY
  NICKNAME  VARCHAR2(30)    UNIQUE
  REG_DATE  DATE            DEFAULT SYSDATE
  GENDER    VARCHAR(1)      CHECK (GENDER IN ('M', 'F'))
  MESSAGE   VARCHAR(300)
  --------------------------------------------
  
  SUB_TABLE
  ------------------------------------------------------
  ID         VARCHAR2(10)    REFERENCES MAIN_TABLE(ID)
                            (FK  FROM MAIN_TABLE.ID )
  HOBBY      VARCHAR2(200)
  BIRTH_YEAR NUMBER(4)
  -----------------------------------------------------
*/

---- 1. �÷� �����Ҷ�, ���� ���� �̸� ���� �ٷ� ����
;
DROP TABLE main_table1;
CREATE TABLE main_table1
(  ID        VARCHAR2(10)    PRIMARY KEY
  ,NICKNAME  VARCHAR2(30)    UNIQUE
  ,REG_DATE  DATE            DEFAULT SYSDATE
  ,GENDER    VARCHAR(1)      CHECK (GENDER IN ('M', 'F'))
  ,MESSAGE   VARCHAR(300)
);
-- Table MAIN_TABLE1��(��) �����Ǿ����ϴ�.

DROP TABLE SUB_TABLE1;
CREATE TABLE SUB_TABLE1
(  ID         VARCHAR2(10)    REFERENCES MAIN_TABLE1(ID)
 , HOBBY      VARCHAR2(200)
 , BIRTH_YEAR NUMBER(4) 
);

-- Table SUB_TABLE1��(��) �����Ǿ����ϴ�.

---- 2. �÷� ������ ��, ���� ���� �̸��� �ָ� ����
DROP TABLE main_table2;
CREATE TABLE main_table2
(  ID        VARCHAR2(10)    CONSTRAINT PK_MAIN PRIMARY KEY
  ,NICKNAME  VARCHAR2(30)    CONSTRAINT UK_NICKNAME UNIQUE
  ,REG_DATE  DATE            DEFAULT SYSDATE
  ,GENDER    VARCHAR(1)      CONSTRAINT CK_GENDER   CHECK (GENDER IN ('M', 'F'))
  ,MESSAGE   VARCHAR(300)
);
-- Table MAIN_TABLE2��(��) �����Ǿ����ϴ�.

DROP TABLE SUB_TABLE2;
CREATE TABLE SUB_TABLE2
(  ID         VARCHAR2(10)    CONSTRAINT FK_SUB REFERENCES MAIN_TABLE2(ID)
 , HOBBY      VARCHAR2(200)
 , BIRTH_YEAR NUMBER(4) 
);
-- Table SUB_TABLE2��(��) �����Ǿ����ϴ�.

-- MAIN_TABLE1, MAIN_TABLE2 �� ���������� ��

---- 3. �÷� ���� �� ���� ���� ���� ����
DROP TABLE main_table3;
CREATE TABLE main_table3
(   ID        VARCHAR2(10)    
  , NICKNAME  VARCHAR2(30)    
  , REG_DATE  DATE            DEFAULT SYSDATE
  , GENDER    VARCHAR(1)  
  , MESSAGE   VARCHAR(300)
  , CONSTRAINT PK_MAIN3      PRIMARY KEY (ID)
  , CONSTRAINT UK_NICKNAME3  UNIQUE(NICKNAME)
  , CONSTRAINT CK_GENDER3    CHECK (GENDER IN ('M', 'F'))
);
-- Table MAIN_TABLE3��(��) �����Ǿ����ϴ�.

DROP TABLE SUB_TABLE3;
CREATE TABLE SUB_TABLE3
(  ID         VARCHAR2(10)    
 , HOBBY      VARCHAR2(200)
 , BIRTH_YEAR NUMBER(4) 
 , CONSTRAINT FK_SUB3 FOREIGN KEY(ID) REFERENCES MAIN_TABLE3(ID)
 -- SUB_TABLE3 �� ��� PRIMARY KEY �� ID, BIRTH_YEAR �� ����Ű�� ����
 -- ����Ű�� PK�� �������� ���� �ݵ�� �������� �߰��θ� ��������
 , CONSTRAINT PK_SUB3 PRIMARY KEY (ID, BIRTH_YEAR)
);

-- Table SUB_TABLE3��(��) �����Ǿ����ϴ�.

-- �߰� ����
-- �ǽ� 10)

/* �� ���� ���̺��� �����ϴ� ������ �ۼ�
   3�� ������� �ۼ�
   (3�پ�)
------------------------------------------------   
 GAME
 GAME_CODE NUMBER(2)     PK      --���� �ڵ� 10, 20, 30
 GAME_NAME VARCHAR2(200) NOT NULL--���� �̸�

---------------------------------------------
 GMEMBER
 ID     VARCHAR2(4)     PK       --ȸ���� ���̵� M001, M002, ......
 NAME   VARCHAR2(15)    NOT NULL --ȸ���� �̸�

-----------------------------------------------
 MEMBER_GAME_HISTORY
 ID         VARCHAR2(4)     FK ����, FK �̸� : FK_ID
                            GMEMBER ���̺��� ID �÷��� �����ϵ��� ����
 YEAR       NUMBER(4)       -- ������ �� �⵵
 GAME_CODE  NUMBER(2)       FK ����, FK �̸� : FK_GAME_CODE
                            GAME ���̺��� GAME_CODE �÷��� �����ϵ��� ����
*/                            
-- 4. ���̺� ���� �� ���̺� ����(ALTER TABLE) �� �������� �߰�
-- MAIN_TABLE4 �� �̹� �����ϸ� ����
DROP TABLE MAIN_TABLE4;

-- 1) MAIN_TABLE ���� ����
CREATE TABLE MAIN_TABLE4
(   ID        VARCHAR2(10)    
  , NICKNAME  VARCHAR2(30)    
  , REG_DATE  DATE            DEFAULT SYSDATE
  , GENDER    VARCHAR(1)  
  , MESSAGE   VARCHAR(300)
);
-- 2) �������� �߰� ���� 
ALTER TABLE MAIN_TABLE4 ADD
(   CONSTRAINT PK_MAIN4      PRIMARY KEY(ID)
  , CONSTRAINT UK_NICKNAME4  UNIQUE(NICKNAME)
  , CONSTRAINT CK_GENDER4    CHECK (GENDER IN ('M', 'F'))
);
-- Table MAIN_TABLE4��(��) ����Ǿ����ϴ�.

-- SUB_TABLE4 �� �����ϸ� ����
DROP TABLE SUB_TABLE4

-- 3) SUB_TABLE4 ���� ����
CREATE TABLE SUB_TABLE4
(  ID         VARCHAR2(10)    
 , HOBBY      VARCHAR2(200)
 , BIRTH_YEAR NUMBER(4) 
);
-- Table SUB_TABLE4��(��) �����Ǿ����ϴ�.

-- 4) SUB_TABLE4 �� �������� �߰�
ALTER TABLE SUB_TABLE4 ADD
(  CONSTRAINT FK_SUB4 FOREIGN KEY(ID) REFERENCES MAIN_TABLE4(ID)
 , CONSTRAINT PK_SUB4 PRIMARY KEY(ID, BIRTH_YEAR)
);
-- Table SUB_TABLE4��(��) ����Ǿ����ϴ�.

-- �ý��� īŻ�α� : user_constraints ����
-- ������ �������� Ȯ��
SELECT c.table_name
     , c.constraint_name 
     , c.constraint_type
  FROM user_constraints c
 WHERE c.table_name LIKE 'MAIN_TABLE%'
    OR c.table_name LIKE 'SUB_TABLE%'
 ORDER BY c.table_name
;
/*
TABLE_NAEM, CONSTRAINT_NAME, CONSTRAINT_TYPE
--------------------------------------------
MAIN_TABLE1	SYS_C007536	        U(UNIQUE)
MAIN_TABLE1	SYS_C007535 	    P(PK)
MAIN_TABLE1	SYS_C007534 	    C(CHECK)
MAIN_TABLE2	PK_MAIN	            P
MAIN_TABLE2	UK_NICKNAME	        U
MAIN_TABLE2	CK_GENDER	        C
MAIN_TABLE3	PK_MAIN3	        P
MAIN_TABLE3	UK_NICKNAME3	    U
MAIN_TABLE3	CK_GENDER3	        C
MAIN_TABLE4	UK_NICKNAME4	    U
MAIN_TABLE4	CK_GENDER4	        C
MAIN_TABLE4	PK_MAIN4	        P
SUB_TABLE1	SYS_C007537	        R(REFERENCS = FK)
SUB_TABLE2	FK_SUB	            R
SUB_TABLE3	PK_SUB3	            P
SUB_TABLE3	FK_SUB3	            R
SUB_TABLE4	FK_SUB4	            R
SUB_TABLE4	PK_SUB4	            P      
*/

-- ���̺� �̸��� ���� :RENAME
-- ��) MARACH_MEMBER ====> MEMBER_OF_MARCH
RENAME MARCH_MEMBER TO MEMBER_OF_MARCH;
-- ���̺� �̸��� ����Ǿ����ϴ�.
-- ���ӿ� ���� ���̺� �̸� ���� Ȯ��

RENAME MEMBER_OF_MARCH TO MARCH_MEMBER;
-- ���̺� �̸��� ����Ǿ����ϴ�.

-- ���̺� ���� : DROP
-- �� ���̺� ���̿� REFERECES (FOREIGN KEY) ���ʰ� ���� ���� ����

-- MAIN_TABLE1 �� ��� SUB_TABLE1 �� ���� ID �÷��� â���ǰ� �ִ� ����

-- 1) MAIN_TABLE1 ���� ����
DROP TABLE MAIN_TABLE1;
/*
ORA-02449: �ܷ� Ű�� ���� �����Ǵ� ����/�⺻ Ű�� ���̺� �ֽ��ϴ�
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*/
-- SUB_TABLE1 �� MAIN_TABLE1 �� ID �÷��� �����ϰ� �ֱ� ������
-- ���̺� ������ ������ �ʿ��ϴ�.

-- 2) SUB_TABLE1 ���� ���� �� MAIN_TABLE1 ����
DROP TABLE SUB_TABLE1;
-- Table SUB_TABLE1��(��) �����Ǿ����ϴ�.
DROP TABLE MAIN_TABLE1;
-- Table MAIN_TABLE1��(��) �����Ǿ����ϴ�.

-- 3) ���� ���迡 ������� ���踦 �����鼭 ����
/*
TABLE_NAEM, CONSTRAINT_NAME, CONSTRAINT_TYPE
--------------------------------------------
MAIN_TABLE2	CK_GENDER	C
MAIN_TABLE2	PK_MAIN	    P
MAIN_TABLE2	UK_NICKNAME	U
SUB_TABLE2	FK_SUB	    R
*/
DROP TABLE MAIN_TABLE2 CASCADE CONSTRAINT;
-- Table MAIN_TABLE2��(��) �����Ǿ����ϴ�.

SELECT c.table_name
     , c.constraint_name 
     , c.constraint_type
  FROM user_constraints c
 WHERE c.table_name LIKE 'MAIN_TABLE2%'
    OR c.table_name LIKE 'SUB_TABLE2%'
 ORDER BY c.table_name
;
-- CASCADE �ɼ����� ���̺� ����ȭ��
-- ���� ���� ��� : ����� ��� �� : 0 �� �ȴ�.
-- ��, ���������� �̸� ��� �����ϸ� ���̺��� DROP ��
-- Ư�� �� ������� SUB_TABLE2 �� �ִ� R ���������� ���� ��������� Ȯ��.

-- SUB_TABLE3 �� DROP �� ��, user_constraints ���� ���� ���� ������� Ȯ��.
DROP TABLE SUB_TABLE3;
-- Table SUB_TABLE3��(��) �����Ǿ����ϴ�.
SELECT c.table_name
     , c.constraint_name 
     , c.constraint_type
  FROM user_constraints c
 WHERE c.table_name = 'MAIN_TABLE3'
    OR c.table_name = 'SUB_TABLE3'
 ORDER BY c.table_name
;
/*
TABLE_NAEM, CONSTRAINT_NAME, CONSTRAINT_TYPE
--------------------------------------------
MAIN_TABLE3	CK_GENDER3	    C
MAIN_TABLE3	UK_NICKNAME3	U
MAIN_TABLE3	PK_MAIN3	    P
*/
-- SUB_TABLE3 �� DROP �ص� MAIN_TABLE3 �� �������ǿ���
-- ������ ��ġ�� ������ Ȯ��.