create user c##java identified by 1231;
grant create session, create table, create sequence, create view to c##java;
alter user c##java default tablespace users;
alter user c##java quota unlimited on users;

select * from all_users;

--28/08/08
-- synonym 실습 3번
grant create synonym to c##java;