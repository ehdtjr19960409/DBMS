-- 1. FK 관계 맺은 테이블 수정/삭제

CREATE TABLE TBL_PHONE(
	PHONE_NUMBER VARCHAR2(100),
	PHONE_COLOR VARCHAR2(100),
	PHONE_SIZE NUMBER,
	PHONE_PRICE NUMBER,
	PHONE_SALE NUMBER,
	PHONE_PRODUCTION_DATE DATE,
	CONSTRAINT PK_PHONE PRIMARY KEY(PHONE_NUMBER)
);

CREATE TABLE TBL_CASE(
	CASE_NUMBER VARCHAR2(100),
	CASE_COLOR VARCHAR2(100),
	CASE_PRICE NUMBER, 
	PHONE_NUMBER VARCHAR2(100),
	CONSTRAINT PK_CASE PRIMARY KEY(CASE_NUMBER),
	CONSTRAINT FK_CASE FOREIGN KEY(PHONE_NUMBER) REFERENCES TBL_PHONE(PHONE_NUMBER)
);

SELECT * FROM TBL_PHONE;
SELECT * FROM TBL_CASE;

-- 관계를 맺은 테이블들의 DML
-- 자식테이블은 부모테이블의 값을 참조하기 때문에 항상 부모테이블에 DATA가 먼저 들어가야한다
-- PHONE 테이블이 부모이므로 PHONE 에 먼저 데이터를 넣어야한다

INSERT INTO TBL_PHONE
VALUES('a1', 'white', 1, 100, 0, '2024-12-01');
-- DATE 타입의 컬럼에 문자타입의 값을 'YYYY-MM-DD' 형태로 넣으면 자동으로 DATE타입으로 변환되어 들어간다

INSERT INTO TBL_PHONE 
VALUES('a2', 'black', 1, 120, 10, sysdate - 10);
-- 현재 날짜를 기준으로 10일 전 현재시간까지 포함해서 들어간다

INSERT INTO TBL_PHONE
VALUES('a3', 'black', 1, 130, 20, TO_DATE('2024-05-05'));
-- TO_DATE()함수를 이용하여 문자열을 직접 DATE 타입으로 바꿀 수 있다

INSERT INTO TBL_CASE
--VALUES('A', 'WHITE', 5, 'A1'); -- PHONE 테이블에는 A1 값이 없기 때문에(데이터 값은 대소문자 구분) 오류발생
--VALUES('A', 'WHITE', 5, 'a1');
values('B', 'BLACK', 2, 'a2');


SELECT * FROM TBL_PHONE;
SELECT * FROM TBL_CASE;

-- 부모테이블의 값을 수정하기
UPDATE TBL_PHONE 
SET PHONE_COLOR = 'blue'
WHERE PHONE_NUMBER = 'a1';

--부모테이블의 PK값 수정
-- 자식테이블에서 참조하고 있는 값이 아니면 수정 가능하지만 참조하고 있는 값인 경우 수정이 불가능하다(오류발생)
UPDATE TBL_PHONE
SET PHONE_NUMBER = 'a03'
WHERE PHONE_NUMBER ='a3';

-- 부모의 값을 변경할 때 자식에서 참조중인 값을 변경하려고 하면 오류가 발생하므로
-- 자식 테이블을 먼저 수정하여 해당 값을 참조하지 않도록 수정해야한다
-- 1) 자식테이블에서 참조중인 값을 다른 값으로 변경한다
UPDATE TBL_CASE 
SET PHONE_NUMBER = 'a03'
WHERE CASE_NUMBER = 'A';

UPDATE TBL_PHONE 
SET PHONE_NUMBER = 'a01'
WHERE PHONE_NUMBER ='a1';

UPDATE TBL_CASE 
SET PHONE_NUMBER ='a01'
WHERE CASE_NUMBER = 'A';

SELECT * FROM TBL_PHONE;
SELECT * FROM TBL_CASE;

-- 2) 자식테이블에서 참조중인 값을 NULL로 변경한다(정말 급한게 아니라면 비추천)
UPDATE TBL_CASE 
SET PHONE_NUMBER = NULL
WHERE CASE_NUMBER = 'B';

UPDATE TBL_PHONE 
SET PHONE_NUMBER = 'a02'
WHERE PHONE_NUMBER = 'a2';

UPDATE TBL_CASE 
SET PHONE_NUMBER = 'a02'
WHERE CASE_NUMBER = 'B';

SELECT * FROM TBL_PHONE;

SELECT * FROM TBL_CASE;

-- 부모테이블에서 데이터 삭제하기
-- 자식테이블에서 참조중인 값들을 먼저 처리해야한다
DELETE FROM TBL_PHONE
WHERE PHONE_NUMBER = 'a02'; --자식테이블에서 참조중인 값이라 삭제 불가능
-- 1) 자식 테이블의 값을 먼저 삭제 후 부모 테이블의 값을 삭제한다(참조중인 행 자체를 삭제)
DELETE FROM TBL_CASE 
WHERE PHONE_NUMBER = 'a02';

DELETE FROM TBL_PHONE 
WHERE PHONE_NUMBER = 'a02';

-- 2) 자식 테이블에서 참조중인 값을 수정 후 부모 테이블의 값을 삭제한다
UPDATE TBL_CASE
SET PHONE_NUMBER = NULL
WHERE CASE_NUMBER = 'A';

DELETE FROM TBL_PHONE
WHERE PHONE_NUMBER = 'a01';

SELECT * FROM TBL_PHONE;
SELECT * FROM TBL_CASE;

UPDATE TBL_CASE
SET PHONE_NUMBER = 'a03'
WHERE CASE_NUMBER = 'A';









