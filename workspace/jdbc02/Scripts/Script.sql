CREATE SEQUENCE seq_user2;
CREATE SEQUENCE seq_book;
CREATE SEQUENCE seq_rental;

--DROP SEQUENCE seq_book;


CREATE TABLE TBL_USER2(
   user_number NUMBER,
   user_id varchar2(100) NOT NULL,
   user_pw varchar2(100) NOT NULL,
   user_name varchar2(100) NOT NULL,
   user_phone varchar2(100) UNIQUE,
   CONSTRAINT pk_user2 PRIMARY KEY(user_number)
);

CREATE TABLE TBL_BOOK(
   book_number NUMBER,
   book_title varchar2(100) NOT NULL,
   book_author varchar2(100) NOT NULL,
   CONSTRAINT pk_book PRIMARY KEY(book_number)
);

CREATE TABLE TBL_RENTAL(
   rental_number NUMBER,
   user_number NUMBER,
   book_number NUMBER,
   rental_date DATE,
   rental_day NUMBER,
   CONSTRAINT pk_rental PRIMARY KEY(rental_number),
   CONSTRAINT fk_user FOREIGN KEY(user_number) REFERENCES TBL_USER2(user_number),
   CONSTRAINT fk_book FOREIGN KEY(book_number) REFERENCES TBL_BOOK(book_number)
);
--DROP TABLE TBL_USER2;

SELECT * FROM TBL_USER2;
SELECT * FROM TBL_BOOK;
SELECT * FROM TBL_RENTAL;

SELECT book_number, book_title, book_author 
FROM TBL_BOOK
WHERE BOOK_NUMBER = 1;

INSERT INTO TBL_BOOK values(seq_book.nextVal, '노인과 바다', '해밍워이');

INSERT INTO TBL_USER2 values(seq_user2.nextVal, 'aaa', '1234', '짱구', '01042324432');

INSERT INTO TBL_RENTAL values(seq_rental.nextVal, 1, 1, sysdate, 7); 

INSERT INTO TBL_BOOK
--VALUES(SEQ_BOOK.NEXTVAL,'웹 표준의 정석', '고경희');
--VALUES(SEQ_BOOK.NEXTVAL,'DBMS의 정석', '노형우');
--VALUES(SEQ_BOOK.NEXTVAL,'Java의 정석', '송명진');
--VALUES(SEQ_BOOK.NEXTVAL,'JavaScript의 정석', '김태현');
VALUES(SEQ_BOOK.NEXTVAL,'정석의 정석', '신동석');