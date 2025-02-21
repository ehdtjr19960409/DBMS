-- 계정명 : test01
-- 비밀번호 : 1234
-- 권한 create session, create table, create view, resource

-- 계정 만들고 a1~a4 테이블 등록 후 문제 풀기
SELECT * FROM JOBS ;
SELECT * FROM EMPLOYEES e ;
/* 1. JOBS 테이블에서 JOB_ID로 직원들의 JOB_TITLE, EMAIL, 성, 이름 조회 */


SELECT J.JOB_TITLE, EMAIL, LAST_NAME, FIRST_NAME
FROM JOBS J
JOIN(SELECT EMAIL, LAST_NAME, FIRST_NAME
	FROM EMPLOYEES)
	ON J.JOB_ID = JOB_ID;

----
SELECT count(*) FROM jobs; -- 19행
SELECT count(*) FROM EMPLOYEES e; -- 107행

SELECT j.job_title, email, last_name, first_name 
FROM JOBS j JOIN EMPLOYEES e 
ON j.JOB_ID = e.JOB_ID;

/* 2. EMPLOYEES 테이블에서 HIREDATE가 2003~2004년까지인 사원의 정보와 부서명 검색 */
	SELECT * FROM EMPLOYEES e ;

	SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, DEPARTMENT_ID
	FROM EMPLOYEES e 
	WHERE HIRE_DATE BETWEEN '2003-01-01' AND '2004-12-31';
----
SELECT count(*) FROM EMPLOYEES e; -- 107행
SELECT count(*) FROM DEPARTMENTS d; -- 27행

SELECT e.FIRST_name || ' ' || e.last_name 이름, e.hire_date 입사일, d.department_name 부서명
FROM DEPARTMENTS d JOIN EMPLOYEES e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID AND 
e.HIRE_DATE BETWEEN '2000-01-01' AND '2001-12-31';


/* 3. EMP 테이블에서 ENAME에 L이 있는 사원들의 DNAME과 LOC 검색 */
SELECT * FROM emp;
SELECT * FROM dept;

SELECT DNAME, LOC, ENAME
FROM DEPT D
JOIN (SELECT ENAME FROM EMP WHERE ENAME LIKE '%L%')
	ON D.DEPTNO = DEPTNO;
---
SELECT e.ename, d.dname, d.loc
FROM dept d JOIN emp E
ON e.DEPTNO = d.DEPTNO AND e.ename LIKE '%L%';


/* 4. SCHEDULE 테이블에서 경기 일정이 20120501 ~ 20120502 사이에 있는 경기장 전체 정보 조회 */
SELECT *FROM SCHEDULE s;

SELECT * FROM SCHEDULE s 
WHERE SCHE_DATE IN ('20120501', '20120502');
---
SELECT s.sche_date, s.stadium_id, st.hometeam_id, st.seat_count,st.address, st.ddd,st.tel
FROM STADIUM ST JOIN SCHEDULE S
ON S.STADIUM_ID = ST.STADIUM_ID  
AND S.SCHE_DATE >= '20120501' AND S.SCHE_DATE <= '20120502';
-- ON.SALARY = (D.DEPARTMENT_ID > 10); ON절에서 테이블간 적절한 관계를 만들지 못하는 경우는 사용불가



/* 5. 축구 선수들 중에서 각 팀 별로/ 키가 가장 큰 선수들의 전체 정보 조회 */
/* 위 문제를 JOIN없이 풀기
 * (A,B) IN (C, D) : A = C AND B = D */
SELECT * FROM PLAYER;

SELECT * FROM PLAYER P
WHERE (P.TEAM_ID, HEIGHT) IN 
(SELECT TEAM_ID, MAX(HEIGHT) FROM PLAYER p2 GROUP BY TEAM_ID);


/* 6. EMP 테이블의 SAL을 이용, SALGRAED 테이블을 참고하여 모든 사원의 정보를 GRADE를 포함하여 조회 */
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

SELECT E.*, S.GRADE
FROM EMP E
FULL OUTER JOIN SALGRADE s
ON E.DEPTNO = DEPTNO;

---
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

-- JOIN 테이블 합치기
-- 등급별 최저 LOSAL, 최고 HISAL 사이에 있는 SAL을 조건으로 건다
-- SLA >= LOSAL AND SAL <= HISAL
SELECT * FROM EMP E JOIN SALGRADE s 
ON E.SAL >= S.LOSAL AND E.SAL <= S.HISAL;

SELECT * 
FROM EMP e 
JOIN SALGRADE s 
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;




/* 7. EMP 테이블에서 각 사원의 매니저 이름 조회 */
SELECT * FROM EMP;

SELECT ENAME, DEPTNO 
FROM EMP e 
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP);

---
--- EMP 테이블을 확인한다
--- MGR이 매니저 번호인 것을 확인한다
--- 셀프조인 사용한다

SELECT * FROM EMP;

SELECT E1.EMPNO 사원번호, E1.ENAME 사원이름, E2.ENAME 매니저이름, E1.MGR 매니저번호
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;


/* 8. 축구 선수들 중에서 각 팀 별로 키가 가장 큰 선수들의 전체 정보 조회 */
-- 팀별로 그룹화 후 팀의 가장 큰 키를 찾기
SELECT TEAM_ID, MAX(HEIGHT)
FROM PLAYER p 
GROUP BY TEAM_ID;

-- HEIGHT, TEAM_ID가 일치하는 조건으로 PLAYER 테이블과 JOIN
SELECT * 
FROM (SELECT TEAM_ID, MAX(HEIGHT) HEIGHT 
FROM PLAYER p 
GROUP BY TEAM_ID) P1 JOIN PLAYER P2
ON P1.TEAM_ID = P2.TEAM_ID AND P1.HEIGHT = P2.HEIGHT
ORDER BY P1.TEAM_ID;

