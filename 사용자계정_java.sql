create table 연산(
x int, -- 고정형, int는 소수이하 자른다(반올림 된다)
y number, -- 가변형, number는 소수이하 놔둔다
z number(10,3)); -- 소수점 3자리까지(반올림 된다)

select * from 연산;

desc 연산;

insert into 연산(x, y, z) values(25, 36, 12.34567);
insert into 연산(x, y, z) values(25.34567, 36.34567, 12.34567);
insert into 연산(x, y) values(25.666, 36.88888); -- 25.666 (반올림 되서 26 나온다)
insert into 연산(z, y, x) values(1, 2, 3); -- 순서가 바뀌어도 된다

insert into 연산 values(25, 36, 12.34567);
  -- 필드명 생략 가능하게 되면 필드를 빠짐없이 순서대로 입력해야한다
insert into 연산 values(25, 36, 1234567.3456); -- 유효숫자는 최대7자리
insert into 연산 values(25, 36, 12345678.3456); -- error

delete from 연산 where x = 25 and y = 36 and z = 12.346;
commit;
rollback;

-------------------------------
create table dbtest(
name varchar2(15), -- char(고정형), varchar2(가변형) (오라클에서 한글은 3byte 씩 잡아먹음)
age number,
height number(10, 2),
logtime date);

insert into dbtest(name, age, height, logtime) values('홍길동', 25, 185.567, sysdate);
insert into dbtest(name, age, height, logtime) values('Hong', 30, 175.56, sysdate);
insert into dbtest(name, age) values('희동이', 3);
insert into dbtest(name, height) values('홍당무', 168.89);
insert into dbtest values('분홍신', 5, 123.5, sysdate);
insert into dbtest(name) values('진분홍');

commit;
select * from dbtest;

select name, age, height, logtime from dbtest;
select name, age from dbtest;
select * from dbtest;
select * from dbtest where name='홍길동';
select * from dbtest where name like '홍%';
select * from dbtest where name like '_홍%';
select * from dbtest where name like '__홍%';

select * from dbtest where name='hong'; -- 데이터는 대소문자 가린다.
select * from dbtest where lower(name) = 'hong'; -- lower() 소문자
select * from dbtest where upper(name) = 'HONG'; -- upper() 대문자
select * from dbtest where name like '%동%' and age<20;

select * from dbtest where age is null;
select * from dbtest where age is not null;
select name, age+height from dbtest;
select name, age, height, age+height as "나이와 키의 합" from dbtest;

-- 이름에 '홍'이 들어가면서 나이가 20이상인 레코드만 추출하시오 && - and
select * from dbtest where name like '%홍%' and age>=20;

select * from dbtest order by name asc; -- asc는 생략가능
select * from dbtest order by name;
select * from dbtest order by name desc;


update dbtest set age=0 where name='홍당무';
update dbtest set age=0, height=0 where name='진분홍';
update dbtest set age=age+1;
update dbtest set age=age+1 where name='홍길동';

delete dbtest;
rollback;

drop table 연산;
select * from tab;
select * from recyclebin; 
show recyclebin;
flashback table 연산 to before drop;
select * from 연산;
drop table 연산 purge;
purge recyclebin;

-------------------------------

create sequence test increment by 2 start with 1 maxvalue 9 cycle nocache;

create sequence sample nocycle nocache;

select test.nextval from dual;
select test.currval from dual; -- 현재 내가 진행한 시퀀스의값
select * from user_sequences;
drop sequence test; -- 시퀀스 삭제
drop sequence sample;

select * from dbtest;
-------------------------------

create table student2 (
name varchar2(15) not null, -- 이름
value varchar2(15), -- 학번 or 과목 or 부서
code number -- 1이면 학생, 2이면 교수, 3이면 관리자
);

select * from student2;
--------------------------------------------------------------
--------------------------------------------------------------

@@D:\bitcamp\Oracle\stExe_학생.sql;

select * from emp;

select * from student;
--문제1
select major as 학과, to_char(avg(avr), 9.99) as 평점평균 from student 
where major not in('화학')
group by major;

