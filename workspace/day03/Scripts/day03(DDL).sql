-- 2. DDL

CREATE TABLE TBL_USER(
	USER_NAME VARCHAR2(100),
	USER_AGE NUMBER
);


SELECT  * FROM TBL_USER;

-- 테이블명 수정
-- ALTER TABLE 테이블명 RENAME TO 새로운 테이블명;
ALTER TABLE  RENATBL_USERME TO TBL_MY_USER;

SELCT * FROM TBL_USER;
SELECT * FROM TBL_MY_USER;


-- 컬럼명 수정
-- ALTER TABLE 테이블명 RENAME COLOMN 기존컬럼명 TO 새로운컬럼명;
ALTER  TABLE TBL_MY_USER RENAME COLUMN USER_NAME TO USER_NICKNAME;


-- 컬럼 타입 수정
-- ALTER TABLE 테이블명 MODIFY(컬럼명 자료형(용량));
ALTER TABLE TBL_MY_USER MODIFY(USER_NICKNAME VARCHAR2(500));

--컬럼 추가
-- ALTER TABLE 테이블명 ADD(컬럼명 자료형(용량));
ALTER  TABLE TBL_MY_USER ADD(USER_GENDER CHAR(1));
ALTER TABLE TBL_MY_USER ADD (USER_HOBBY VARCHAR2(100));

-- 데이터 삽입 INSERT -> DML
INSERT INTO TBL_MY_USER
VALUES('짱구', 5, 'M', '액션가면보기');
INSERT INTO TBL_MY_USER
VALUES ('철수', 5, '공부하기');



-- 컬럼 삭제
ALTER TABLE TBL_MY_USER DROP COLUMN USER_GENDER;

SELECT * FROM TBL_MY_USER;

--TRUNCATE
TRUNCATE TABLE TBL_MY_USER;

SELECT * FROM TBL_MY_USER;

-- DELETE -> DML
INSERT INTO TBL_MY_USER
VALUES ('철수', 5, '공부하기');

DELETE FROM TBL_MY_USER ;

-- 테이블 삭제 
-- DROP TABLE 테이블명;
DROP TABLE TBL_MY_USER ;

DROP TABLE TBL_MEMBER;
DROP TABLE TBL_STUDENT;

-- [실습] 자동차 테이블 생성 TBL_CAR
-- 자동차 번호 NUMBER 숫자
-- 자동차 이름 NAME 문자(1000)
-- 자동차 브랜드 BRAND 문자(1000)
-- 출시 날짜 RELEASEDATE 날짜
-- 색상 COLOR 문자(1000)
-- 가격 PRICE 숫자


CREATE TABLE TBL_CAR(
	CAR_NUMBER NUMBER,
	CAR_NAME VARCHAR2(1000),
	CAR_BRAND VARCHAR2(1000),
	CAR_RELEASEDATE DATE,
	CAR_COLOR VARCHAR2(1000),
	CAR_PRICE NUMBER
);

SELECT * FROM TBL_CAR;

-- 제약조건 추가 (기본키 수정)
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건이름(PK_테이블명) PRIAMRY KEY(컬럼명);
ALTER TABLE TBL_CAR ADD CONSTRAINT PK_CAR PRIMARY KEY(CAR_NUMBER);
--ALTER TABLE TBL_CAR : TBL_CAR 테이블을 수정하겠다
--ADD : 추가하다
--CONSTRAINT : 제약조건
--PK_CAR PRIMARY KEY(CAR_NUMBER) : PK_CAR 이름으로 PRIMARY KEY라는(PK) 제약조건을 CAR_NUMBER 컬럼에 


-- 제약조건 삭제
ALTER TABLE TBL_CAR DROP CONSTRAINT PK_CAR;

-- 테이블 삭제
DROP TABLE TBL_CAR;


CREATE TABLE TBL_CAR(
	CAR_NUMBER NUMBER CONSTRAINT PK_CAR PRIMARY KEY,
	CAR_NAME VARCHAR2(1000),
	CAR_BRAND VARCHAR2(1000),
	CAR_RELEASEDATE DATE,
	CAR_COLOR VARCHAR2(1000),
	CAR_PRICE NUMBER
);

SELECT * FROM TBL_CAR;


-- 동물 테이블 TBL_ANIMAL
-- 고유번호 NUMBER
-- 종류 KIND
-- 나이 AGE
-- 먹이 FEED

CREATE TABLE TBL_ANIMAL(
	ANIAML_NUMBER NUMBER CONSTRAINT PK_ANIMAL PRIMARY KEY,
	ANIMAL_KIND VARCHAR2(100),
	ANIMAL_AGE NUMBER,
	ANIMAL_FEED VARCHAR2(100)
);

