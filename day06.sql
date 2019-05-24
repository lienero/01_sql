-- day06 
----- 2) �����Լ�
-------- 1. INITCAP(str) : str �� ù ���ڸ� �빮��ȭ(����)
SELECT initcap('the watch') -- The Watch
  FROM dual
;
SELECT initcap('�ȳ��ϼ���. ������') -- �ȳ��ϼ���. ������
  FROM dual
;

-------- 2. LOWER(str) : str �� ��� ���ڸ� �ҹ���ȭ(����)
SELECT lower('MR. SCOTT MCMILLAN') "�ҹ��ڷ� ����" 
  FROM dual
;
-- mr. scott mcmillan

-------- 3. UPPER(str) : str�� ��� ���ڸ� �빮��ȭ(����)
SELECT upper('lee') "���� �빮�ڷ� ����"
  FROM dual
;
SELECT upper('sql is coooooooooool~!!!') "��վ��!"
  FROM dual
;

-- smith �� ã�µ� �Է��� �ҹ��ڷ� �� ��쿡
-- SMITH �� �ٸ� ���ڷ� �νĵǹǷ� ã�� �� ����.
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'smith'
;
-- ����� ��� �� : 0
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;
-- ename �� ���ϴ� ���� �빮�� �̹Ƿ� ������ ��ȸ ��.
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = upper('smith')
;
/*
EMPNO,  ENAME
--------------
7369	SMITH
*/

-------- 4. LENGTH(str), LENGTHB(str) : 
--          str�� ���ڱ���, ������ byte�� ����Ͽ� ���ڷ� ���
SELECT length('hello, sql') as "���� ����" 
  FROM dual
;
-- 10 ==> Ư����ȣ, ���鵵 ���� ���̷� ���
SELECT 'hello, sql�� ���� ���̴�' || length('') 
                                  || '�Դϴ�.' "���� ����"
  FROM dual
;
/*
���� ����
---------------------------
hello, sql�� ���� ���̴��Դϴ�.
*/

-- oracle���� �ѱ��� 3byte�� ���
SELECT lengthb('hello, sql') "���� byte"
  FROM dual
;
-- ��� : 10 ==> �����ڴ� 1byte �Ҵ�
SELECT lengthb('����Ŭ') "���� byte"
  FROM dual
;
-- ��� : 9 ==. �ѱ��� 3byte �Ҵ�

-------- 5. CONCAT(str1, str2) : str1�� str2�� ���ڿ� ����
--                               || �����ڿ� ������ ���
SELECT concat('�ȳ��ϼ���.', 'SQL!' ) "�λ�!"
  FROM dual
;
/*
�λ�
---------------
�ȳ��ϼ���.SQL!
*/
-- concat('�ȳ��ϼ���.', 'SQL') �� ���� ����� ���� || ���� ���
SELECT '�ȳ��ϼ���.' || 'SQL!' "�λ�" 
  FROM dual
;

-------- 6. SUBSTR(str, i, n) :
--          str ���� i��° ��ġ�������� n���� ���ڸ� ����
--          SQL ���� ���ڿ��� �ε���(����)�� 1���� ����
SELECT substr('SQL is  cooooooooool~~!!', 3, 4)
  FROM dual 
;
/*
L is
*/
---------    SUBSTR(str, i):
--           str ���� i��° ��ġ���� ������ ���ڸ� ����
SELECT substr('SQL is  cooooooooool~~!!', 3)
  FROM dual 
;
/*
L is  cooooooooool~~!!
*/
-- ���� : SQL is coooooooool~~!! ���� SQL �� �����غ���
SELECT substr('SQL is coooooooool~~!!',1,3)
  FROM dual
;

-- ���� : SQL is coooooooool~~!! ���� is �� �����غ���
SELECT substr('SQL is coooooooool~~!!',5,2)
  FROM dual
;
-- ���� : SQL is coooooooool~~!! ���� ~~!! �� �����غ���
SELECT substr('SQL is cooooooooool~~!!',20,4)
  FROM dual
;
-- ���� : emp ���̺��� ������ �̸��� �� �α��ڱ����� �����Ͽ�
--        ����� �Բ� ��ȸ�Ͻÿ�.
SELECT e.empno
     , substr(e.ename, 1, 2) AS "����� �̸�"
  FROM emp e
;
/*
EMPNO, ����� �̸�
-------------
8888	J%
9999	J_
7369	SM
7499	AL
7521	WA
7566	JO
7654	MA
7698	BL
7782	CL
7839	KI
7844	TU
7900	JA
7902	FO
7934	MI
*/

