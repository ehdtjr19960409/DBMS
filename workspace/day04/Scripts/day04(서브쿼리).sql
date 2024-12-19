-- 연관 서브쿼리
-- 최대 급여를 받는 직원 조회
	SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
	FROM EMPLOYEES
	WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES);
	
-- 비연관 서브쿼리
-- 각 직원의 급여가 부서별 평균 급여보다 높은 직원 조회
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES E
WHERE SALARY > (SELECT AVG(SALARY) 
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID = E.DEPARTMENT_ID)
ORDER BY E.DEPARTMENT_ID;


SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT EMPLOYEE_ID, SALARY, DEPARTMENT_ID
FROM EMPLOYEES e;

-- 단일행 서브쿼리(서브쿼리의 결과가 하나의 행만 반환)
-- 가장 오래된 입사일을 가진 직원의 사원번호, 이름, 입사일 조회
SELECT * FROM EMPLOYEES
ORDER BY HIRE_DATE;

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE) FROM EMPLOYEES);

SELECT MIN(HIRE_DATE) FROM EMPLOYEES;\


-- 다중행 서브쿼리(서브쿼리의 결과가 여러행을 반환)

-- 특정 부서에 속한 직원 조회
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN 
(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT');



-- EXISTS 연산자 : 서브쿼리의 결과가 존재하는지 여부를 확인할 때 사용
-- 부서별 평균 급여보다 높은 직원 수 
SELECT E.DEPARTMENT_ID, COUNT(*) 직원수
FROM EMPLOYEES E
WHERE EXISTS(
   SELECT 1
   FROM EMPLOYEES E2
   WHERE E2.DEPARTMENT_ID = E.DEPARTMENT_ID
      AND E.SALARY > (
         SELECT AVG(SALARY)
         FROM EMPLOYEES
         WHERE E.DEPARTMENT_ID = E2.DEPARTMENT_ID
      )
   )
GROUP BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, AVG(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; --4150

SELECT DEPARTMENT_ID, SALARY FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30;

SELECT * FROM EMPLOYEES;

-- 전체 평균 급여와 부서별 평균 급여 구하기

SELECT AVG(SALARY)
FROM EMPLOYEES; -- 1개 행

SELECT AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; --12개 행

-- 메인쿼리 결과 행의 수보다 서브쿼리 행의 수가 많으면 안된다
--SELECT AVG(SALARY), (SELECT * FROM EMPLOYEES)
--FROM EMPLOYEES;
-- 오류발생 : 서브쿼리의 행의 수가 메인쿼리보다 많음

-- 서브쿼리의 수가 메인 쿼리의 수보다 적어야함
SELECT DEPARTMENT_ID, AVG(SALARY), (SELECT AVG(SALARY) FROM EMPLOYEES)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;


-- 각 직원의 사원번호, 이름, 급여와 해당 부서의 평균 급여 조회
SELECT DEPARTMENT_ID , EMPLOYEE_ID, FIRST_NAME, SALARY,
	(SELECT AVG(SALARY) 
	FROM EMPLOYEES E2
	WHERE E2.DEPARTMENT_ID = E.DEPARTMENT_ID 
	)
	FROM EMPLOYEES E;
-- SELECT절 : 계산된 값 또는 추가정보를 열로 표시!!

-- FROM절 서브쿼리
-- 부서별 평균급여를 계산한 후, 평균 급여보다 높은 직원 조회하기
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, T.AVG_SALARY
FROM EMPLOYEES E 
   JOIN 
      (SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SALARY
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) T
ON E.DEPARTMENT_ID = T.DEPARTMENT_ID
WHERE E.SALARY > T.AVG_SALARY;

-- FROM 절 :  데이터 소스역할, 주로 집계 데이터를 연결할 때 사용!!

-- WHERE절 서브쿼리
-- 급여가 전체 평균 급여이상인 직원 조회
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT AVG(SALARY) FROM EMPLOYEES; --6,461.832...
-- WHERE절 : 필터 조건으로 사용하여 데이터를 제한


-- [실습] 평균 급여보다 낮은 사람들의 급여를 20%(*1.2)인상한 결과 테이블을 조회하라
-- EMPLOYEE_ID, FIRST_NAME, SALARY, 인상급여

-- 1) 평균급여
SELECT AVG(SALARY) FROM EMPLOYEES E;

-- 2) 전체 쿼리 생각
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY * 1.2
FROM EMPLOYEES;

--3) 평균 급여보다 낮은 사람들 쿼리
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY * 1.2
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY)FROM EMPLOYEES E);

-- ROWNUM
SELECT ROWNUM, E.* FROM EMPLOYEES E ;


SELECT ROWNUM, SALARY FROM EMPLOYEES E ;

SELECT ROWNUM, SALARY FROM EMPLOYEES E
ORDER BY SALARY DESC;


-- EMPLOYEES 테이블에서 SALARY를 내림차순으로 정렬한 후 ROWNUM을 붙여서 조회하기
SELECT ROWNUM, E.* FROM EMPLOYEES E
ORDER BY SALARY DESC;

SELECT ROWNUM, E2.*
FROM (SELECT * FROM EMPLOYEES E
	ORDER BY SALARY DESC
) E2;


-- 연봉 1위~5위까지 조회
SELECT ROWNUM, E2.*
FROM (SELECT * FROM EMPLOYEES E
	ORDER BY SALARY DESC
) E2
WHERE ROWNUM BETWEEN 1 AND 5;

-- 연봉 6위~10위까지 조회
SELECT ROWNUM, E2.*
FROM(SELECT ROWNUM AS RN, E.* 
		FROM (
			SELECT SALARY 
				FROM EMPLOYEES 
				ORDER BY SALARY DESC) E
				) E2
			WHERE RN BETWEEN 6 AND 10;
		
		
		
-- 내부쿼리1(가장안쪽) : EMPLOYEES 테이블에서 SALARY 기준 내림차순 정렬
SELECT SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;

-- 내부쿼리2 : ROWNUM 정렬된 급여 데이터에 순번(RN) 부여
SELECT ROWNUM AS RN, E.* 
		FROM (
			SELECT SALARY 
				FROM EMPLOYEES 
				ORDER BY SALARY DESC) E;
				
-- 메인쿼리
SELECT ROWNUM, E2.*
FROM (SELECT ROWNUM AS RN, E.* 
		FROM (
			SELECT SALARY 
				FROM EMPLOYEES 
				ORDER BY SALARY DESC) E)E2
WHERE RN BETWEEN 6 AND 10;