SELECT * FROM TBL_ANIMAL;

-- 1. 테이블 조회 후 TBL_ANIMAL 테이블의 제약조건 및 관계도 확인
-- 2. 제약조건 추가 테이블 생성 후 추가(PK)
-- 3. 컬럼 추가 성별(GENDER 문자(1))
-- 4. 컬럼 이름 수정(고유번호) NUMBER -> ID로 변경
-- 5. 컬럼 삭제(먹이)
-- 6. 컬럼 수정(종류컬럼을 자료형 NUMBER로 설정)

-- 2. 제약조건 추가 테이블 생성 후 추가(PK)
ALTER TABLE TBL_ANIMAL
ADD CONSTRAINT PK_TBL_ANIMAL PRIMARY KEY(ANIMAL_NUMBER);

-- 3.
ALTER TABLE TBL_ANIMAL ADD (GENDER CHAR(1));
SELECT * FROM TBL_ANIMAL;
-- 4.
ALTER TABLE TBL_ANIMAL RENAME COLUMN ANIAML_NUMBER TO ANIMAL_ID;
SELECT * FROM TBL_ANIMAL;
--5
ALTER TABLE TBL_ANIMAL DROP COLUMN ANIMAL_FEED;
SELECT * FROM TBL_ANIMAL;

--6.
ALTER TABLE TBL_ANIMAL MODIFY(ANIMAL_KIND NUMBER);
SELECT * FROM TBL_ANIMAL;

-- RENAME CONSTRAINT는 오라클에서 지원하지 않는다 / PK는 모든 테이블에서 1개
--ALTER TABLE TBL_ANIMAL 
--RENAME CONSTRAINT PK_ANIMAL PRIMARY KEY(ANIMAL_ID);

-- ANIMAL 테이블에 데이터추가 -> DML, INSERT
INSERT INTO TBL_ANIMAL
VALUES(1, 1, 5, 'F');

-- ANIMAL_ID가 PK라서 NULL을 허용하지 않음
--INSERT INTO TBL_ANIMAL
--VALUES(1);

-- ANIMAL_ID가 PK라서 중복을 허용하지 않음
--INSERT INTO TBL_ANIMAL
--VALUES(1,2,3,'M');
SELECT * FROM TBL_ANIMAL;

DROP TABLE TBL_ANIMAL;
DROP TABLE TBL_CAR;

-- FK설정
-- 학교 테이블
CREATE TABLE TBL_SCHOOL(
	SCHOOL_NUMBER NUMBER CONSTRAINT PK_SCHOOL PRIMARY KEY,
	SCHOOL_NAME VARCHAR2(1000)
);

SELECT * FROM TBL_SCHOOL;

-- 학생 테이블
CREATE TABLE TBL_STUDENT(
	STUDENT_NUMBER NUMBER,
	STUDENT_NAME VARCHAR2(1000),
	STUDENT_AGE NUMBER,
-- 외래키 참조하는 방법 // 0900 ERROR 한줄 비어도 발생
	SCHOOL_NUMBER NUMBER,
	CONSTRAINT PK_STUDENT PRIMARY KEY(STUDENT_NUMBER),
	CONSTRAINT FK_STUDENT FOREIGN KEY(SCHOOL_NUMBER) REFERENCES TBL_SCHOOL(SCHOOL_NUMBER));

DROP TABLE TBL_STUDENT ;

SELECT * FROM TBL_STUDENT;

SELECT * FROM TBL_SCHOOL;

-- 상위 테이블의 값부터 채워준다
INSERT INTO TBL_SCHOOL 
VALUES (1, 'DBMS 고등학교');

INSERT INTO TBL_SCHOOL
VALUES (2, 'JAVA 고등학교');

INSERT INTO TBL_SCHOOL
VALUES (3, 'PYTHON 고등학교');


--하위테이블의 값을 채워준다
INSERT INTO TBL_STUDENT
--VALUES(1,'김철수',17, 1);
--VALUES(2,'신유리',17, 1);
--VALUES(3,'신짱구',18, 2);
VALUES(4,'최영',19, 3);
--VALUES(1, '김철수', 17, 5); 
-- 오류발생! FK인 SCHOOL_NUMBER에 상위테이블에 존재하지 않는 값을 저장하려하면 오류발생


