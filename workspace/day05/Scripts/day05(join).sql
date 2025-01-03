-- 내부조인


-- 도서테이블과 도서가격테이블 생성
CREATE TABLE tbl_book(
	book_id NUMBER,
	book_tittle varchar2(1000),
	book_author varchar2(100),
	CONSTRAINT book_pk PRIMARY KEY(book_id)
);

SELECT * FROM tbl_book;

CREATE TABLE tbl_bookprice(
	bp_id NUMBER,
	bp_price NUMBER,
	CONSTRAINT bp_pk PRIMARY key(bp_id)
);

SELECT * FROM tbl_bookprice;

-- 값 추가
INSERT INTO TBL_BOOK 
--VALUES(1, '위대한 게츠비', 'F.스콧피츠제럴드');
--VALUES(2,'해리포터와 마법사의 돌','J.K 롤링');
--VALUES(3, '1984','조지오웰');
--VALUES(4, '오만과 편견', '제인 오스틴');
--VALUES(5, '데미안', '헤르만 헤세');
--VALUES(6,'모모','미하엘 엔더');
VALUES(7, 'DBMS완전정복', 'DBMS');
SELECT * FROM TBL_BOOK tb ;


INSERT INTO TBL_BOOKPRICE
--VALUES(1,15000);
--VALUES(2,18000);
--VALUES(3,14000);
--VALUES(4, 17000);
--VALUES(5, 18000);
--VALUES(6, 20000);
VALUES(7, 20000);

SELECT * FROM TBL_BOOKPRICE tb ;

-- 2개의 테이블 내부조인
SELECT A.BOOK_ID, A.BOOK_TITTLE, A.BOOK_AUTHOR, B.BP_ID
FROM TBL_BOOK A INNER JOIN TBL_BOOKPRICE B
ON A.BOOK_ID = B.BP_ID;

DROP TABLE TBL_BOOK;
DROP TABLE TBL_BOOKPRICE;
-- 도서관
-- 도서테이블, 회원테이블, 렌탈테이블

CREATE TABLE tbl_book(
	book_id NUMBER,
	book_tittle varchar2(1000),
	book_author varchar2(100),
	CONSTRAINT book_pk PRIMARY KEY(book_id)
);


CREATE TABLE TBL_MEMBER(
	MEM_ID NUMBER,
	MEM_NAME VARCHAR2(100),
	MEM_PHONE VARCHAR2(100),
	MEM_EMAIL VARCHAR2(100),
	CONSTRAINT MEMBER_PK PRIMARY KEY(MEM_ID)
);



DROP TABLE TBL_MEMBER;

CREATE TABLE TBL_RENTAL(
	REN_ID NUMBER,
	MEM_ID NUMBER,
	BOOK_ID NUMBER,
	REN_RENTALDATE DATE,
	REN_RETURNDATE DATE,
	CONSTRAINT PK_RENTAL PRIMARY KEY(REN_ID),
	CONSTRAINT FK_RENTAL_MEM FOREIGN KEY(MEM_ID) REFERENCES TBL_MEMBER(MEM_ID),
	CONSTRAINT FK_RENTAL_BOOK FOREIGN KEY(BOOK_ID) REFERENCES TBL_BOOK(BOOK_ID));

INSERT INTO TBL_BOOK 
--VALUES(1, '위대한 게츠비', 'F.스콧피츠제럴드');
--VALUES(2,'해리포터와 마법사의 돌','J.K 롤링');
--VALUES(3, '1984','조지오웰');
--VALUES(4, '오만과 편견', '제인 오스틴');
--VALUES(5, '데미안', '헤르만 헤세');

INSERT INTO TBL_MEMBER
VALUES
--(1, '짱구', '123-456-7890', 'aaa@koreait.com');
--(2, '유리', '987-654-3210', 'bbb@koreait.com');
--(3, '철수', '555-123-4567', 'ccc@koreait.com');
--(4, '훈이', '777-888-9999', 'ddd@koreait.com');
--(5, '맹구', '555-777-3333', 'eee@koreait.com');