------------ 7. INSTR(str1, str2) : 
--              �ι�° ���ڿ��� str2��
--              ù��° ���ڿ��� str1�� ��� ��ġ�ϴ���
--              �����ϴ� ��ġ�� ����Ͽ� ���ڷ� ���
SELECT instr('SQL is cooooooooool~~!!', 'is') "is ��ġ"
  FROM dual
;
/*
is ��ġ
------
5
*/
SELECT instr('SQL is cooooooooool~~!!', 'io') "io ��ġ"
  FROM dual
;
/*
�ι�° ���ڿ��� ù��° ���ڿ��� ������ 0�� ����Ѵ�.
io�� ��ġ
--------
0
*/

----------- 8.  LPAD, RPAD(str, n, c) :
--              �Էµ� str�� ���ؼ� ��ü ���ڰ� ������ �ڸ����� n���� ���
--              ��ü ���ڼ� ��� ���� / �����ʿ� ���� �ڸ����� 
--              c�� ���ڸ� ä���ִ´�.
SELECT lpad('SQL is cool!', 20, '*')
  FROM dual
;
/*
********SQL is cool!
*/

SELECT rpad('SQL is cool!', 20, '*')
  FROM dual
;
/*
SQL is cool!********
*/

----------- 9. LTRIM, RTRIM, TRIM : �Էµ� ���ڿ���
--             ����, ������, ���� ������ ����
SELECT '>' || ltrim( '     sql is cool     ') || '<'
  FROM dual
;
/*
>sql is cool     <
*/
SELECT '>' || rtrim( '     sql is cool     ') || '<'
  FROM dual
;
/*
>     sql is cool<
*/

SELECT '>' || trim( '     sql is cool     ') || '<'
  FROM dual
;
/*
>sql is cool<
*/
--
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = '  SMITH '
;
-- ����� ��� ��: 0 == > '  SMITH ' ������ �� ���� 'SMITH' �� �ٸ��Ƿ�
--                       SMITH ������ ��ȸ���� ����
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = trim('  SMITH ')
;

-- '  SMITH ' ���� trim �Լ��� �����Ͽ� ��ȸ ����
-- ���� : �񱳰��� '  smith ' �� ��, SMITH�� ������ ��ȸ�Ͻÿ�. 
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = upper(trim('  smith ')) -- �Լ� ��ø
;
/*
EMPNO,  ENAEM
--------------
7369	SMITH
*/

---------- 10.NVL(expr1, expr2)
--            NVL2(expr1, expr2, expr3)
--            NULLIF(expr1, expr2)

-- NVL(expr1, expr2) : ù��° ���� ���� NULL �̸�
--                     �ι�° ������ ��ü�Ͽ� ���

-- �Ŵ���(mgr)�� �������� ���� ������ ���
-- �Ŵ����� ����� 0���� ��ü�Ͽ� ���
SELECT e.empno
     , e.ename
     , nvl(e.mgr, 0) "�Ŵ��� ���"
  FROM emp e
;
/*
EMPNO,  ENAME,  �Ŵ��� ���
--------------------------
8888	J%JAMES	0
9999	J_JAMES	0
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	0
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/

-- �Ŵ���(mgr)�� �������� ���� ������
-- '�Ŵ��� ����' ��� ����Ͻÿ�.
SELECT e.empno
     , e.ename
     , nvl(e.mgr, '�Ŵ��� ����') "�Ŵ��� ���"
  FROM emp e
;
/*
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number

==> nvl ó�� ��� �÷��� e.mgr �� ����Ÿ���� �������ε�
--  NULL ���� ��ü�ϴ� '�Ŵ��� ����' �� ����Ÿ���� ������ �̹Ƿ�
--  ��ȯ�� mgr �÷��� Ÿ�Ӱ� ����ġ�ϱ⶧����
--  ����� ���� ������ �߻�
*/

-- ==> �ذ��� e.mgr �� ����Ÿ������ ����
SELECT e.empno
     , e.ename
     , nvl(e.mgr || '', '�Ŵ��� ����') "�Ŵ��� ���"
  FROM emp e
