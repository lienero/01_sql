-- day09 :

-- 2. ������ �Լ�(�׷� �Լ�)

-- 1) COUNT(*) : FROM ���� ������
--               Ư�� ���̺��� ���� ����(������ ����)�� �����ִ� �Լ�
--               NULL ���� ó���ϴ� "����"�� �׷��Լ�

--    COUNT(expr) : expr ���� ������ ����  NULL �����ϰ� �����ִ� �Լ�

-- ����) dept, slagrade ���̺��� ��ü ������ ���� ��ȸ
-- 1. dept ���̺� ��ȸ
SELECT d.*
  FROM dept d
;
/* ������ �Լ��� ���� ����:
DEPTNO, DNAME,      LOC
----------------------------
10	    ACCOUNTING	NEW YORK ====> SUBSTR(dname, 1,5) ====> ACCOU
20	    RESEARCH	DALLAS   ====> SUBSTR(dname, 1,5) ====> RESEA
30	    SALES	    CHICAGO  ====> SUBSTR(dname, 1,5) ====> SALES
40	    OPERATIONS	BOSTON   ====> SUBSTR(dname, 1,5) ====> OPERA
*/

/* �׷��Լ�(COUNT(*))�� ���� ����:
DEPTNO, DNAME,      LOC
----------------------------
10	    ACCOUNTING	NEW YORK ====>
20	    RESEARCH	DALLAS   ====> COUNT(*) ====> 4
30	    SALES	    CHICAGO  ====>
40	    OPERATIONS	BOSTON   ====>
*/
-- 2. dept ���̺��� ������ ���� ��ȸ : COUNT(*) ���
SELECT COUNT(*) AS "�μ� ����"
  FROM dept d
;
/*
�μ� ����
---------
        4
*/

-- salgrade(�޿����) ���̺��� �޿� ��� ������ ��ȸ
SELECT COUNT(*) AS "�޿� ��� ����"
  FROM salgrade
;
/*
�޿� ��� ����
-------------
            5
*/

SELECT s.*
  FROM salgrade s
;
/*
1	700	    1200 ====>
2	1201	1400 ====> COUNT(*)
3	1401	2000 ====>
4	2001	3000 ====>
5	3001	9999 ====>
*/

-- COUNT(expr) �� NULL �����͸� ó������ ���ϴ� �� Ȯ���� ���� ������ �߰�
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ');
COMMIT;

--emp ���̺��� job �÷��� ������ ������ ī����
SELECT COUNT(e.job) "������ ������ ������ ��"
  FROM emp e
;
/*
������ ������ ������ ��
----------------------
                    14 
*/

/*
7777	JJ	    (null)   ====>
8888	J%JAMES	CLERK    ====>
9999	J_JAMES	CLERK    ====>
7369	SMITH	CLERK    ====>
7499	ALLEN	SALESMAN ====>   
7521	WARD	SALESMAN ====>
7566	JONES	MANAGER  ====>
7654	MARTIN	SALESMAN ====> ������ ���� ���� �÷��� job��
7698	BLAKE	MANAGER  ====> null �� �� ���� ó���� ���� �ʴ´�.
7782	CLARK	MANAGER  ====> 
7839	KING	PRESIDENT====> COUNT(e.job) ====> 14
7844	TURNER	SALESMAN ====>
7900	JAMES	CLERK    ====>
7902	FORD	ANALYST  ====>
7934	MILLER	CLERK    ====>
*/

-- ����) ȸ�翡 �Ŵ����� ������ ������ ����ΰ�
--       ��Ī : ��簡 �ִ� ������ ��
SELECT COUNT(e.mgr) AS "��簡 �ִ� ������ ��"
  FROM emp e
;
/*
��簡 �ִ� ������ ��
---------------------
                  11
*/

-- ����) �Ŵ��� ���� �ð� �ִ� ����� ����ΰ�?
-- 1. emp ���̺��� mgr �÷��� ������ ���¸� �ľ�
-- 2. mgr �÷��� �ߺ� �����͸� ����
SELECT DISTINCT e.mgr 
  FROM emp e
;
/*
MGR
-----
7782
7698
7902
7566
(null)
7839
*/

-- 3. �ߺ� �����Ͱ� ���ŵ� ����� ī��Ʈ
SELECT COUNT(DISTINCT e.mgr) "�Ŵ��� ��"
  FROM emp e
