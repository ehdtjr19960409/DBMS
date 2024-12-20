-- sys as sysdba 계정의 스크립트
GRANT UPDATE, INSERT, DELETE ON hr.employees TO test;

REVOKE UPDATE, INSERT, DELETE, SELECT ON hr.employees FROM test;