-- day09 :

-- 2. 복수행 함수(그룹 함수)

-- 1) COUNT(*) : FROM 절에 나열된
--               특정 테이블의 행의 개수(데이터 개수)를 세어주는 함수
--               NULL 값을 처리하는 "유일"한 그룹함수

--    COUNT(expr) : expr 으로 등장한 값을  NULL 제외하고 세어주는 함수

-- 문제) dept, slagrade 테이블의 전체 데이터 개수 조회
-- 1. dept 테이블 조회
SELECT d.*
  FROM dept d
;
/* 단일행 함수의 실행 과정:
DEPTNO, DNAME,      LOC
----------------------------
10	    ACCOUNTING	NEW YORK ====> SUBSTR(dname, 1,5) ====> ACCOU
20	    RESEARCH	DALLAS   ====> SUBSTR(dname, 1,5) ====> RESEA
30	    SALES	    CHICAGO  ====> SUBSTR(dname, 1,5) ====> SALES
40	    OPERATIONS	BOSTON   ====> SUBSTR(dname, 1,5) ====> OPERA
*/

/* 그룹함수(COUNT(*))의 실행 과정:
DEPTNO, DNAME,      LOC
----------------------------
10	    ACCOUNTING	NEW YORK ====>
20	    RESEARCH	DALLAS   ====> COUNT(*) ====> 4
30	    SALES	    CHICAGO  ====>
40	    OPERATIONS	BOSTON   ====>
*/
-- 2. dept 테이블의 데이터 개수 조회 : COUNT(*) 사용
SELECT COUNT(*) AS "부서 개수"
  FROM dept d
;
/*
부서 개수
---------
        4
*/

-- salgrade(급여등급) 테이블의 급여 등급 개수를 조회
SELECT COUNT(*) AS "급여 등급 개수"
  FROM salgrade
;
/*
급여 등급 개수
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

-- COUNT(expr) 이 NULL 데이터를 처리하지 못하는 것 확인을 위한 데이터 추가
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ');
COMMIT;

--emp 테이블에서 job 컬럼의 데이터 개수를 카운터
SELECT COUNT(e.job) "직무가 배정된 직원의 수"
  FROM emp e
;
/*
직무가 배정된 직원의 수
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
7654	MARTIN	SALESMAN ====> 개수를 세는 기준 컬럼인 job에
7698	BLAKE	MANAGER  ====> null 인 한 행은 처리를 하지 않는다.
7782	CLARK	MANAGER  ====> 
7839	KING	PRESIDENT====> COUNT(e.job) ====> 14
7844	TURNER	SALESMAN ====>
7900	JAMES	CLERK    ====>
7902	FORD	ANALYST  ====>
7934	MILLER	CLERK    ====>
*/

-- 문제) 회사에 매니저가 배정된 직원이 몇명인가
--       별칭 : 상사가 있는 직원의 수
SELECT COUNT(e.mgr) AS "상사가 있는 직원의 수"
  FROM emp e
;
/*
상사가 있는 직원의 수
---------------------
                  11
*/

-- 문제) 매니저 직을 맡고 있는 사람이 몇명인가?
-- 1. emp 테이블의 mgr 컬럼의 데이터 형태를 파악
-- 2. mgr 컬럼의 중복 데이터를 제거
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

-- 3. 중복 데이터가 제거된 결과를 카운트
SELECT COUNT(DISTINCT e.mgr) "매니저 수"
  FROM emp e
;
/*
매니저 수
--------
       5
*/

-- 문제) 부서가 배정된 직원이 몇명이나 있는가?
SELECT COUNT(e.deptno) "부서 배정 인원"
  FROM emp e
;
/*
부서 배정 인원
-------------
           12
*/

-- COUNT(*) 가 아닌 COUNT(expr)을 사용한 경우에는
SELECT e.deptno
  FROM emp e
 WHERE e.deptno IS NOT NULL