;
-- || ���տ����ڷ� mgr�� ���ڸ� �ٿ��� ����Ÿ������ ����
/*
EMPNO,  ENAME,  �Ŵ��� ���
----------------------------
8888	J%JAMES	�Ŵ��� ����
9999	J_JAMES	�Ŵ��� ����
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	�Ŵ��� ����
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/

-- ���� : || ������ ��� concat() �Լ��� ����Ͽ� ���� ����� ���ÿ�

SELECT e.empno
     , e.ename
     , nvl(concat(e.mgr, ''), '�Ŵ��� ����') "�Ŵ��� ���"
  FROM emp e
;
-- ����Ŭ ������ �� ���ڿ�('') �� NULL �� ���

-- NVL2(expr1, expr2, expr3) : 
--     ù��° ���� ���� NOT NULL �̸� �ι�° ���� ������ ���
--                     NULL �̸� ����° ���� ������ ���

-- �Ŵ���(mgr)�� ������ ��쿡�� '�Ŵ��� ����' ���� 
-- �Ŵ����� �������� ���� ��쿡�� '�Ŵ��� ����' ���� ���

SELECT e.empno
     , e.ename
     , nvl2(e.mgr,'�Ŵ��� ����', '�Ŵ��� ����') "�Ŵ��� ��/��"
  FROM emp e
; 
/*
EMPNO,  ENAME,  �Ŵ��� ��/��
---------------------------
8888	J%JAMES	�Ŵ��� ����
9999	J_JAMES	�Ŵ��� ����
7369	SMITH	�Ŵ��� ����
7499	ALLEN	�Ŵ��� ����
7521	WARD	�Ŵ��� ����
7566	JONES	�Ŵ��� ����
7654	MARTIN	�Ŵ��� ����
7698	BLAKE	�Ŵ��� ����
7782	CLARK	�Ŵ��� ����
7839	KING	�Ŵ��� ����
7844	TURNER	�Ŵ��� ����
7900	JAMES	�Ŵ��� ����
7902	FORD	�Ŵ��� ����
7934	MILLER	�Ŵ��� ����
*/

-- ����Ŭ���� �� ���ڿ�('')�� NULL �� ����ϴ� ����
-- Ȯ���ϱ� ���� ����

--�Է��� �� ���ڿ�
SELECT nvl2('', 'IS NOT NULL', 'IS NULL') "NULL �� ����" 
  FROM dual
;
/*
NULL�� ����
---------
IS NULL
*/
-- �Է��� ���� 1ĭ ¥�� ����
SELECT nvl2(' ', 'IS NOT NULL', 'IS NULL') "NULL �� ����" 
  FROM dual
;
/*
NULL �� ����
------------
IS NOT NULL
*/

-- NULLIF(expr1, expr2) :
-- ù��° ��, �ι�° ���� ���� �����ϸ� NULL �� ���
-- �� ���� �ٸ��� ù��° ���� ���� ���
SELECT nullif('AAA', 'bbb') NULLIF��� -- AAA 
  FROM dual
;
/*
NULLIF���
------------
AAA
*/
SELECT nullif('AAA', 'AAA') NULLIF��� --(null) 
  FROM dual
;
/*
NULLIF���
------------
(null)
*/
-- ��ȸ�� ��� ���� 1���� �����ϰ� �� ���� NULL �� ����
-- 1���̶� ��ȸ�� �� ����  "����� ��� ��:0" �� �ٸ��ٴ� �Ϳ� ����


------  3) ��¥�Լ� : ��¥�� ���õ� ���/ ��¥�� ���ϱ� ���� ���� ������
--                    �� �� �ִ� ����� ����

-- ������ �ý��� �ð��� ��� sysdate �Լ�
SELECT sysdate
  FROM dual
;
/*
SYSDATE
-------
19/05/24 ==> ����Ŭ�� ��¥ �⺻ ���� YY/MM/DD 
*/

-- TO_CHAR(arg) : arg�� ����, ��¥, Ÿ���� �����Ͱ� �� �� �ִ�.
--                �Էµ� arg�� ����Ÿ������ �������ִ� �Լ�
SELECT to_char(sysdate, 'YYYY') "�⵵" -- 2019
  FROM dual
;

SELECT to_char(sysdate, 'YY') "�⵵" -- 19
  FROM dual
;

SELECT to_char(sysdate, 'MM') "��" -- 05
  FROM dual
;

SELECT to_char(sysdate, 'MONTH') "��" -- 5��
  FROM dual
;

SELECT to_char(sysdate, 'MON') "��" -- 5��
  FROM dual
;

SELECT to_char(sysdate, 'DD') "��" -- 24��
  FROM dual
;

SELECT to_char(sysdate, 'D') "����" -- 6 : �ݿ����� ���ڴ� 6
  FROM dual
;

SELECT to_char(sysdate, 'DAY') "����" -- �ݿ���
  FROM dual
;

SELECT to_char(sysdate, 'DY') "����"  -- ��
  FROM dual
;
-- ������ ����
SELECT to_char(sysdate, 'YYYY-MM-DD') "���� ��¥" -- 2019-05-24
  FROM dual
;

SELECT to_char(sysdate, 'FMYYYY-MM-DD') "���� ��¥" --2019-5-24
  FROM dual
;

SELECT to_char(sysdate, 'YY-MM-DD') "���� ��¥" --19-05-24
  FROM dual
;

