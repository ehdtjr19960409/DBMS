/* PLAYER 테이블에서 WEIGHT가 70이상이고 80이하인 선수 검색 */
SELECT * FROM PLAYER;
SELECT PLAYER_NAME FROM PLAYER WHERE WEIGHT BETWEEN 70 AND 80;

/* PLAYER 테이블에서 TEAM_ID가 'K03'이고 HEIGHT가 180 미만인 선수 검색 */
SELECT * FROM PLAYER;
SELECT PLAYER_NAME FROM PLAYER WHERE TEAM_ID LIKE'K03' AND HEIGHT <180;

/* PLAYER 테이블에서 TEAM_ID가 'K06'이고 NICKNAME이 '제리'인 선수 검색 */
SELECT * FROM PLAYER;
SELECT PLAYER_NAME FROM PLAYER p  WHERE TEAM_ID LIKE 'K06' AND NICKNAME LIKE '제리';

/* PLAYER 테이블에서 HEIGHT가 170이상이고 WEIGHT가 80이상인 선수 이름 검색 */
SELECT * FROM PLAYER;
SELECT PLAYER_NAME FROM PLAYER p  WHERE HEIGHT >= 170 AND WEIGHT >= 80;

/* STADIUM 테이블에서 SEAT_COUNT가 30000초과이고 41000이하인 경기장 검색 */
SELECT * FROM STADIUM;
SELECT STADIUM_NAME FROM STADIUM  WHERE SEAT_COUNT >30000 AND SEAT_COUNT <=41000;

/* PLAYER 테이블에서 TEAM_ID가 'K02'이거나 'K07'이고 포지션은 'MF'인 선수 검색 */
SELECT PLAYER_NAME FROM PLAYER p 
WHERE (TEAM_ID LIKE 'K02' OR TEAM_ID LIKE'K07') AND POSITION LIKE 'MF' ;

/* PLAYER 테이블에서 POSITION이 NULL인 선수 검색 */
SELECT PLAYER_NAME 
FROM PLAYER p 
WHERE POSITION IS NULL;

/* PLAYER 테이블에서 NICKNAME이 NULL인 선수를 '없음'으로 변경하여 조회하기 */

UPDATE PLAYER
SET NICKNAME = '없음'
WHERE NICKNAME IS NULL;

SELECT NICKNAME FROM PLAYER p ;
/* PLAYER 테이블에서 NATION이 등록되어 있으면 '등록', 아니면 '미등록'으로 검색 */
SELECT NATION, NVL2(NATION, '등록','미등록') 
FROM PLAYER;

-- PLAYER 테이블에서 POSITION이 NULL인 선수를 '미정'으로 변경 후 검색 
UPDATE PLAYER
SET POSITION = '미정'
WHERE POSITION IS NULL;

SELECT POSITION FROM PLAYER p WHERE POSITION = '미정' ;

--[과제]
/* PLAYER 테이블에서 포지션 종류 검색 */
SELECT * FROM PLAYER p;
SELECT DISTINCT POSITION FROM PLAYER p ;

/* PLAYER 테이블에서 몸무게가 80이상인 선수들의 평균 키가 180초과인 포지션 검색 */
SELECT HEIGHT FROM PLAYER p;

--몸무게가 80 이상인선수들의 /
SELECT POSITION
FROM PLAYER P1 
WHERE WEIGHT >=80 ; 

--WHERE절에서 합치기
--SELECT P1.POSITION
--FROM PLAYER p1
--	JOIN
--	()
--	ON
-- 평균 키가 180초과인 포지션 검색
SELECT POSITION,AVG(HEIGHT)
FROM PLAYER P2 
GROUP BY POSITION
HAVING AVG(HEIGHT) > 180;

/* EMPLOYEES 테이블에서 JOB_ID별 평균 SALARY가 10000미만인 JOB_ID 검색 JOB_ID는 알파벳 순으로 정렬(오름차순) */
SELECT * FROM EMPLOYEES e ;

SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES e
GROUP BY JOB_ID
HAVING AVG(SALARY) <10000
ORDER BY JOB_ID;

/* PLAYER_ID가 2007로 시작하는 선수들 중 POSITION별 평균 키를 조회 */
SELECT * FROM PLAYER p ;

-- PLAYER_ID가 2007로 시작하는 선수들 중
SELECT PLAYER_ID, POSITION 
FROM PLAYER p 
WHERE PLAYER_ID LIKE '2007%';

-- WHERE절에서 합치기


-- POSITION별 평균 키 조회

SELECT DISTINCT POSITION, ROUND(AVG(HEIGHT),1)
FROM PLAYER p 
GROUP BY POSITION;


/* 선수들 중 포지션이 DF 선수들의 평균 키를 TEAM_ID 별로 조회하고 평균 키 오름차순으로 정렬하기 */
/* 포지션이 MF인 선수들의 입단연도 별 평균 몸무게, 평균 키를 구한다.
 * 칼럼명은 입단연도, 평균 몸무게, 평균 키 로 표시한다.
 * 입단연도를 오름차순으로 정렬한다.
 * 단, 평균 몸무게는 70 이상 그리고 평균 키는 160 이상인 입단연도만 조회 */
/* PLAYER 테이블에서 TEAM_ID가 'K01'인 선수 중 POSITION이
 * 'GK'인 선수를 조회하기 SUB쿼리 사용하기 */
/* PLAYER 테이블에서 평균 몸무게보다 더 많이 나가는 선수들 검색 (조건에 서브쿼리 사용) */
/* PLAYER 테이블에서 정남일 선수가 소속된 팀의 선수들 조회*/
/* PLAYER 테이블에서 평균 키보다 작은 선수 조회*/
/*SCHEDULE 테이블에서 경기 일정이 
 * 20120501 ~ 20120502 사이에 있는 경기장 전체 정보 조회*/


/*
 * EMPLOYEE 테이블
 * 핸드폰번호가 515로 시작하는 사원들의
 * JOB_ID별 SALARY 평균을 구한다.
 * 조회 컬럼은 부서, 평균 급여 로 표시한다.
 * 평균 급여가 높은 순으로 정렬한다.
 */
/* COMMISSION_PCT 별 평균 급여를 조회한다.
 * COMMISSION_PCT 를 오름차순으로 정렬하며 
 * HAVING절을 사용하여 NULL은 제외한다.*/

