-- sys as sysdba 계정의 스크립트

grant UPDATE, INSERT, DELETE ON employees TO test;

REVOKE UPDATE, INSERT, DELETE ON employees FROM test;