;
/*
�Ŵ��� ��
--------
       5
*/

-- ����) �μ��� ������ ������ ����̳� �ִ°�?
SELECT COUNT(e.deptno) "�μ� ���� �ο�"
  FROM emp e
;
/*
�μ� ���� �ο�
-------------
           12
*/

-- COUNT(*) �� �ƴ� COUNT(expr)�� ����� ��쿡��
SELECT e.deptno
  FROM emp e
 WHERE e.deptno IS NOT NULL
;
-- �� ������ ����� ī��Ʈ �� ������ ������ �� ����.

-- ����) ��ü�ο�, �μ� ���� �ο�, �μ� �̹��� �ο��� ���Ͻÿ�.
SELECT COUNT(*)        "��ü�ο�" 
     , COUNT(e.deptno) "�μ� ���� �ο�"
     , COUNT(*) - COUNT(e.deptno) "�μ� �̹��� �ο�"
  FROM emp e
;

-- SUM(expr) : NULL �׸� �����ϰ�
--             �ջ� ������ ���� ��� ���� ����� ���

-- SALESMAN ���� ���� ������ ���غ���

SELECT SUM(e.comm) "���� ����"
  FROM emp e
;

/*
COMM
-------
(null) 
(null) 
(null) 
(null) 
300    ====>
500    ====>
(null)
1400   ====> SUM(e.comm) ====> 2200 : �ڵ����� NULL �÷� ����
(null)       
(null)
(null)
0
(null)
*/

SELECT SUM(e.comm) "���� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

/*
COMM
-------
  300    ====>
  500    ====>

  1400   ====> SUM(e.comm) ====> 2200 : �ڵ����� NULL �÷� ����
     0   ====>
*/

-- ���� ���� ����� ���� ��� ������ ���� $, ���ڸ� ���� �б� ����
SELECT TO_CHAR(SUM(e.comm), '$9,999') "���� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

/*
���� ����
--------
 $2,200
*/   

-- 3) AVG(expr) : NULL �� �����ϰ� ���� ������ �׸��� ��� ����� ����

-- SALESMEN �� ���� ����� ���غ���.

SELECT AVG(e.comm) "���� ���"
  FROM emp e
 WHERE e.job = 'SALESMAN'  
;

-- ���� ��� ����� ���� ��� ���� $,���ڸ� ���� �б� ����
SELECT TO_CHAR(AVG(e.comm), '$9,999') "���� ���"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

-- 4) MAX(expr) : expr�� ������ �� �� �ִ��� ����
--                expr�� ������ ���� ���ĺ��� ���ʿ� ��ġ�� ���ڸ�
--                �ִ����� ���

-- �̸��� ���� ������ ����
SELECT MAX(e.ename) "�̸��� ���� ������ ����"
  FROM emp e
;
/*
�̸��� ���� ������ ����
----------------------
WARD
*/

-- 5) MIN(expr) : expr�� ������ �� �� �ּ��� ����
--                expr�� ������ ���� ���ĺ��� ���ʿ� ��ġ�� ���ڸ�
--                �ּҰ����� ���

SELECT MIN(e.ename) "�̸��� ���� ���� ����"
  FROM emp e
;
/*
�̸��� ���� ���� ����
--------------------
ALLEN
*/

---- 3. GROUP_BY ���� ���
-- ����) �� �μ����� �޿��� ����, ���, �ִ�, �ּҸ� ��ȸ

--  �� �μ����� �޿��� ������ ��ȸ�Ϸ���
--    ���� : SUM() �� ���
--    �׷�ȭ ������ �μ���ȣ(deptno)�� ���
--    GROUP BY ���� �����ؾ� ��

-- a) ���� emp ���̺��� �޿� ������ ���ϴ� ���� �ۼ�
SELECT SUM(e.sal) "�޿� ����"
  FROM emp e
;

-- b) �μ� ��ȣ�� �������� �׷�ȭ ����
--    SUM()�� �׷��Լ���.
--    GROUP BY ���� �����ϸ� �׷�ȭ �����ϴ�.
--    �׷�ȭ�� �Ϸ��� �����÷��� GROUP BY ���� �����ؾ� ��.