;
-- 을 수행한 결과를 카운트 한 것으로 생각할 수 있음.

-- 문제) 전체인원, 부서 배정 인원, 부서 미배정 인원을 구하시오.
SELECT COUNT(*)        "전체인원" 
     , COUNT(e.deptno) "부서 배정 인원"
     , COUNT(*) - COUNT(e.deptno) "부서 미배정 인원"
  FROM emp e
;

-- SUM(expr) : NULL 항목 제외하고
--             합산 가능한 행을 모두 더한 결과를 출력

-- SALESMAN 들의 수당 총합을 구해보자

SELECT SUM(e.comm) "수당 총합"
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
1400   ====> SUM(e.comm) ====> 2200 : 자동으로 NULL 컬럼 제외
(null)       
(null)
(null)
0
(null)
*/

SELECT SUM(e.comm) "수당 총합"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

/*
COMM
-------
  300    ====>
  500    ====>

  1400   ====> SUM(e.comm) ====> 2200 : 자동으로 NULL 컬럼 제외
     0   ====>
*/

-- 수당 총합 결과에 숫자 출력 패턴을 적용 $, 세자리 끊어 읽기 전용
SELECT TO_CHAR(SUM(e.comm), '$9,999') "수당 총합"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

/*
수당 총합
--------
 $2,200
*/   

-- 3) AVG(expr) : NULL 값 제외하고 연산 가능한 항목의 산술 평균을 구함

-- SALESMEN 의 수당 평균을 구해보자.

SELECT AVG(e.comm) "수당 평균"
  FROM emp e
 WHERE e.job = 'SALESMAN'  
;

-- 수당 평균 결과에 숫자 출력 패턴 $,세자리 끊어 읽기 적용
SELECT TO_CHAR(AVG(e.comm), '$9,999') "수당 평균"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

-- 4) MAX(expr) : expr에 등장한 값 중 최댓값을 구함
--                expr이 문자인 경우는 알파벳순 뒤쪽에 위치한 글자를
--                최댓값으로 계산

-- 이름이 가장 나중인 직원
SELECT MAX(e.ename) "이름이 가장 나중인 직원"
  FROM emp e
;
/*
이름이 가장 나중인 직원
----------------------
WARD
*/

-- 5) MIN(expr) : expr에 등장한 값 중 최솟을 구함
--                expr이 문자인 경우는 알파벳순 앞쪽에 위치한 글자를
--                최소값으로 계산

SELECT MIN(e.ename) "이름이 가장 앞인 직원"
  FROM emp e
;
/*
이름이 가장 앞인 직원
--------------------
ALLEN
*/

---- 3. GROUP_BY 절의 사용
-- 문제) 각 부서별로 급여의 총합, 평균, 최대, 최소를 조회

--  각 부서별로 급여의 총합을 조회하려면
--    총합 : SUM() 을 사용
--    그룹화 기준을 부서번호(deptno)를 사용
--    GROUP BY 절이 등장해야 함

-- a) 먼저 emp 테이블에서 급여 총합을 구하는 구문 작성
SELECT SUM(e.sal) "급여 총합"
  FROM emp e
;

-- b) 부서 번호를 기준으로 그룹화 진행
--    SUM()은 그룹함수다.
--    GROUP BY 절을 조합하면 그룹화 가능하다.
--    그룹화를 하려면 기준컬럼이 GROUP BY 절에 등장해야 함.

SELECT e.deptno 부서번호 -- 그룹화 기준컬럼을 SELECT 절에 등장
     , SUM(e.sal) "부서 급여 총합" -- 그룹함수가 사용된 컬럼
  FROM emp e
 GROUP BY e.deptno -- 그룹화 기준컬럼으로 GROUP BY 절에 등장
 ORDER BY e.deptno -- 부서번호 정렬 
;

