-- 테이블 생성(DDL)
CREATE TABLE TBL_MEMBER(
	MEMBER_ID NUMBER,
	MEMBER_NAME VARCHAR2(100),
	MEMBER_AGE NUMBER(3)
);

-- 데이터 추가 INSERT문 이용
INSERT INTO TBL_MEMBER
VALUES(1, '신동석',29);

INSERT INTO TBL_MEMBER
VALUES(2, '신짱구', 5);

INSERT INTO TBL_MEMBER
VALUES(3, '신짱아', 2);

INSERT INTO TBL_MEMBER(MEMBER_ID, MEMBER_NAME)
VALUES(4, '유리');


SELECT * FROM TBL_MEMBER;
--데이터 수정 UPDATE
UPDATE TBL_MEMBER
SET MEMBER_AGE = 5;

UPDATE TBL_MEMBER
SET MEMBER_AGE = 20
WHERE MEMBER_NAME = '신동석';

UPDATE TBL_MEMBER
SET MEMBER_AGE  =2
WHERE MEMBER_ID = 3;

-- 데이터 삭제 DELETE
DELETE FROM TBL_MEMBER
WHERE MEMBER_AGE = 5;

DELETE FROM TBL_MEMBER;

-- 학생 테이블 생성
-- CREATE TABLE 테이블명
CREATE TABLE TBL_STUDENT(
	-- 컬럼명 데이터타입 = 문자(VARCHAR2, CHAR) , 숫자(NUMBER), 날짜(DATE)
	STUDENT_NUMBER NUMBER,
	STUDENT_NAME VARCHAR(1000),
	STUDENT_MATH NUMBER,
	STUDENT_ENG NUMBER,
	STUDENT_KOR NUMBER,
	STUDENT_GRADE VARCHAR2(100)
);

 --DROP TABLE TBL_STUDENT; --TABLE 삭제하는 DML

SELECT * FROM TBL_STUDENT;

/* 학생 테이블에 데이터 추가
 * 학생번호 이름 수학 영어 국어
 * 1   김철수   90   90   90   
 * 2   홍길동   70   25   55
 * 3   이유리   89   91   77
 * 4   김웅이   48   100   100
 * 5   신짱구   50   10   NULL
 * */
INSERT INTO TBL_STUDENT(STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR) 
VALUES (1, '김철수', 90, 90, 90);

