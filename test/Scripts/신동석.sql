/*
 * 1. 
 * DB는 데이터들의 저장 집합소를 의미하지만, DBMS 직접적으로 사용하는 것이 아닌
 * 관리시스템을 이용해서 검색, 삭제, 추가 등을 활용하는 것
 * 
 * 2.
 * 일관성 : 중복된 자료의 여러 데이터를 한곳을 저장하여 관리하는 것
 * 독립성 : 컴퓨터 운영체제와 별도로 시스템 관리하는 것
 * 동시접속 : 다수의 사용자가 읽고 쓸 수 있게 하는 것
 * 데이터 공유 : 다수의 사용자가 데이터를 공유할 수 있게 데이터 시스템 관리하는 것
 * 
 * 3. 
 * sqlplus로 설치되어있는지 확인
 * sys 계정을 sysdba 권한으로 사용
 * password는 비공개 처리이므로 1234 입력
 *  연결 -> conn sys/1234
 * 	잠금해제 -> alter user account unlock
 *  비밀번호 설정 -> alter user identified by 1234; 
 *  정상적으로 로그인된 것을 확인
 * 
 * 4. 
 *  4-1. 프로젝트 생성 및 test폴더로 경로설정
 *  4-2. set active project 상태 변경
 * 		플러그 버튼으로 해당 DB 설정
 *  4-3. SQL 목록에서 Oracle 선택 다음으로 이동
 * 	4-4. port 번호 1521 확인
 * 		database : xe로 변경
 * 		username : hr
 * 		password : 1234 지정
 *  
 *  4-6. dirver setting
 * 		해당 경로로 ojdbc6.jar 로 설치된것으로 잡아야줘야한다
 * 		단) 다른것이 있다면 전체 삭제를 선행해야한다
 * 	4-5. testConnection을 사용하면 비연결/ 연결 확인가능
 * 	4-7. localhost와 해당 hr 이 연결된것을 확인
 * 
 * 
 */ 

SELECT * FROM EMPLOYEES; -- EMPLOYEES 릴레이션 전체를 검색

SELECT EMPLOYEE_ID FROM EMPLOYEES; --EMPLOYEES 릴레이션에서 EMPLOYEE_ID만을 검색


