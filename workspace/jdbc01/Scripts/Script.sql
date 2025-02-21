CREATE sequence seq_user;

-- 사용자 정보 저장하는 유저 테이블 tbl_user
-- 사용자 번호
-- 아이디
-- 패스워드
-- 이름
-- 나이
-- 성별
-- 생일

CREATE TABLE tbl_user(
	user_number NUMBER,
	user_id varchar2(100),
	user_pw varchar2(100),
	user_name varchar2(10),
	user_age NUMBER,
	user_gender char(1) DEFAULT 'M',
	user_birth DATE,
	CONSTRAINT pk_user PRIMARY KEY(user_number)
);

SELECT * FROM tbl_user;

INSERT INTO tbl_user
--VALUES (seq_user.nextVal, 'aaa', '1234', '홍길동' , 22, 'M' ,'20001010');
--VALUES (seq_user.nextVal, 'ccc', '1234', '신동석' , 26, 'M' ,'20250103');

SELECT user_number, user_id FROM tbl_user WHERE user_id = 'aaa';


INSERT INTO TBL_USER(USER_NUMBER, USER_ID,USER_PW,USER_NAME,USER_AGE,USER_GENDER,USER_BIRTH)
VALUES (SEQ_USER.NEXTVAL, 'ABC', '1234', '짱구', 5, 'M', '2000-01-01');

DELETE FROM TBL_USER WHERE  user_number =26;

SELECT user_number
FROM TBL_USER 
WHERE USER_ID ='aaa' AND user_pw='1234';

SELECT USER_ID
FROM TBL_USER 
WHERE USER_NAME = '신동석' AND USER_BIRTH ='2025-01-03'; 

-- 회원 전체정보 수정
UPDATE tbl_user 
SET USER_ID = ?, user_pw = ? , USER_NAME = ?, USER_AGE = ?, USER_AGE = ?, USER_GENDER = ?, USER_BIRTH =?;

-- 회원 1명의 전체정보 조회
SELECT user_id, user_pw, user_name, user_age, user_gender, user_birth
FROM tbl_user
WHERE USER_NUMBER = ?;

--회원 탈퇴
DELETE FROM TBL_USER
WHERE USER_NUMBER = ? ;