INSERT INTO TBL_RENTAL
VALUES
--(1, 1, 3, TO_DATE('2023-12-11', 'YYYY-MM-DD'), TO_DATE('2023-12-18', 'YYYY-MM-DD'));
--(2, 2, 1, TO_DATE('2023-12-11', 'YYYY-MM-DD'), TO_DATE('2023-12-18', 'YYYY-MM-DD'));
--(3, 3, 2, TO_DATE('2023-12-13', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'));
--(4, 4, 4, TO_DATE('2023-12-20', 'YYYY-MM-DD'), TO_DATE('2023-12-27', 'YYYY-MM-DD'));
(5, 5, 5, TO_DATE('2023-12-22', 'YYYY-MM-DD'), TO_DATE('2023-12-29', 'YYYY-MM-DD'));

SELECT * FROM TBL_BOOK;
SELECT * FROM TBL_MEMBER;
SELECT * FROM TBL_RENTAL;

-- 등가조인 : 두개 이상의 테이블을 조인할 때, 특정 컬럼들의 값이 서로 같은 행만 결과로 반환


-- 대여정보와 책의 저자를 가져오는 등가조인
-- 1) 행의 개수를 먼저 파악하여 선행 테이블, 후행 테이블 설정
SELECT COUNT(*)
FROM TBL_BOOK;

SELECT COUNT(*)
FROM TBL_RENTAL;

-- 2) JOIN 사용하여 두개의 테이블 조회
SELECT TR.REN_RENTALDATE, TR.REN_RETURNDATE, TB.BOOK_AUTHOR
from TBL_RENTAL tr INNER JOIN TBL_BOOK tb
-- 두개의 테이블에서 일치하는 컬럼을 확인 후 on절에 추가
ON tr.book_id = tb.book_id;

-- 대여한 책이름과 반납날짜 가져오는 등가조인
SELECT tb.book_tittle, tr.ren_returndate
FROM TBL_BOOK tb  JOIN tbl_rental tr
ON tb.BOOK_ID = tr.book_id;

SELECT tb.*, TR.*
FROM TBL_BOOK tb  JOIN tbl_rental tr
ON tb.BOOK_ID = tr.book_id;

--회원의 이름과 대여한 책의 제목을 가져오는 등가조인

SELECT TB.BOOK_TITTLE, TM.MEM_NAME
FROM TBL_BOOK TB INNER JOIN TBL_MEMBER TM
ON TB.BOOK_ID = TM.MEM_ID;

-- 각 1개의 테이블끼리 비교했을 때는 조건의 결과가 정확히는 안나오지만,
-- 각 테이블끼리의 공통된 컬럼을 비교했을 때는 정확히 나온다
SELECT TB.BOOK_TITTLE, TM.MEM_NAME
FROM TBL_RENTAL TR
JOIN TBL_MEMBER TM ON TR.MEM_ID = TM.MEM_ID
JOIN TBL_BOOK TB ON TR.BOOK_ID = TB.BOOK_ID;

-- 비등가조인 : 두 테이블간의 조건이 같음이 아닌 범위 조건 등을 사용하는 방식

-- 책 대여일-반납일 사이에 특정 날짜가 포함되어 있는지 조회

SELECT TM.MEM_NAME, TB.BOOK_TITTLE, TR.REN_RENTALDATE, TR.REN_RETURNDATE
FROM TBL_RENTAL tr 
JOIN TBL_BOOK tb ON TR.BOOK_ID = TB.BOOK_ID
JOIN TBL_MEMBER TM ON TR.MEM_ID = TM.MEM_ID
WHERE TO_DATE('2023-12-25', 'YYYY-MM-DD') BETWEEN TR.REN_RENTALDATE AND TR.REN_RETURNDATE;

