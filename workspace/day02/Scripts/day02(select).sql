--1번 select문

-- SELECT : 테이블에서 데이터를 조회할 때 사용하는 명령어
-- hr 계정 내에 존재하는 employees 테이블
-- 107행, 11개의 컬럼(열)으로 이루어져있다
-- 107명의 직원 데이터를 저장해 놓은 연습용 테이블

-- SELECT 컬러명 FROM 테이블명;
-- 해당 테이블에서 특정 컬럼을 선택해서 조회하겠다는 의미


SELECT FIRST_NAME FROM HR.EMPLOYEES ;
SELECT FIRST_NAME FROM EMPLOYEES ;

-- HR 계정을 작성하는 이유는 여러 계정에 같은 이름의 테이블이름이 존재할 수 있기 때문이다
-- 지금 로그인한 계정의 테이블의 우선순위가 높기 때문에 일반적으로 계정명을 생략이 가능하다

-- *: 전체를 의미
SELECT * FROM EMPLOYEES;
--  아래 두개의 결과는 다르다(select 뒤에 작성된 컬럼명 대로 Result 테이블에 표시된다)
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES;
SELECT LAST_NAME, FIRST_NAME FROM EMPLOYEES;


-- 사원 이름(first_name) 성(last_name), 급여(Salary)를 조회
SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES;

-- 정렬해서 조회하기
-- ODER BY 절
-- 사원의 이름, 성, 급여를 낮은 순서부터 조회

SELECT FIRST_NAME, LAST_NAME, SALARY --2) FIRST_NAME, LAST_NAME, SALARY 컬럼을 조회하는데 
FROM EMPLOYEES -- 1) EMPLOYEES 테이블에서 
ORDER BY SALARY ASC; --3)SALARY로 오름차순으로 정렬
-- ASC : 오름차순(ascending) 앞글자 3글자만 따서 ASC로 사용한다

-- DESC : 내림차순(descending) 앞글자 4글자를 따서 DESC로 사용한다
SELECT FIRST_name, LAST_NAME, SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;

SELECT * FROM EMPLOYEES;

-- 문자의 정렬 (FIRST_NAME) DESC : Z부터 A까지 순으로 정렬
SELECT first_name 
FROM employees
ORDER BY first_name desc;


-- 날짜의 정렬 (HIRE_DATE) ASC : 예전날짜부터 최신날짜로 정렬
SELECT hire_date
FROM EMPLOYEES
ORDER BY hire_date ASC;

-- ORDER BY 절에서 오름차순 ASC나 DESC를 생략하게 되면 오름차순으로 정렬된다

SELECT * FROM employees;

SELECT salary
FROM employees
ORDER BY salary;

-- ORDER BY절의 컬러명은 조회하는 컬럼명과 반드시 일치하지 않아도 가능하다 (해당 테이블에 있는 컬럼이라면)
-- 2개의 정렬기준도 가능하다
-- 첫번째 작성한 컬럼의 값을 기준으로 잡아 정렬하고 해당 컬럼의 값이 동일하다면 2차적으로 그 다음 컬럼값을 기준으로 정렬한다
SELECT first_name, salary
FROM EMPLOYEES
ORDER BY FIRST_NAME ASC, salary ASC;


-- 사원 테이블에서 직급(job_id)을 조회하기
SELECT job_id 
FROM EMPLOYEES;

-- 직급의 종류를 확인하기 위해 중복행을 제거(distinct)
-- distinct : 해당 컬럼에서 중복되는 값을 제외
SELECT DISTINCT job_id 
FROM EMPLOYEES;


-- 컬럼을 여러개 넣으면 distinct는 어떻게 작동할까?
-- 여러 컬럼을 동시에 작성할 경우 두개의 컬럼이 모두 중복되는 경우에만 중복처리한다(중복을 제거한다)

SELECT DISTINCT job_id, hire_date
FROM employees;

-- 별칭 붙여 조회하기(AS 키워드 사용)
SELECT first_name AS "이름", last_name AS "성", salary AS "급여", employee_id AS "사원번호"
FROM employees;

-- AS 키워드 생략 가능
-- 해당 컬럼명 띄고 별칭으로 작성 원칙
-- ""생략 가능
-- 별칭에 띄어쓰기가 있으면 "" 생략 불가
SELECT first_name 이름, last_name 성, salary 급여, employee_id "사원 번호"
FROM employees;

-- 사원의 이름(FIRST_NAME) , 성(LAST_NAME), 봉급을 조회하는데 봉급 내림차순으로 별치사용하여 조회
-- 쿼리문 실행순서 FROM -> SELECT -> ORDER BY
SELECT FIRST_NAME 이름, LAST_NAME 성, SALARY 봉급  -- 검색 컬러명 대상 이름, 성, 봉금
FROM EMPLOYEES									-- 해당 릴레이션
ORDER BY 봉급 DESC;							-- 정렬인데 내림차순(DESC명시)
											-- ★정렬대상이 별칭을 사용했다면 별칭으로 사용 가능★



SELECT * FROM Employees;