-- 제약조건 UK(UNIQUE KEY) : 고유한값이지만 NULL도 허용한다
-- 학생 테이블 STU
CREATE TABLE TBL_STU(
   STU_NUMBER NUMBER,
   STU_NAME VARCHAR2(1000),
   STU_MAJOR VARCHAR2(100),
   STU_ID NUMBER,
   STU_GENDER CHAR(1) DEFAULT 'M' NOT NULL CONSTRAINT CHECK_GEN CHECK(STU_GENDER = 'M' OR STU_GENDER='W'),
   CONSTRAINT PK_STU PRIMARY KEY(STU_NUMBER),
   CONSTRAINT UK_STU UNIQUE(STU_ID)
);


DROP TABLE TBL_STU;
SELECT * FROM TBL_STU;


--STU_GENDER CHAR(1) DEFAULT 'M' NOT NULL CHECK(STU_GENDER = 'M' OR STU_GENDER = 'F')
-- DEFAULT 'M' : 데이터가 들어오지 않으면 'M'이 기본값으로 들어가게 설정한다
-- NOT NULL : 디폴트값을 F러 설정했으니 NULL값을 강제로 넣는 것을 막기위해 사용하는 제약조건
-- CHECK(STU_GENDER = 'M' OR STU_GENDER = 'F')의 컬럼 값은 M또는 F만 들어오도록 하는 제약조건


INSERT INTO TBL_STU ts (STU_NUMBER, STU_NAME, STU_MAJOR, STU_ID)
VALUES(1, '짱구', NULL, '1111');
INSERT INTO TBL_STU 
--VALUES (2, '철수', '컴공', '222', 'M');
VALUES (3, '유리', '컴공', 333, 'W');

-- 조합키
-- PK를 2개의 컬럼으로 조합하여 설정한 것을 의미

CREATE TABLE TBL_FLOWER(
	FLOWER_NAME VARCHAR2(1000),
	FLOWER_COLOR VARCHAR2(1000),
	FLOWER_PRICE NUMBER,
	CONSTRAINT PK_FLOWER PRIMARY KEY (FLOWER_NAME, FLOWER_COLOR)
);

INSERT INTO TBL_FLOWER
VALUES('튤립','노랑',9000);

INSERT INTO TBL_FLOWER
VALUES('튤립','빨강',9000);

INSERT INTO TBL_FLOWER
VALUES('튤립','파랑',9000);



INSERT INTO TBL_FLOWER
VALUES('해바라기','노랑',9000);

INSERT INTO TBL_FLOWER
VALUES('해바라기','빨강',9000);

INSERT INTO TBL_FLOWER
VALUES('해바라기','파랑',9000);

SELECT * FROM TBL_FLOWER;



CREATE TABLE TBL_USER(
	USER_NUMBER NUMBER,
	USER_NAME VARCHAR2(10),
	USER_AGE NUMBER,
	USER_PHONE_NUMBER NUMBER,
	USER_ADDRESS VARCHAR2(100),
	CONSTRAINT PK_USER PRIMARY KEY(USER_NUMBER),
	CONSTRAINT UK_USER UNIQUE(USER_PHONE_NUMBER, USER_ADDRESS)
);


CREATE TABLE TBL_BOOK(
	BOOK_NUMBER NUMBER,
	BOOK_TITTLE NUMBER,
	BOOK_TYPE VARCHAR2(100),
	USER_NUMBER NUMBER,
	CONSTRAINT PK_BOOK PRIMARY KEY(BOOK_NUMBER),
	CONSTRAINT FK_BOOK FOREIGN KEY(USER_NUMBER) REFERENCES TBL_USER(USER_NUMBER)
);


CREATE TABLE TBL_TYPE(
	TYPE_HUMANITIES VARCHAR2(100),
	TYPE_IT VARCHAR2(100),
	TYPE_REASONING VARCHAR2(100),
	BOOK_NUMBER NUMBER,
	CONSTRAINT FK_TYPE FOREIGN KEY(BOOK_NUMBER) REFERENCES TBL_BOOK(BOOK_NUMBER)
);

ALTER TABLE TBL_BOOK MODIFY(BOOK_TITTLE VARCHAR2(100));

CREATE TABLE TBL_USER1(
	USER_NUMBER NUMBER,
	USER_NAME VARCHAR2(1000),
	USER_AGE NUMBER,
	CONSTRAINT PK_USER1 PRIMARY KEY(USER_NUMBER)
	);

SELECT * FROM TBL_USER1;

CREATE SEQUENCE SEQ_USER1;

INSERT INTO TBL_USER1
VALUES (SEQ_USER1.NEXTVAL, '짱구', 5);

INSERT INTO TBL_USER1
VALUES (SEQ_USER1.NEXTVAL, '철수', 5);

