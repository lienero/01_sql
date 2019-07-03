-- day14 view ���

---------------------------------------------------
-- VIEW : �������θ� �����ϴ� ���� ���̺�
-- 1. SYS ����
CONN sys as sysdba;


-- 2. SCOTT ������ VIEW ���� ���� ����
-- (1) ���� ��
-- (2) sys ������ �ٸ� �����
-- (3) SCOTT ���� ������ Ŭ��
-- (4) ����� ����
-- (5) �ý��� ���� ��
-- (6) CREATE VIEW ������ �ο��� üũ�ڽ� ���� -> ����
GRANT CREATE VIEW TO SCOTT;
-- Grant��(��) �����߽��ϴ�.

-- 3. SCOTT���� ����
CONN SCOTT/TIGER;

---------------------------------------------------

-- 1. emp, dept ���̺� ����
DROP TABLE new_emp;
CREATE TABLE new_emp
AS
SELECT e.*
  FROM emp e
 WHERE 1 = 1
;
DROP TABLE new_dept;
CREATE TABLE new_dept
AS
SELECT d.*
  FROM dept d
 WHERE 1 = 1
;
/*
Table NEW_EMP��(��) �����Ǿ����ϴ�.
Table NEW_DEPT��(��) �����Ǿ����ϴ�.
*/

-- 2. ���� ���̺��� PK ������ �����Ǿ� �����Ƿ� PK ������ ALTER�� �߰�
/*  new_dept : PK_NEW_DEPT,  deptno �÷��� PRIMARY KEY �� ����
    new_emp : PK_NEW_EMP,    empno �÷��� PRIMARY KEY �� ����
              FK_NEW_DEPTNO, deptno �÷��� FOREIGN KEY �� ����
                 new_dept ���̺��� deptno �÷��� REFERENCES �ϵ��� ����
              FK_MER,        mgr �÷��� FOREIGN KEY �� ����
                 new_emp ���̺��� empno �÷��� REFERENCES �ϵ��� ����
*/

-- 3. ���� ���̺��� �⺻ ���̺�� �ϴ� VIEW �� ����
--    : ������ �⺻ ���� + ����� �̸� + �μ��̸� + �μ���ġ ���� ��ȸ������ ��
CREATE OR REPLACE VIEW v_emp_dept
AS
SELECT e.empno
     , e.ename
     , e1.ename as mgr_name
     , d.deptno
     , d.dname
     , d.loc
  FROM new_emp e
     , new_dept d
     , new_emp e1
 WHERE e.deptno = d.deptno(+)
   AND e.mgr = e1.empno(+)
WITH READ ONLY
;
-- View V_EMP_DEPT��(��) �����Ǿ����ϴ�.

-- ������ �ɸ� ����� �Ϲ� ���̺� ��ȸ�Ͻ� �並 ���� ��ȸ����
SELECT v.*
  FROM v_emp_dept v
;
/*
EMPNO,  ENMAE,  DNAME,  DEPTNO, DNAME,       LOC
-----------------------------------------------------
7902	FORD	JONES	20	    RESEARCH	DALLAS
7499	ALLEN	BLAKE	30	    SALES	    CHICAGO
7521	WARD	BLAKE	30	    SALES	    CHICAGO
7654	MARTIN	BLAKE	30	    SALES	    CHICAGO
7844	TURNER	BLAKE	30	    SALES	    CHICAGO
7900	JAMES	BLAKE	30	    SALES	    CHICAGO
8888	J_JAMES	BLAKE			
7934	MILLER	CLARK	10	    ACCOUNTING	NEW YORK
7782	CLARK	KING	10	    ACCOUNTING	NEW YORK
7566	JONES	KING	20  	RESEARCH	DALLAS
7698	BLAKE	KING	30  	SALES	    CHICAGO
7369	SMITH	FORD	20  	RESEARCH	DALLAS
7777	JJ	    FORD			
7839	KING		    10	    ACCOUNTING	NEW YORK
*/

SELECT v.empno
     , v.ename
     , v.dname
     , v.loc
  FROM v_emp_dept v
;
/*
7902	FORD	RESEARCH	DALLAS
7499	ALLEN	SALES	    CHICAGO
7521	WARD	SALES	    CHICAGO
7654	MARTIN	SALES	    CHICAGO
7844	TURNER	SALES   	CHICAGO
7900	JAMES	SALES	    CHICAGO
8888	J_JAMES		
7934	MILLER	ACCOUNTING	NEW YORK
7782	CLARK	ACCOUNTING	NEW YORK
7566	JONES	RESEARCH	DALLAS
7698	BLAKE	SALES	    CHICAGO
7369	SMITH	RESEARCH	DALLAS
7777	JJ		
7839	KING	ACCOUNTING	NEW YORK
*/

-- 4. VIEW �� �����Ǹ� user_view ��� �ý��� ���̺� ������ �߰��� Ȯ��
DESC user_views;
/*
�̸�                     ��?       ����             
---------------------- -------- -------------- 
VIEW_NAME              NOT NULL VARCHAR2(128)  
TEXT_LENGTH                     NUMBER         
TEXT                            LONG           
TEXT_VC                         VARCHAR2(4000) 
TYPE_TEXT_LENGTH                NUMBER         
TYPE_TEXT                       VARCHAR2(4000) 
.......
*/

SELECT v.view_name
     , v.read_only
  FROM user_views v
;
/*
VIEW_NAME,  RADE_ONLY
----------------------
V_EMP_DEPT	Y
*/

-- 5. ������ �信�� DQL ��ȸ
--- 1) �μ����� SALES �� �μ� �Ҽ� ������ ��ȸ
SELECT v.*
  FROM v_emp_dept v
 WHERE v.dname = 'SALES'
;
/*
7499	ALLEN	BLAKE	30	SALES	CHICAGO
7521	WARD	BLAKE	30	SALES	CHICAGO
7654	MARTIN	BLAKE	30	SALES	CHICAGO
7844	TURNER	BLAKE	30	SALES	CHICAGO
7900	JAMES	BLAKE	30	SALES	CHICAGO
7698	BLAKE	KING	30	SALES	CHICAGO
*/

--- 2) �μ����� NULL �� ������ ��ȸ
SELECT v.*
  FROM v_emp_dept v
 WHERE v.dname IS NULL
;
/*
8888	J_JAMES	BLAKE			
7777	JJ	    FORD			
*/

--- 3) ���(�Ŵ���,mgr)�� NULL �� ������ ��ȸ
SELECT v.*
  FROM v_emp_dept v
 WHERE v.mgr_name IS NULL
;
/*
EMPNO,  ENAMEM  MGR_NAME,   DEPTNO, DNAME,      LOC
------------------------------------------------------------
7839	KING		        10	    ACCOUNTING	NEW YORK
*/