SELECT to_char(sysdate, 'YY-MM-DD DAY') "���� ��¥" --19-05-24 �ݿ���
  FROM dual
;
SELECT  to_char(sysdate, 'YY-MM-DD DY') "���� ��¥" --19-05-24 ��
  FROM dual
;
/* �ð� ���� :
    HH : �ð��� ������ ǥ��
    MI : ���� ���ڸ��� ǥ��
    SS : �ʸ� ���ڸ��� ǥ��
    HH24 : �ð��� 24�ð� ü���� ǥ��
    AM : �������� �������� ǥ��
*/

SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') "���� ��¥ �ú���" 
  FROM dual
;
-- 2019-05-24 15:29:57

SELECT to_char(sysdate, 'YYYY-MM-DD HH:MI:SS') "���� ��¥ �ú���" 
  FROM dual
;
-- 2019-05-24 03:42:07 <== 03�ð� �������� �������� �Ǻ� �Ұ�
SELECT to_char(sysdate, 'YYYY-MM-DD AM HH:MI:SS') "���� ��¥ �ú���" 
  FROM dual
;
-- 2019-05-24 ���� 03:42:45 <== AM ���Ϲ��ڸ� �����ϸ� ����/���� ������


-- ��¥ ���� ������ ���� : +, - �����ڸ� ���
-- �������κ��� 10�� ��
SELECT sysdate + 10
  FROM dual
;
-- 19/06/03 (���� ��¥: 19/05/24 �� ��)

-- 10�� ��
SELECT sysdate - 10
  FROM dual
;
-- 19/05/14

-- 10�ð� ��
SELECT sysdate + 10/24
  FROM dual
;
-- 10�ð� �ĸ� ��/��/�� ���� ���
SELECT to_char (sysdate + 10/24, 'YYYY-MM-DD HH24:MI:SS') "10�ð� ��"
  FROM dual
;

-- 2019-05-25 01:47:18

------- 1. MONTH_BETWEEN(��¥1, ��¥2) :
--         �� ��¥ ������ ���� ����

-- �� ������ �Ի��� ���κ��� ������� ����� �ٹ��ߴ��� ��ȸ�Ͻÿ�.
SELECT e.empno
     , e.ename
     , MONTHS_BETWEEN(sysdate, e.hiredate) "�ټ� ���� ��"
  FROM emp e 
;

-- �� ������ �ټ� �������� ���ϵ�
-- �Ҽ��� 1�� �ڸ������� ����Ͻÿ�
-- �̶�, �Ҽ��� 2�� �ڸ����� �ݿø�
SELECT e.empno
     , e.ename
     , ROUND(MONTHS_BETWEEN(sysdate, e.hiredate),1) "�ټ� ���� ��"
  FROM emp e 
;

------- 2. ADD_MONTH(��¥, ����):
--         ��¥�� ���ڸ� ���� ���� ���� ��¥�� ����

SELECT add_months(sysdate, 3) -- ����κ��� 3���� ���� ��¥
  FROM dual
;
-- ��¥ + ���� : ���� ��ŭ�� �� ���� ���Ͽ� ��¥�� ����
-- ��¥ + ����/24 : ���� ��ŭ�� �ð��� ���Ͽ� ��¥�� ����
-- ADD_MONTHS(��¥, ����) : ���� ��ŭ�� ���� ���Ͽ� ��¥�� ����

------- 3. NEXT_DAY, LAST_DAY : 
--         ���� ���Ͽ� �ش��ϴ� ��¥�� ����
--         �̴��� ������ ��¥�� ����

-- ���� ��¥���� ���ƿ��� ��(4) ������ ��¥�� ����
SELECT next_day(sysdate, 4) "���ƿ��� ������"
  FROM dual
;

SELECT next_day(sysdate, '������') "���ƿ��� ������"
  FROM dual
;

SELECT last_day(sysdate) "�� ���� ������ ��"
  FROM dual
;

------ 4. ROUND, TRUNC : ��¥�� ���� �ݿø� ,���� ����
SELECT round(sysdate) "���� �ð�" 
  FROM dual
;  

-- ���� : ���� �ð����� �ݿø� �� ��¥�� ��/��/�� ���� ���
-- ��Ʈ : to_char() �ú��� ���� ����� �� �ִ� ��¥/�ð� ������ ����
SELECT to_char(round(sysdate), 'YYYY-MM-DD HH24:MI:SS') "���� �ð�" 
  FROM dual
;  

SELECT trunc(sysdate) "���� �ð����� �ú��� ����"
  FROM dual
;
SELECT to_char(trunc(sysdate),'YYYY-MM-DD HH24:MI:SS')  "���� �ð����� �ú��� ����"
  FROM dual 
;