-- GROUP BY 절에 그룹화 기준 컬럼으로 등장한 컬럼이 아닌
-- SELECT 절에 등장하면 오류, 실행불가
SELECT e.deptno 부서번호 -- 그룹화 기준컬럼을 SELECT 절에 등장
     , e.job -- 그룹화 기준컬럼이 아닌데 SELECT 절에 등장 -> 오류의 원인
     , SUM(e.sal) "부서 급여 총합" -- 그룹함수가 사용된 컬럼
  FROM emp e
 GROUP BY e.deptno -- 그룹화 기준컬럼으로 GROUP BY 절에 등장
 ORDER BY e.deptno -- 부서번호 정렬 
;
/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*/

-- 문제) 부서별 급여의 총합, 평균, 최대, 최소
SELECT e.deptno 부서번호 
     , SUM(e.sal) "부서 급여 총합" 
     , AVG(e.sal) "부서 급여 평균"
     , MAX(e.sal) "부서 급여 최대"
     , MIN(e.sal) "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

--숫자 패턴 적용
SELECT e.deptno 부서번호 
     , TO_CHAR(SUM(e.sal), '$9,999') "부서 급여 총합" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999') "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
부서번호, 부서 급여 총합, 부서 급여 평균, 부서 급여 최대, 부서 급여 최소
------------------------------------------------------------------
10	            $8,750	 $2,916.67	    $5,000	        $1,300
20	            $6,775	 $2,258.33	    $3,000	        $800
30	            $9,400	 $1,566.67	    $2,850	        $950
*/

-- 부서번호를 삭제한 쿼리
SELECT TO_CHAR(SUM(e.sal), '$9,999') "부서 급여 총합" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999') "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

/*
위의 쿼리는 수행되지만 정확하게 어느 부서의 결과인지 알 수 없다는 단점이 존재

그래서, GROUP BY 절에 등장하는 기준 컬럼은 SELECT 절에 똑같이 등장하는 편이
결과 해석에 편리하다.

SELECT 절에 나열된 컬럼중에서 그룹함수가 사용되지 않는 컬럼이 없기때문에
위의 쿼리는 수행되는 것이다.
*/

-- 문제) 부서별, 직무별 급여의 총합, 평균, 최대, 최소를 구해보자.
SELECT e.deptno   "부서번호"
     , e.job      "직무"
     , SUM(e.sal) "부서 급여 총합" 
     , AVG(e.sal) "부서 급여 평균"
     , MAX(e.sal) "부서 급여 최대"
     , MIN(e.sal) "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno, e.job 
 ORDER BY e.deptno 
;

/*
부서번호    ,직무,    부서 급여 총합, 평균,   최대,   최소
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

-- 오류상황
-- a) GROUP BY 절에 그룹화 기준이 누락된 경우
SELECT e.deptno   "부서번호"
     , e.job      "직무"          -- SELECT 에는 등장
     , SUM(e.sal) "부서 급여 총합" 
     , AVG(e.sal) "부서 급여 평균"
     , MAX(e.sal) "부서 급여 최대"
     , MIN(e.sal) "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno              -- GROUP BY 에는 누락된 job 컬럼 
 ORDER BY e.deptno 
;
/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*/

-- b) SELECT 절에 그룹함수와 일반 컬럼이 섞여 등장
--    GROUP BY 절 전체가 누락된 경우

SELECT e.deptno   "부서번호"
     , e.job      "직무"
     , SUM(e.sal) "부서 급여 총합" 
     , AVG(e.sal) "부서 급여 평균"
     , MAX(e.sal) "부서 급여 최대"
     , MIN(e.sal) "부서 급여 최소"
  FROM emp e
-- GROUP BY e.deptno, e.job              -- GROUP BY 에는 누락된 job 컬럼 
 ORDER BY e.deptno 
;
/*
ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
00937. 00000 -  "not a single-group group function"
*/

