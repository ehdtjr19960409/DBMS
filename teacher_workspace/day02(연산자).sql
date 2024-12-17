-- 2번 : 연산자
-- 연산자 피연산자 자리에 어떤 타입의 값이 오는지
-- 연산자 어떻게 동작하는지
-- 연산의 결과가 어떤 타입의 값인지 아는 것이 중요하다!!!
-- 자료형 : 문자형(CHAR, VARCHAR2), 숫자형(NUMBER), 날짜(DATE, TIMESTAMP)
-- 1) 연결연산자
-- a || b : a와 b를 연결해준다
-- dual 테이블 : 다른 테이블을 참조할 필요 없이 값을 확인하고 싶을 때 사용할 수 있는 테이블(오라클에서 지원)

SELECT
	10,
	20,
	10 || 20
FROM
	dual;

SELECT
	'a',
	'b',
	'a' || 'b'
FROM
	dual;
-- employees 테이블에서 이름과 성을 붙여서 이름이라는 별칭으로 조회
SELECT
	first_name,
	last_name,
	first_name || ' ' || last_name 이름
FROM
	EMPLOYEES;
-- 날짜타입의 값 확인
SELECT
	hire_date || '안녕'
FROM
	EMPLOYEES;
-- [실습] 사원의 이름과 메일주소를 출력하기
-- 이 때 이름은 first_name과 last_name이 띄어쓰기로 이어져서 이름이라는 컬럼명으로 있고
-- 메일 주소는 사원메일주소@koreait.com으로 메일 주소라는 컬럼명으로 되어있다
SELECT
	first_name || ' ' || last_name 이름,
	email || '@koreait.com' "메일 주소"
FROM
	employees;
-- 2) 산술연산자
-- 숫자 타입 산술연산 결과 => 숫자타입
SELECT
	employee_id,
	employee_id + 10,
	employee_id - 10,
	employee_id * 10,
	employee_id / 2
FROM
	employees;
-- 날짜타입과 산술연산
-- 날짜와 숫자 => 결과 날짜 타입
SELECT
	hire_date,
	hire_date + 10,
	hire_date - 10
FROM
	employees;
-- 날짜와 날짜
SELECT
	sysdate
FROM
	dual;
-- 날짜 - 날짜 => 몇일이 지났는지 결과로 나온다 (숫자타입)
SELECT
	hire_date,
	sysdate,
	sysdate - hire_date
FROM
	employees;
-- 날짜 + 날짜 => 오류발생
--SELECT hire_date, sysdate, sysdate + hire_date
--FROM employees;
-- 날짜와 숫자의 연산에서 기본적으로 숫자는 일 수를 의미하기 때문에 시간, 분 단위로 연산하고 싶다면
-- 일(24h)로 환산해야한다
SELECT
	sysdate,
	sysdate - 0.5,
	sysdate + 0.5
	--	sysdate - 12/24 -- 12시간
	--  sysdate + 1/24	-- 1시간
	--  sysdate - 30/60/24 -- 30분	
FROM
	dual;

SELECT
	*
FROM
	EMPLOYEES;
-- 4) 관계연산자
-- 직원의 이름, 성, 급여를 조회한다
-- 급여가 10000 이상인 직원들 조회
SELECT
	first_name 이름,
	last_name 성,
	salary 급여
FROM
	employees
WHERE
	salary >= 10000
ORDER BY
	급여;
-- 직원의 이름, 성을 조회한다
-- 단, 이름이 Peter 인 직원만 골라서 조회한다
SELECT
	first_name,
	last_name
FROM
	employees
WHERE
	FIRST_NAME = 'Peter';
-- Peter는 문자타입이므로 반드시 ''로 감싸줘야하며 P를 소문자로 작성하면 안된다
-- 데이터의 대소문자는 정확하게 구분을 한다
-- 5) 논리연산자
-- AND, OR, NOT
-- 피연산자 자리에 조건이 온다, 여러개의 조건을 연결할 때 사용한다
-- employees 테이블에서 부서가 영업부서(80)이면서 급여가 10000이상인 직원들의
-- 이름, 성, 급여, 부서id를 급여 오름차순으로 조회하기
SELECT
	first_name 이름,
	last_name 성,
	salary 급여,
	department_id 부서id
FROM
	employees
WHERE
	department_id = 80
	AND salary >= 10000
ORDER BY
	급여;
-- 6) SQL연산자
-- BETWEEN a AND b : a 이상 b이하인 조건 => 범위 내에 포함되면 참
-- employees 테이블에서 salary가 10000 이상 12000이하인 직원의 
-- first_name, last_name, salary를 salary 오름차순으로 조회

SELECT
	first_name,
	last_name,
	salary 급여
FROM
	employees
WHERE
	salary BETWEEN 10000 AND 12000;
-- IN(a, b, c) : a이거나 b이거나 c인 조건 => a, b, c 중 하나라도 포함되면 참
-- 10000, 11000, 12000
SELECT
	first_name,
	last_name,
	salary
FROM
	employees
WHERE
	salary IN(10000, 11000, 12000);
-- LIKE : 문자 조건, 패턴을 만들 때 사용한다
-- % : ~아무거나  _ : 자리수
SELECT
	first_name
FROM
	employees
WHERE
	first_name LIKE '____e';

SELECT
	first_name
FROM
	employees
WHERE
	first_name LIKE '%e';
-- %e% : e를 포함하는 문자를 의미
-- %en% : en을 포함하는 문자를 의미
-- %e%n% : e와 n을 포함하는 문자를 의미
-- %e_n% : e와 n사이에 한글자 더 있는 문자를 의미
-- IS NULL / IS NOT NULL
-- NULL : 데이터가 없음을 나타내는 값
-- NULL은 연산하면 결과가 NULL이다

SELECT
	NULL + 10
FROM
	DUAL;
-- employees 테이블에서 commission_pct를 조회하기
SELECT
	first_name,
	last_name,
	commission_pct
FROM
	employees
WHERE
	commission_pct IS NULL;
--WHERE commission_pct = NULL; -- 아무런 결과가 나오지 않는다 NULL값을 확인할 때는 =(관계연산자)가 아닌 IS NULL로 확인한다

SELECT
	first_name,
	last_name,
	commission_pct
FROM
	employees
WHERE
	COMMISSION_PCT IS NOT NULL;
--WHERE commission_pct <> NULL;

SELECT
	100,
	NULL
FROM
	DUAL
WHERE
	NULL = NULL;
-- 직원의 이름, 봉급, 인상 봉급, 감축 봉급을 조회하기
-- 이름은 성과 함께 띄어쓰기로 연결되어있다
-- 인상 봉급은 기존 봉급의 10% 증가되었고(1.1)
-- 감축 봉급은 기존 봉급의 10% 감소되었다(0.9)
-- 결과를 기존 봉급 오름차순으로 정렬하여 조회한다

SELECT
	first_name || ' ' || last_name 이름,
	salary 봉급,
	salary * 1.1 "인상 봉급",
	salary * 0.9 "감축 봉급"
FROM
	employees
ORDER BY
	봉급;