SELECT e.deptno �μ���ȣ -- �׷�ȭ �����÷��� SELECT ���� ����
     , SUM(e.sal) "�μ� �޿� ����" -- �׷��Լ��� ���� �÷�
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ���� 
;

-- GROUP BY ���� �׷�ȭ ���� �÷����� ������ �÷��� �ƴ�
-- SELECT ���� �����ϸ� ����, ����Ұ�
SELECT e.deptno �μ���ȣ -- �׷�ȭ �����÷��� SELECT ���� ����
     , e.job -- �׷�ȭ �����÷��� �ƴѵ� SELECT ���� ���� -> ������ ����
     , SUM(e.sal) "�μ� �޿� ����" -- �׷��Լ��� ���� �÷�
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ���� 
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*/

-- ����) �μ��� �޿��� ����, ���, �ִ�, �ּ�
SELECT e.deptno �μ���ȣ 
     , SUM(e.sal) "�μ� �޿� ����" 
     , AVG(e.sal) "�μ� �޿� ���"
     , MAX(e.sal) "�μ� �޿� �ִ�"
     , MIN(e.sal) "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

--���� ���� ����
SELECT e.deptno �μ���ȣ 
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
�μ���ȣ, �μ� �޿� ����, �μ� �޿� ���, �μ� �޿� �ִ�, �μ� �޿� �ּ�
------------------------------------------------------------------
10	            $8,750	 $2,916.67	    $5,000	        $1,300
20	            $6,775	 $2,258.33	    $3,000	        $800
30	            $9,400	 $1,566.67	    $2,850	        $950
*/

-- �μ���ȣ�� ������ ����
SELECT TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

/*
���� ������ ��������� ��Ȯ�ϰ� ��� �μ��� ������� �� �� ���ٴ� ������ ����

�׷���, GROUP BY ���� �����ϴ� ���� �÷��� SELECT ���� �Ȱ��� �����ϴ� ����
��� �ؼ��� ���ϴ�.

SELECT ���� ������ �÷��߿��� �׷��Լ��� ������ �ʴ� �÷��� ���⶧����
���� ������ ����Ǵ� ���̴�.
*/

-- ����) �μ���, ������ �޿��� ����, ���, �ִ�, �ּҸ� ���غ���.
SELECT e.deptno   "�μ���ȣ"
     , e.job      "����"
     , SUM(e.sal) "�μ� �޿� ����" 
     , AVG(e.sal) "�μ� �޿� ���"
     , MAX(e.sal) "�μ� �޿� �ִ�"
     , MIN(e.sal) "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job 
 ORDER BY e.deptno 
;

/*
�μ���ȣ    ,����,    �μ� �޿� ����, ���,   �ִ�,   �ּ�
--------------------------------------------------------
    10	    CLERK	    1300	    1300	1300	1300
    10	    MANAGER	    2450	    2450	2450	2450
    10	    PRESIDENT	5000	    5000	5000	5000
    20	    ANALYST	    3000	    3000	3000	3000
    20  	CLERK	    800	        800	    800	    800
    20  	MANAGER	    2975	    2975	2975	2975
    30	    CLERK	    950	        950	    950	    950
    30	    MANAGER	    2850	    2850	2850	2850
    30	    SALESMAN	5600	    1400	1600	1250
*/

-- ������Ȳ
-- a) GROUP BY ���� �׷�ȭ ������ ������ ���
SELECT e.deptno   "�μ���ȣ"
     , e.job      "����"          -- SELECT ���� ����
     , SUM(e.sal) "�μ� �޿� ����" 
     , AVG(e.sal) "�μ� �޿� ���"
     , MAX(e.sal) "�μ� �޿� �ִ�"
     , MIN(e.sal) "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno              -- GROUP BY ���� ������ job �÷� 
 ORDER BY e.deptno 
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*/

-- b) SELECT ���� �׷��Լ��� �Ϲ� �÷��� ���� ����
--    GROUP BY �� ��ü�� ������ ���

SELECT e.deptno   "�μ���ȣ"
     , e.job      "����"
     , SUM(e.sal) "�μ� �޿� ����" 
     , AVG(e.sal) "�μ� �޿� ���"
     , MAX(e.sal) "�μ� �޿� �ִ�"
     , MIN(e.sal) "�μ� �޿� �ּ�"
  FROM emp e