-- 문제) 직무(job) 별 급여의 총합, 평균, 최대, 최소 를 구해보자
--       별칭: 직무, 급여총합, 급여평균, 최대급여, 최소급여
SELECT e.job      직무
     , SUM(e.sal) 급여총합 
     , AVG(e.sal) 급여평균
     , MAX(e.sal) 최대급여
     , MIN(e.sal) 최소급여
  FROM emp e
 GROUP BY e.job            
 ORDER BY e.job
;
-- 직무가 미배정인 사람들은 직무명 대신 '직무 미배정'으로 출력
SELECT NVL(e.job,'직무 미배정') 직무
     , SUM(e.sal) 급여총합 
     , AVG(e.sal) 급여평균
     , MAX(e.sal) 최대급여
     , MIN(e.sal) 최소급여
  FROM emp e
 GROUP BY e.job            
 ORDER BY e.job
;

-- 부서별 총합, 평균, 최대, 최소
-- 부서번호가 null 인경우 '부서 미배정' 으로 분류합니다.

SELECT NVL(e.deptno, '부서 미배정') 부서번호 
     , TO_CHAR(SUM(e.sal), '$9,999') "부서 급여 총합" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999') "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/* deptno는 숫자, '부서 미배정' 은 문자 데이터이므로 타입 불일치로
   NVL() 이 작동하지 못한다.

ORA-01722: 수치가 부적합합니다
01722. 00000 -  "invalid number"   
*/

-- 해결방법 : deptno의 값을 문자화
SELECT NVL(TO_CHAR(e.deptno), '부서 미배정') 부서번호 
     , TO_CHAR(SUM(e.sal), '$9,999') "부서 급여 총합" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999') "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

-- 숫자를 문자로 변경 : 결합연산자(||) 를 사용
SELECT NVL(e.deptno || '', '부서 미배정') 부서번호 
     , TO_CHAR(SUM(e.sal), '$9,999') "부서 급여 총합" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999') "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
-- NVL, DECODE, TO_CHAR 조합으로 해결
SELECT DECODE(NVL(e.deptno, 0), e.deptno, TO_CHAR(e.deptno)
                              , 0       , '부서 미배정') "부서번호"
     , TO_CHAR(SUM(e.sal), '$9,999') "부서 급여 총합" 
     , TO_CHAR(AVG(e.sal), '$9,999.99') "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999') "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

------ 4. HAVING 절의 사용

-- GROUP BY 결과에 조건을 걸어서
-- 그 결과를 제한할 목적으로 사용되는 절
-- HAVING 절은 WHERE 절과 비슷하지만
-- SELECT 구문의 실행 순서 때문에
-- GROUP BY 절 보다 먼저 실행되는 WHERE 절로는 
-- GROUP BY 결과를 제한할 수 없다.

-- 따라서 GROUP BY 다음 수행순서를 가지는
-- HAVIG 에서 제한한다.

-- 문제) 부서별 급여 평균이 2000 이상인 부서를 조회하여라

-- a) 우선 부서별 급여 평균을 구한다.
SELECT e.deptno "부서번호"
     , AVG(e.sal) "급여평균"
  FROM emp e
 GROUP BY e.deptno
;

-- b) a의 결과에서 급여 평균이 2000이상인 값만 남긴다.
--    HAVING 으로 결과 제한
SELECT e.deptno "부서번호"
     , AVG(e.sal) "급여평균"
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;

-- 결과에 숫자 패턴
SELECT e.deptno "부서번호"
     , TO_CHAR(AVG(e.sal), '$9,999.99') "급여평균"
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;

-- 주의 : HAVING 에는 별칭을 사용할 수 없다.
SELECT e.deptno "부서번호"
     , AVG(e.sal) "급여평균"
  FROM emp e
 GROUP BY e.deptno
HAVING "급여평균" >= 2000 -- HAVING에 별칭은 사용할 수 없음
;
/*
ORA-00904: "급여평균": 부적합한 식별자
00904. 00000 -  "%s: invalid identifier"
*/