-- 대여기간에 따라 책의 대여 상태
-- 7일 이하 단기대여, 7일 이상 장기 대여
SELECT TB.BOOK_TITTLE, TM.MEM_NAME, TR.REN_RENTALDATE, TR.REN_RETURNDATE,
	CASE 
		WHEN REN_RETURNDATE - REN_RENTALDATE <= 7 THEN '단기대여'
		ELSE '장기대여'
	END AS RENTAL_TYPE
FROM TBL_RENTAL TR
JOIN TBL_BOOK TB ON TR.BOOK_ID = TB.BOOK_ID
JOIN TBL_MEMBER TM ON TR.MEM_ID = TM.MEM_ID;
	
--SQL 실행순서
--FROM -> ON -> JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
-- FROM : 테이블이나 뷰의 데이터 가져오기
-- ON : JOIN절의 조건 평가
-- JOIN : 지정된 조건에 따라 두 개 이상의 테이블을 조인
-- WHERE : 조인 결과에서 조건에 맞는 행을 필터링
-- GROUP BY : 데이터 그룹화(집계함수와 주로 사용)
-- HAVING : GROUP BY로 그룹화된 데이터에 대해 조건 적용
-- SELECT : 조회할 컬럼을 선택(집계함수, 별칭)
-- ORDER BY : 최종 결과물 정렬(ASC,DESC)

-- 외부조인
CREATE TABLE TBL_BOOKPRICE(
   BP_ID NUMBER,
   BP_PRICE NUMBER,
   CONSTRAINT BP_PK PRIMARY KEY(BP_ID)
);

INSERT INTO TBL_BOOKPRICE
--VALUES(1, 15000);
--VALUES(2, 18000);
--VALUES(3, 14000);
--VALUES(4, 17000);

SELECT * FROM tbl_book tb;
SELECT * FROM tbl_bookprice;

-- 1) 왼쪽 외부조인(LEFT OUTER JOIN)
-- BOOKS 테이블 기준 왼쪽 외부조인을 수행하고 BOOKSPRICE 테이블의 데이터를 포함(왼쪽테이블의 데이터가 없어도 결과에 포함됨)
SELECT TB.BOOK_ID, TB.BOOK_TITTLE, TB.BOOK_AUTHOR, TP.BP_ID, TP.BP_PRICE
FROM TBL_BOOK tb
LEFT OUTER JOIN TBL_BOOKPRICE TP
ON TB.BOOK_ID = TP.BP_ID;


-- 2) 오른쪽 외부조인(RIGHT OUTER JOIN)
-- BOOKPRICE 기준으로 오른쪽 외부조인을 수행하고 BOOKS테이블의 데이터를 포함
SELECT TB.BOOK_ID, TB.BOOK_TITTLE, TB.BOOK_AUTHOR, TP.BP_ID, TP.BP_PRICE
FROM TBL_BOOK tb
RIGHT OUTER JOIN TBL_BOOKPRICE TP
ON TB.BOOK_ID = TP.BP_ID;

INSERT INTO TBL_BOOK TB
VALUES(10, 'DBMS', 'DB');
INSERT INTO TBL_BOOKPRICE
--VALUES(5, 20000);
--VALUES(6, 16000);
--VALUES(7, 20000);

SELECT * FROM TBL_BOOKPRICE;


--완전 외부조인(FULL OUTER JOIN) : 왼쪽 테이블과 오른쪽 테이블의 데이터를 모두 포함
-- 어느 한쪽에만 데이터가 있는 경우에도 결과에 포함된다

SELECT TB.BOOK_ID, TB.BOOK_TITTLE, TB.BOOK_AUTHOR, TP.BP_ID, TP.BP_PRICE
FROM TBL_BOOK TB
FULL OUTER JOIN TBL_BOOKPRICE TP
ON TB.BOOK_ID = TP.BP_ID;