-- GROUP BY e.deptno, e.job              -- GROUP BY ���� ������ job �÷� 
 ORDER BY e.deptno 
;
/*
ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
00937. 00000 -  "not a single-group group function"
*/

-- ����) ����(job) �� �޿��� ����, ���, �ִ�, �ּ� �� ���غ���
--       ��Ī: ����, �޿�����, �޿����, �ִ�޿�, �ּұ޿�
SELECT e.job      ����
     , SUM(e.sal) �޿����� 
     , AVG(e.sal) �޿����
     , MAX(e.sal) �ִ�޿�
     , MIN(e.sal) �ּұ޿�
  FROM emp e
 GROUP BY e.job            
 ORDER BY e.job
;
-- ������ �̹����� ������� ������ ��� '���� �̹���'���� ���
SELECT NVL(e.job,'���� �̹���') ����
     , SUM(e.sal) �޿����� 
     , AVG(e.sal) �޿����
     , MAX(e.sal) �ִ�޿�
     , MIN(e.sal) �ּұ޿�
  FROM emp e
 GROUP BY e.job            
 ORDER BY e.job
;

-- �μ��� ����, ���, �ִ�, �ּ�
-- �μ���ȣ�� null �ΰ�� '�μ� �̹���' ���� �з��մϴ�.

SELECT NVL(e.deptno, '�μ� �̹���') �μ���ȣ 
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/* deptno�� ����, '�μ� �̹���' �� ���� �������̹Ƿ� Ÿ�� ����ġ��
   NVL() �� �۵����� ���Ѵ�.

ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"   
*/

-- �ذ��� : deptno�� ���� ����ȭ
SELECT NVL(TO_CHAR(e.deptno), '�μ� �̹���') �μ���ȣ 
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

-- ���ڸ� ���ڷ� ���� : ���տ�����(||) �� ���
SELECT NVL(e.deptno || '', '�μ� �̹���') �μ���ȣ 
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
-- NVL, DECODE, TO_CHAR �������� �ذ�
SELECT DECODE(NVL(e.deptno, 0), e.deptno, TO_CHAR(e.deptno)
                              , 0       , '�μ� �̹���') "�μ���ȣ"
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

------ 4. HAVING ���� ���

-- GROUP BY ����� ������ �ɾ
-- �� ����� ������ �������� ���Ǵ� ��
-- HAVING ���� WHERE ���� ���������
-- SELECT ������ ���� ���� ������
-- GROUP BY �� ���� ���� ����Ǵ� WHERE ���δ� 
-- GROUP BY ����� ������ �� ����.

-- ���� GROUP BY ���� ��������� ������
-- HAVIG ���� �����Ѵ�.

-- ����) �μ��� �޿� ����� 2000 �̻��� �μ��� ��ȸ�Ͽ���

-- a) �켱 �μ��� �޿� ����� ���Ѵ�.
SELECT e.deptno "�μ���ȣ"
     , AVG(e.sal) "�޿����"
  FROM emp e
 GROUP BY e.deptno
;

-- b) a�� ������� �޿� ����� 2000�̻��� ���� �����.
--    HAVING ���� ��� ����
SELECT e.deptno "�μ���ȣ"
     , AVG(e.sal) "�޿����"
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;

-- ����� ���� ����
SELECT e.deptno "�μ���ȣ"
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�޿����"
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;

-- ���� : HAVING ���� ��Ī�� ����� �� ����.
SELECT e.deptno "�μ���ȣ"
     , AVG(e.sal) "�޿����"
  FROM emp e
 GROUP BY e.deptno
HAVING "�޿����" >= 2000 -- HAVING�� ��Ī�� ����� �� ����
;
/*
ORA-00904: "�޿����": �������� �ĺ���
00904. 00000 -  "%s: invalid identifier"
*/

-- HAVING ���� �����ϴ� ��� SELECT ������ ���� ���� ����
/*
 1. FROM ���� ���̺� �� �� ��θ� �������
 2. WHERE ���� ���Ǿ� �´� �ุ �����ϰ�
 3. GROUP BY ���� ���� �÷�, ��(�Ѽ� ��)���� �׷�ȭ ����
 4. HAVING   ���� ������ ������Ű�� �׷��ุ ����
 5.          4���� ���õ� �׷� ������ ���� �࿡ ���ؼ�
 6. SELECT   ���� ��õ� �÷�, ��(�Լ�,��)�� ���
 7. ORDER BY �� �ִٸ� ���� ���ǿ� ���߾� ���� �����Ͽ� ��� ���
 */
 ---------------------------------------------------------
 
 -- ������ �ǽ�

-- 1. �Ŵ�����, ���������� ���� ���ϰ�, ���� ������ ����
--   : mgr �÷��� �׷�ȭ ���� �÷�
SELECT e.mgr "�Ŵ���"
     , COUNT(*) "���������� ��"
  FROM emp e
 GROUP BY e.mgr
 ORDER BY "���������� ��" DESC
;
/*
�Ŵ���, ���������� ��
-------------------
7698	5
        4
7839	3
7566	1
7782	1
7902	1
*/
-- 2.1 �μ��� �ο��� ���ϰ�, �ο��� ���� ������ ����
--    : deptno �÷��� �׷�ȭ ���� �÷�
SELECT e.deptno "�μ�"
     , COUNT(*) "�μ��� �ο�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY "�μ��� �ο�" DESC
;
/*
�μ�, �μ��� �ο�
---------------
30	        6
10	        3
20	        3
            3
*/
-- 2.2 �μ� ��ġ �̹��� �ο� ó��
SELECT NVL(e.deptno || '', '�μ� �̹���') "�μ�"
     , COUNT(*) "�μ��� �ο�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY "�μ��� �ο�" DESC
;
/*
�μ�,     �μ��� �ο�
-------------------
30	            6
10	            3
20	            3
�μ� ��ġ �̹���	3
*/
-- 3.1 ������ �޿� ��� ���ϰ�, �޿���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.job "����"
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�޿����"
  FROM emp e
 GROUP BY e.job
 ORDER BY "�޿����" DESC
;
/*	
����,        �޿����
-----------------------
PRESIDENT	 $5,000.00
ANALYST	    $3,000.00
MANAGER	    $2,758.33
SALESMAN    $1,400.00
CLERK	    $1,016.67
*/
-- 3.2 job �� null �� ������ ó��
SELECT NVL(e.job, '���� �̹���') "����"
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�޿����"
  FROM emp e
 GROUP BY e.job
 ORDER BY "�޿����" DESC
;
/*
����,       �޿����
---------------------
���� �̹���	
PRESIDENT	$5,000.00
ANALYST	    $3,000.00
MANAGER	    $2,758.33
SALESMAN	$1,400.00
CLERK	    $1,016.67
*/
-- 4. ������ �޿� ���� ���ϰ�, ���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.job "����"
     , SUM(e.sal) "�޿�����"
  FROM emp e
 GROUP BY e.job
 ORDER BY "�޿�����" DESC
;
/*
����,       �޿�����
-------------------
	
MANAGER	    8275
SALESMAN	5600
PRESIDENT	5000
CLERK	    3050
ANALYST	    3000
*/

-- 5. �޿��� �մ����� 1000�̸�, 1000, 2000, 3000, 5000 ���� �ο����� ���Ͻÿ�
--    �޿� ���� ������������ ����
SELECT CASE WHEN e.sal < 1000                  THEN '1000 �̸�'
            WHEN e.sal >= 1000 AND e.sal <2000 THEN '1000'
            WHEN e.sal >= 2000 AND e.sal <3000 THEN '2000'
            WHEN e.sal >= 3000 AND e.sal <5000 THEN '3000'
            WHEN e.sal >= 5000                 THEN '5000'
            ELSE '�޿�����'
        END AS "�޿�����"         
     , COUNT(*) "�ο���"
  FROM emp e
 GROUP BY CASE  WHEN e.sal < 1000                  THEN '1000 �̸�'
                WHEN e.sal >= 1000 AND e.sal <2000 THEN '1000'
                WHEN e.sal >= 2000 AND e.sal <3000 THEN '2000'
                WHEN e.sal >= 3000 AND e.sal <5000 THEN '3000'
                WHEN e.sal >= 5000                 THEN '5000'
                ELSE '�޿�����'
           END
 ORDER BY "�޿�����" 
;

SELECT NVL(TRUNC(e.sal,100) || '' , '�޿�����') AS "�޿�����"
     , COUNT(*)  
  FROM emp e
 GROUP BY NVL(TRUNC(e.sal,100) || '' , '�޿�����')
 ORDER BY "�޿�����" DESC