--문제2
select major as 학과, to_char(avg(avr), 9.99) as 평균평점 from student 
where major not in('화학')
group by major having avg(avr)>=2.0;


--조인문제
select pno, pname, section, orders, hiredate from professor p; 
select cno, cname, st_num, pno from course co; 
select sno, sname, sex, syear, major, avr from student st; 
select sno, cno, result from score sc; 

--문제1
select c.cname from course c join professor p on p.pno = c.pno where p.pname = '송강';

--문제2
select p.pname from professor p join course c on p.pno = c.pno where c.cname like '%화학%';

--문제3
select st.sname as 이름, sc.result as "기말고사 점수" from score sc 
join student st using(sno)
join course co using(cno)
where st.major = '화학' and st.syear = '1' ;

--문제4
select st.sname as 이름, sc.result as "기말고사 점수" from score sc 
join student st using(sno)
join course co using(cno)
where st.major = '화학' and st.syear = '1' and co.cname = '일반화학';


-- 정답
--문제1) 화학과를 제외하고 학과별로 학생들의 평점 평균을 검색하시오 (GROUP, HAVING)
--       평균을 소수이하 2째 자리에서 반올림
--       테이블 : STUDENT
select major, round(avg(avr), 2) from student where major != '화학' group by major;
select major, round(avg(avr), 2) from student group by major having major != '화학';

--문제2) 화학과를 제외한 각 학과별 평균 평점 중에 평점이 2.0 미만인 정보를 검색하시오 
-- (원래 이상인데 미만으로 문제 바뀜)
select major, round(avg(avr), 2) 
from student
where major != '화학'
group by major
having round(avg(avr), 2) < 2;

--조인 문제
--문제1) 송강 교수가 강의하는 과목을 검색하시오.
--테이블 : PROFESSOR P, COURSE C
--컬럼 : PNO, PNAME, CNO, CNAME
select p.pno, pname, cno, cname
from professor p, course c
where p.pno = c.pno and p.pname = '송강';

select pno, pname, cno, cname
from professor
join course c using(pno)
where pname = '송강';

--문제2) 화학 관련 과목을 강의하는 교수의 명단을 검색하시오
--테이블 : PROFESSOR P, COURSE C
--컬럼 : PNO, PNAME, CNO, CNAME
select p.pno, pname, cno, cname
from professor p, course c
where p.pno = c.pno and c.cname like '%화학%';

select pno, pname, cno, cname
from professor
join course using(pno)
where c.cname like '%화학%';

--문제3) 화학과 1학년 학생의 기말고사 성적을 검색하시오
--테이블 : STUDENT ST, SCORE SC, COURSE CO
--컬럼 : SNO, SNAME, MAJOR, SYEAR, CNO, CNAME, RESULT
select st.sno, sname, major, syear, sc.cno, cname, result
from student st, score sc, course co
where st.sno = sc.sno and sc.cno = co.cno and major = '화학' and syear = '1';

select sno, sname, major, syear, cno, cname, result
from student
join score using(sno) 
join course using(cno)
where major = '화학' and syear = '1';

--문제4) 화학과 1학년 학생의 일반화학 기말고사 점수를 검색하시오
--테이블 : STUDENT ST, SCORE SC, COURSE CO
--컬럼 : SNO, SNAME, MAJOR, SYEAR, CNO, CNAME, RESULT
select st.sno, sname, major, syear, sc.cno, cname, result
from student st, score sc, course co
where st.sno = sc.sno and sc.cno = co.cno and major = '화학' and cname = '일반화학' and syear = '1';

select sno, sname, major, syear, cno, cname, result
from student 
join score using(sno)
join course using(cno)
where major = '화학' and cname = '일반화학' and syear = '1';
-------------------------------

--23/08/08
-- synonym 실습 2번
create synonym hr_emp for hr.employees;
-- synonym 실습 4번
select * from user_synonyms;
select * from hr.employees;
select * from hr_emp;
drop synonym hr_emp;
select * from user_synonyms;