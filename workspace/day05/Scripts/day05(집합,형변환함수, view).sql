-- 집합

--결과 6개 행
SELECT * FROM EMP E
WHERE DEPTNO = 30;

--결과 3개 행
SELECT * FROM EMP E
WHERE DEPTNO = 10;

--EMP 테이블에서 DEPTNO가 30 또는 10인 데이터를 조회
-- 두 테이블을 UNION(합집합)으로 연결한다
SELECT * FROM EMP
WHERE DEPTNO = 30
UNION
SELECT * FROM EMP
WHERE DEPTNO = 10;


SELECT * FROM EMP
WHERE DEPTNO = 30
UNION ALL
SELECT * FROM EMP
WHERE DEPTNO = 10;

-- EMP 테이블에서 SAL 1000이상 2000이하, 1500이상 3000이하의 결과를 같이 조회
SELECT * FROM EMP e 
WHERE SAL BETWEEN 1000AND 2000
UNION ALL
SELECT * FROM EMP e2 
WHERE SAL BETWEEN 1500 AND 3000;

-- 타입과 어트리뷰트가 다를때
SELECT * FROM EMP;
SELECT * FROM DEPT;

-- 오류 : 열의 수가 다르면 UNION을 사용할 수 없다
--SELECT * FROM EMP e
--UNION
--SELECT * DEPT;

-- 오류 : 어트리뷰트의 타입이 다르므로 UNION을 사용할 수 없다
--SELECT EMPNO, DEPTNO, JOB
--UNION
--SELECT DEPTNO, DNAME, LOC FROM DEPT;


--열의 수와 타입이 일치한다면 UNION이 가능하다
SELECT SAL, ENAME, JOB FROM EMP
UNION 
SELECT DEPTNO, DNAME, LOC FROM DEPT;

-- 위쪽 쿼리에 별칭을 주면 결과 테이블의 열 이름으로 사용된다
SELECT DEPTNO 숫자, DNAME 문자, LOC 문자 FROM DEPT
UNION
SELECT SAL, ENAME, JOB FROM EMP;


-- UNION이 두 테이블 합치고 ORDER BY가 실행되므로
-- 합쳐지기 이전의 컬럼명이나 소속을 이용해도 정렬되지 않는다 / 별칭을 붙였다면 별칭을 사용해야한다
-- JOIN은 가로방향으로 합침, 집합은 위, 아래로 합쳐짐
SELECT EMPNO , ENAME 이름, JOB 직장
FROM EMP E
UNION
SELECT * FROM DEPT D
ORDER BY 직장;

-- 교집합
SELECT * FROM PLAYER p;

SELECT PLAYER_NAME 이름, TEAM_ID 팀,  HEIGHT 키, WEIGHT 몸무게
FROM PLAYER p 
WHERE HEIGHT BETWEEN 185 AND 186
INTERSECT
SELECT PLAYER_NAME 이름, TEAM_ID 팀,  HEIGHT 키, WEIGHT 몸무게
FROM PLAYER p2 
WHERE WEIGHT BETWEEN 76 AND 78;

-- 차집합
SELECT PLAYER_NAME 이름, TEAM_ID 팀,  HEIGHT 키, WEIGHT 몸무게
FROM PLAYER p 
WHERE HEIGHT BETWEEN 185 AND 186
MINUS
SELECT PLAYER_NAME 이름, TEAM_ID 팀,  HEIGHT 키, WEIGHT 몸무게
FROM PLAYER p2 
WHERE WEIGHT BETWEEN 76 AND 78;




-- 형 변환 함수
-- TO_CHAR()
SELECT SYSDATE FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"년 "MM"월 "DD"일"') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD-HH24:MI') FROM DUAL;

-- TO_NUMBER() 문자와 숫자
SELECT'1234',  TO_NUMBER('1234') FROM DUAL;

-- 자동형변환 문자->숫자
SELECT '123' + '123' FROM DUAL; 

-- TO_DATE()
SELECT'2300-12-25', TO_DATE('2300-12-25', 'YYYY-MM-DD') FROM DUAL;


--view
-- 회원정보와 대여정보를 조합
CREATE VIEW MEMRENTAL AS 
SELECT M.MEM_ID, M.MEM_NAME, R.REN_ID, R.BOOK_ID, R.REN_RENTALDATE, R.REN_RETURNDATE
FROM TBL_MEMBER m
JOIN TBL_RENTAL R
ON M.MEM_ID = R.MEM_ID;

SELECT *FROM MEMRENTAL;

SELECT SYSDATE FROM DUAL;


SELECT * FROM TBL_RENTAL;

-- PLAYER 테이블에서 나이 컬럼을 추가한 뷰 만들기
SELECT * FROM PLAYER p;

SELECT PLAYER_NAME, BIRTH_DATE, SYSDATE - BIRTH_DATE
FROM PLAYER P;

SELECT PLAYER_NAME 이름, TO_CHAR(TRUNC(BIRTH_DATE), 'YYYY-MM-DD') 생일, ROUND((SYSDATE - BIRTH_DATE)/365, 0) AS 나이
FROM PLAYER P;