INSERT INTO TBL_STUDENT(STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
VALUES(2, '홍길동', 70,25,55);


INSERT INTO TBL_STUDENT(STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
VALUES(3, '이유리', 89,91,77);


INSERT INTO TBL_STUDENT(STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
VALUES(4, '김웅이', 48,100,100);


INSERT INTO TBL_STUDENT(STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
VALUES(5, '신짱구', 50, 10, NULL);


-- 전체 학생의 이름과 평균점수 조회하기(별칭도 추가)

SELECT STUDENT_NAME 이름, (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3  "평균 점수"
FROM TBL_STUDENT;


SELECT * FROM TBL_STUDENT;

SELECT STUDENT_NAME 이름, (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3  "평균 점수"
FROM TBL_STUDENT
WHERE STUDENT_NAME = '신짱구';

-- NVL(컬럼명, 기본값) : NULL값을 특징 값으로 변경
-- NVL은 기존 타입의 값이 있기 때문에 타입을 변경하게 되면 하나의 칼럼에 타입이 2개가 되므로 오류가 발생한다
SELECT STUDENT_NAME 이름, NVL(STUDENT_KOR, 0) AS 국어점수, NVL(STUDENT_GRADE, '미정') AS 학점
FROM TBL_STUDENT;

-- NVL2(컬럼명, 값1, 값2) : NULL 여부에 따라 NULL이 아니면 값1, NULL이면 값2
-- 하나의 컬럼에는 하나의 타입의 값만 들어갈 수 있다, 따라서 NULL인 값과 NULL이 아닌 값 모두 문자이므로 가능하다
SELECT STUDENT_NAME 이름, NVL2(STUDENT_KOR,'점수있음', '점수없음') 국어점수
/* SELECT STUDENT_NAME 이름, NVL2(STUDENT_KOR, 0, '점수없음') 국어점수 0은 정수이므로 문자로 저장할 수 없으므로 오류 발생
 * 단, ('점수있음', 0) 이면 숫자가 문자열로 저장 가능 -> 타입에 맞춰서 진행해야함
 */
FROM TBL_STUDENT;


-- NULLIF(컬럼명, 값1) : 특정값과 같으면 NULL로 변경, 아니라면 원래값을 유지
SELECT STUDENT_NAME 이름, NULLIF(STUDENT_KOR,100)
FROM TBL_STUDENT;


-- NULLIF(컬럼1, 컬럼2) : 두 컬럼의 값이 같으면 NULL로 변경, 값이 다르면 기존 값 출력
SELECT STUDENT_NAME 이름, NULLIF(STUDENT_MATH, STUDENT_ENG)
FROM TBL_STUDENT;

-- COALESCE(값1, 값2, 값3) : NULL이 아닌 첫번째 값을 반환
SELECT STUDENT_NAME 이름, COALESCE(STUDENT_KOR , STUDENT_ENG , STUDENT_MATH , 0) AS 첫번째점수
FROM TBL_STUDENT;



SELECT * FROM TBL_STUDENT;

-- 수정 UPDATE
--UPDATE 테이블명
--SET 컬럼명 = 값
--WHERE 행을 찾을 조건

UPDATE TBL_STUDENT 
SET STUDENT_KOR = NVL(STUDENT_KOR, 0);

SELECT * FROM TBL_STUDENT;

-- 전첵 학생의 이름과 평균점수 조회하기(별칭 추가)
SELECT STUDENT_NAME 이름, (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3  "평균 점수"
FROM TBL_STUDENT;

SELECT * FROM TBL_STUDENT;

-- 학생의 평균점수를 구하고 학점 수정하기
-- A : 90점이상
-- B : 80점 이상 90점 미만 -> Between 이상 이하가 아니므로 쓰면 안됀다
-- C : 50점 이상 80점 미만
-- F : 50점미만

-- ROUND(값, 자리수) : ROUND 함수는 소수점을 반올림하여 특정 소수점까지만 표현할 수 있다
-- ROUND(평균점수 구하는 공식 >= 90)

UPDATE TBL_STUDENT
SET STUDENT_GRADE  = 'A'
WHERE (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 >= 90; 

SELECT * FROM TBL_STUDENT;

UPDATE TBL_STUDENT
SET STUDENT_GRADE  = 'B'
WHERE (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 >= 80 
AND (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 < 90;

UPDATE TBL_STUDENT
SET STUDENT_GRADE  = 'C'
WHERE (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 >= 50 
AND (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 < 80;


UPDATE TBL_STUDENT
SET STUDENT_GRADE  = 'F'
WHERE  (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 < 50;

SELECT * FROM TBL_STUDENT;

-- Q1.학생의 수학, 영어, 국어 점수 중 한 과목이라도 50 미만이 아니고
-- 학점이 B이상인 학생만 학생번호, 이름, 학점으로 별칭 붙여서 출력하기(SELECT 활용)
SELECT STUDENT_NUMBER 학생번호, STUDENT_NAME 이름, STUDENT_GRADE 학점
FROM TBL_STUDENT
WHERE NOT((STUDENT_MATH < 50)OR(STUDENT_ENG < 50)OR(STUDENT_KOR < 50)) AND STUDENT_GRADE = 'B'; 

SELECT * FROM TBL_STUDENT;

-- Q2. 학생의 수학, 영어, 국어 점수 중 한 과목이라도 30점 미만이면 DB에서 삭제하기(DELETE활용)
DELETE FROM TBL_STUDENT 
WHERE ((STUDENT_MATH < 30) OR (STUDENT_ENG < 30 ) OR (STUDENT_KOR < 30));
SELECT * FROM TBL_STUDENT;

SELECT * FROM EMPLOYEES;

--1번
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' ||LAST_NAME 이름, EMAIL, PHONE_NUMBER, HIRE_DATE , JOB_ID ,SALARY , COMMISSION_PCT , MANAGER_ID, DEPARTMENT_ID 
FROM EMPLOYEES;

--2번
SELECT FIRST_NAME , SALARY 
FROM EMPLOYEES;

--3번
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 5000;

--4번
SELECT SYSDATE, SYSDATE +10
FROM dual;

--5번
SELECT * FROM EMPLOYEES;

SELECT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

SELECT * FROM EMPLOYEES;
-- 6번
SELECT * 
FROM EMPLOYEES
WHERE LAST_NAME = 'King';

SELECT * FROM EMPLOYEES;

--7번 
SELECT *
FROM EMPLOYEES
WHERE salary != 0;
-- where salary is not null;
-- salary != null 시 unknown으로 됌

SELECT * FROM EMPLOYEES;

-- 8번
SELECT * FROM EMPLOYEES;

SELECT DISTINCT JOB_ID 
FROM EMPLOYEES;

--9번
SELECT * FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES
WHERE SALARY BETWEEN 3000 AND 7000;
-- between 쓸 때 and 기억

--10번
SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '____e';
-- 다른 방법은? 
-- %는 어떤 문자를 포함한 모든 문자이다 즉, _패턴하고는 반대성향


--11번
SELECT * FROM EMPLOYEES;

SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'SA_REP';
-- 주의사항 구문에 명시된 명제를 제대로 확인할것 AND로 착각

--12번
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';

--LIKE 연산을 써서 %을 활용하는 것은 인지하고 있었으나 ''감싸줘야하는 부분은 미인지

--13번 
SELECT * FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES e 
WHERE SALARY >= 10000 AND DEPARTMENT_ID = 90;


--14번
SELECT * FROM EMPLOYEES;

SELECT *
FROM EMPLOYEES
WHERE SALARY <= 5000 or DEPARTMENT_ID = 30;

--15번
SELECT * FROM EMPLOYEES;

SELECT *
FROM EMPLOYEES
WHERE LAST_NAME LIKE '_a%';


--16번
SELECT * FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES
ORDER BY SALARY DESC;

--17번
SELECT * FROM EMPLOYEES;

SELECT SALARY *0.1 BONUS
FROM EMPLOYEES;

--18번
SELECT * FROM EMPLOYEES;

SELECT COMMISSION_PCT, SALARY
FROM EMPLOYEES
WHERE SALARY >= 6000 
ORDER BY COMMISSION_PCT, SALARY DESC;
/* 
 * ORDER BY 절안에서는 , 이용하여 컬럼명을 사용 가능
 * ORDER BY 절안에서 어떤 컬럼을 중심으로 시작하냐에 따라서, 어트리뷰트가 먼저 붙는다
 * SELECT 절에서는 출력되게하는 어트리뷰트가 나오지만, 이와 상관없이 ORDER BY 다른 컬럼을 쓰게 된다면 적용 된다
 */

--19번
SELECT * FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%' AND SALARY >=10000;
--20번
SELECT * FROM EMPLOYEES;

SELECT HIRE_DATE + 365 "입사 1년 후"
FROM EMPLOYEES;