;

-- 6. ������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ����
SELECT e.job "����"
     ,SUBSTR(TO_CHAR(SUM(e.sal)),1,1)"�޿� ���� ����"  
  FROM emp e
 GROUP BY e.job
 ORDER BY "�޿� ���� ����" DESC
;
/*
����,      �޿� ���� ����
------------------------
	
MANAGER	    8
SALESMAN	5
PRESIDENT	5
CLERK	    3
ANALYST	    3
*/

-- 7. ������ �޿� ����� 2000������ ��츦 ���ϰ� ����� ���� ������ ����
SELECT e.job "����"
     , TO_CHAR(AVG(e.sal), '$9,999.99') "�޿����"
  FROM emp e
 GROUP BY e.job
HAVING AVG(e.sal) <= 2000
 ORDER BY "�޿����" DESC
;
/*
����,     �޿����
------------------
SALESMAN  $1,400.00
CLERK	  $1,016.67
*/

-- 8. �⵵�� �Ի� �ο��� ���Ͻÿ�
SELECT TO_CHAR(e.hiredate,'YY') "�⵵��"
     , COUNT(*) "�Ի��ο�"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate,'YY')
;
/*
�⵵��,    �Ի��ο�
---------------------
82	            1
                3
80	            1
81	           10
*/

-- 9. �⵵��, ���� �Ի� �ο��� ���Ͻÿ�.
--   : (1) hiredate �� Ȱ��
--     (2) hiredate ���� �⵵, ���� ����
--     (3) ����� �� ���� �׷�ȭ �������� ���
--     (4) �Ի� �ο��� ���϶� �Ͽ����Ƿ� COUNT(*) �׷��Լ� ���
-- a) �⵵ ���� : TO_CHAR(e.hiredate, 'YYYY')
--      �� ���� : TO_CHAR(e.hiredate, 'MM')


-- b) �� ���� �������� �׷�ȭ ����
SELECT TO_CHAR(e.hiredate,'YYYY') "�Ի� �⵵"
     , TO_CHAR(e.hiredate, 'MM')  "�Ի� ��"
     , COUNT(*)                   "�ο�(��)"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'YYYY'), TO_CHAR(e.hiredate, 'MM')  
 ORDER BY "�Ի� �⵵", "�Ի� ��"
;

-- c) �⵵��, ���� �Ի� �ο��� ����� ���� ǥ ���·� ��ȯ
-- : �⵵ ���� : TO_CHAR(e.hiredate, 'YY')
--     �� ���� : TO_CHAR(e.hiredate, 'MM')
-- : hiredate ���� ������ ���� ���� 01�� ���� ��
--   �� ���� ���� ������ 1�� ���� ī��Ʈ(COUNT(*))
--   �� ������ 12�� ���� �ݺ�

SELECT e.empno
     , e.ename
     , TO_CHAR(e.hiredate,'YYYY') "�Ի� �⵵"
     , TO_CHAR(e.hiredate, 'MM')  "�Ի� ��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1) "1��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1) "2��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1) "3��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1) "4��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '05', 1) "5��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1) "6��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1) "7��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1) "8��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1) "9��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1) "10��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1) "11��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1) "12��"
  FROM emp e
 ORDER BY "�Ի� �⵵"
;

-- �׷�ȭ ���� �÷��� "�Ի� �⵵" �� ��´�.
-- �� ���� 1�� ~ 12�� �� 1�� �����ϴ� ������ ����� �ϹǷ� COUNT() ���

SELECT TO_CHAR(e.hiredate,'YYYY') "�Ի� �⵵"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1)) "1��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1)) "2��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1)) "3��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1)) "4��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '05', 1)) "5��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1)) "6��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1)) "7��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1)) "8��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1)) "9��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1)) "10��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1)) "11��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1)) "12��"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate,'YYYY') 
 ORDER BY "�Ի� �⵵"
; 

-- ���� �� �Ի� �ο��� ���� ���η� ���
SELECT '�ο�(��)' AS "�Ի� ��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1)) "1��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1)) "2��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1)) "3��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1)) "4��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '05', 1)) "5��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1)) "6��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1)) "7��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1)) "8��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1)) "9��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1)) "10��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1)) "11��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1)) "12��"
  FROM emp e
; 