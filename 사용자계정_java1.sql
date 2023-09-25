--23/08/31
--[테이블]
create table guestbook(
seq   number primary key, -- 시퀀스 객체로부터 값을 얻어온다
name  varchar2(30),
email  varchar2(30),
homepage  varchar2(35),
subject  varchar2(500) not null,
content  varchar2(4000) not null,
logtime  date default sysdate); -- default값 주면 sysdate가 자동으로 적용 (jdbc에서 insert할 때 sysdate 컬럼 빼버려도 된다.)
--[시퀀스]
create sequence seq_guestbook nocycle nocache;

select * from guestbook;
drop table guestbook;
select seq, name, email, homepage, subject, content, 
to_char(logtime, 'YYYY-MM-DD') as logtime from (select * from guestbook order by logtime desc) tt;

-- 페이징 처리 (해당 문법은 오라클 7일차 파일에 있으니 참고)
select * from 
(select rownum rn, tt.* from (select * from guestbook order by seq desc) tt)
where rn >=1 and rn <=3;

select count(*) from guestbook;


select * from tab; -- 휴지통
purge recyclebin; -- 휴지통 비우기


--회원가입 테이블(member)
create table member(
name varchar2(30) not null,
id varchar2(30) primary key, --기본키, unique, not null, 무결성 제약 조건
pwd varchar2(30) not null,
gender varchar2(3),
email1 varchar2(20),
email2 varchar2(20),
tel1 varchar2(10),
tel2 varchar2(10),
tel3 varchar2(10),
zipcode varchar2(10),
addr1 varchar2(100),
addr2 varchar2(100),
logtime date);

select * from board;
select * from member;
select * from member where id='hong';
select * from member where id='hong' and pwd='111';
insert into member(name, id, pwd) values ('홍길동', 'hong', '111');
delete from member;
-- 보드리스트
select * from board order by seq desc;
-- 페이징 처리
select * from 
    (select rownum rn, tt.* from (select * from board order by seq desc) tt order by seq desc)  
where rn >=1 and rn <=5;


update member set email1='hong', email2='naver.com' where id='hong';
update member set email1='mamos', email2='gmail.com' where id='mamos';
update member set email1='aaa', email2='gmail.com' where id='aaa';
update member set email1='kimtest', email2='gmail.com' where id='kimtest';

commit;

--board 숙제
CREATE TABLE board(
     seq NUMBER NOT NULL,               -- 글번호 (시퀀스 객체 이용)
     id VARCHAR2(20) NOT NULL,           -- 아이디
     name VARCHAR2(40) NOT NULL,       -- 이름
     email VARCHAR2(40),                  -- 이메일
     subject VARCHAR2(255) NOT NULL,    -- 제목
     content VARCHAR2(4000) NOT NULL,   -- 내용 

     ref NUMBER NOT NULL,                 -- 그룹번호
     lev NUMBER DEFAULT 0 NOT NULL,     -- 단계
     step NUMBER DEFAULT 0 NOT NULL,    -- 글순서
     pseq NUMBER DEFAULT 0 NOT NULL,    -- 원글번호
     reply NUMBER DEFAULT 0 NOT NULL,   -- 답변수

     hit NUMBER DEFAULT 0,              -- 조회수
     logtime DATE DEFAULT SYSDATE
 );
 
CREATE SEQUENCE seq_board  NOCACHE NOCYCLE;

select * from board;
rollback;

-- boardView
select * from board where seq=7;
-- 총 글수
select count(*) from board;
select count(id) from board;
update board set 
 	subject='좉망', content='다 수정되어버렸어...', logtime=sysdate
 	where seq=1;

------------------------------------------------------mybatis
-- usertable
create table usertable(
name varchar2(30) not null,
id varchar2(30) primary key,
pwd varchar2(30) not null);

select * from usertable;

SELECT * FROM usertable WHERE id LIKE '%n%';

-- 페이징 기능
select * from
(select rownum rn, tt.* from
(select * from usertable) tt
) where rn>=1 and rn<=2;

select count(*) from usertable;

-- 회원정보 수정 기능
select * from usertable where id='hong';

--이미지파일 업로드
create table USERIMAGE (
SEQ number primary key,
IMAGENAME varchar2(50) not null,
IMAGECONTENT varchar2(4000),
IMAGE1 varchar2(200));

create sequence SEQ_USERIMAGE nocycle nocache;

select * from userimage;