-- TRUNC 함수 : 시간정보를 제거한 날짜값만 유지됨
-- TRUNC(data, [, format]) : 날짜값에서 시간정보(HH:MI:SS)를 제거하고 날짜만 반환됨

CREATE VIEW VIEW_PLAYER AS 
SELECT PLAYER_NAME 이름, TO_CHAR(TRUNC(BIRTH_DATE), 'YYYY-MM-DD') 생일, ROUND((SYSDATE - BIRTH_DATE)/365, 0) AS 나이
FROM PLAYER P;

SELECT * FROM VIEW_PLAYER;

SELECT 이름, 나이 FROM VIEW_PLAYER;

DROP VIEW VIEW_PLAYER;


SELECT P.*, ROUND((SYSDATE-BIRTH_DATE)/365, 0) AS AGE
FROM PLAYER P;

CREATE VIEW VIEW_PLAYER AS
SELECT P.*, ROUND((SYSDATE-BIRTH_DATE)/365, 0) AS AGE
FROM PLAYER P;


SELECT * FROM VIEW_PLAYER;

-- EMPLOYEES 테이블에서 사원이름과 그 매니저 이름이 있는 VIEW 만들기
SELECT *  FROM EMPLOYEES e;

--SELF JOIN

CREATE VIEW view_employees AS 
SELECT e1.employee_id, e1.FIRST_NAME || ' ' || e1.LAST_NAME 사원이름, 
   e2.MANAGER_ID, e2.FIRST_NAME || ' ' || e2.LAST_NAME 매니저이름,
   e1.job_id, e1.department_id
FROM EMPLOYEES e1 JOIN EMPLOYEES e2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID;



select employee_id, e.FIRST_NAME || ' ' || e.LAST_NAME 사원이름 FROM EMPLOYEES e;
select MANAGER_id, e.FIRST_NAME || ' ' || e.LAST_NAME 사원이름 FROM EMPLOYEES e;


select employee_id, e.FIRST_NAME || ' ' || e.LAST_NAME 사원이름,
   MANAGER_id, e.FIRST_NAME || ' ' || e.LAST_NAME 매니저이름 FROM EMPLOYEES e;

  
-- 셀프조인 : employees 테이블내에서 직원과 해당 직원의 매니저를 같은 테이블 매칭
SELECT e1.employee_id 사원테이블, e2.EMPLOYEE_ID 매니저테이블, e1.employee_id, e1.FIRST_NAME || ' ' || e1.LAST_NAME 사원이름,
   e2.MANAGER_ID, e2.FIRST_name || ' ' || e2.last_name 매니저이름
FROM employees e1 JOIN employees e2
ON e1.MANAGER_ID = e2.employee_id;
-- e1 : 사원, e2 : 매니저
-- on e1.MANAGER_ID = e2.employee_id
-- e1 사원의 manager_id가 e2 매니저 employee_id 일치할 때 두 행을 매칭

CREATE VIEW view_employees AS
SELECT e1.employee_id, e1.FIRST_NAME || ' ' || e1.LAST_NAME 사원이름, 
   e2.MANAGER_ID, e2.FIRST_NAME || ' ' || e2.LAST_NAME 매니저이름,
   e1.job_id, e1.department_id
FROM EMPLOYEES e1 JOIN EMPLOYEES e2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID;

SELECT * FROM VIEW_EMPLOYEES ve;

-- view_employees의 department_id를 이용해서 department_name이 나오는지 확인하기
SELECT ve.employee_id, ve.사원이름, ve.department_id, d.department_name
FROM view_employees ve JOIN DEPARTMENTS d 
ON ve.department_id = d.DEPARTMENT_ID;

-- pk 설정된 것 확인 쿼리문
SELECT cols.table_name, cols.column_name, cons.constraint_name
FROM all_constraints cons
JOIN all_cons_columns COLS
ON cons.constraint_name = cols.constraint_name
WHERE cons.constraint_type = 'P'
AND cols.table_name = 'EMPLOYEES';

SELECT * FROM all_cons_columns COLS;



-- fk 설정된 것 확인 쿼리문
SELECT cols.table_name, cols.column_name, cons.constraint_name
FROM all_constraints cons
JOIN all_cons_columns cols
ON cons.constraint_name = cols.constraint_name
WHERE cons.constraint_type = 'R'
AND cols.table_name = 'EMPLOYEES';

-- 계정 확인
select * from user_tab_privs_recd;

SELECT * FROM TBL_BOOK TB;
INSERT INTO TBL_BOOK tb
values(11,'COMMIT', 'TCL');

INSERT INTO TBL_BOOK tb 
VALUES(12,'ROLLBACK','TCL');


TRUNCATE TABLE TBL_RENTAL;

COMMIT;
ROLLBACK;

SELECT * FROM TBL_RENTAL tr;
DELETE FROM TBL_RENTAL
WHERE REN_ID = 4;

SELECT * FROM EMPLOYEES e ;

SELECT FIRST_NAME, SALARY, 
	CASE 
		WHEN SALARY >= 50000 THEN '높음'
		WHEN SALARY >= 30000 THEN '중간'
		ELSE '낮음'
	END
FROM EMPLOYEES e;
	
	END
	