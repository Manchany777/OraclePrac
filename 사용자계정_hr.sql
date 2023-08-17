select * from all_users;

select * from tab;

-------------------------------
--23년 7월 31일
select * from employees;

--문제1
select employee_id as 사원번호, first_name|| ' '||last_name as "이 름", salary*12||'달러' as 연봉 from employees;

--문제2
select last_name|| ' '|| 'is a' || ' ' || job_id as "Employee Detail" from employees;

--문제3
select first_name||' '||last_name as "사원명", salary as 월급, department_id as 부서코드 from employees
where (salary <= 2500 or salary >= 3000) and department_id = 90;

--문제4
select first_name||' '||last_name as "이름", job_id as 업무ID, salary as 급여 from employees
where job_id in ('SA_REP', 'AD_PRES') and salary > 10000;

--문제5
select distinct job_id as 업무ID from employees;

--문제6
select employee_id as 사원번호, first_name||' '||last_name as "이름", hire_date as 입사일 from employees 
where TO_CHAR(hire_date, 'YY-MM-DD') >= '05-01-01' and TO_CHAR(hire_date, 'YY-MM-DD') <= '05-12-31';

select employee_id as 사원번호, first_name||' '||last_name as "이름", hire_date as 입사일 from employees 
where hire_date like '05%';

-------------------------------

select last_name, department_id, hire_date
from employees
order by 2 desc, 3 asc;  -- 만약 2번 컬럼의 데이터가 똑같으면 제대로 정렬이 안된다.
                         -- 똑같은 데이터만 3 컬럼으로 오름차순
                         
create table text (
    str1 char(20),
    str2 varchar2(20));

insert into text(str1, str2) values('angel', 'angel');
insert into text(str1, str2) values('사천사', '사천사');
commit;

select lengthb(str1), lengthb(str2) from text;
select length(str1), length(str2) from text;
select * from text;

--문제1
select last_name as 이름, salary*12 as 연봉 from employees order by 2 desc;

--문제2
select employee_id, first_name||' '||last_name as "NAME", 
length(first_name||' '||last_name) as LENGTH
from employees where first_name like '%n';

select employee_id, concat(concat(first_name, ' '), Last_name) as "NAME", 
length(first_name||' '||last_name) as LENGTH
from employees where substr(first_name,-1,1) like '%n';

select employee_id,             -- by쌤
    concat(first_name, ' ' || last_name) as name,
    length(concat(first_name, ' ' || last_name) ) as lenght
from employees
where substr(last_name, -1, 1) = 'n';

--23년 08월 01일

--문제3
select last_day(sysdate)- sysdate from dual;

select to_char(to_date('97/9/30', 'YY-MM-DD') , 'YYYY-MON-DD') from dual; 

--문제4
select last_name, to_char(hire_date, 'DD-MON -YYYY')
from employees where hire_date<'05/01/01';

or where to_char(hire_date, 'YYYY') < 2005; 

--문제5
select count(*) as "커미션 받은 사람수" from employees where commission_pct is null;
--만약 count(commission_pct)라고 적으면 count하지 못하고 0을 리턴함

--문제6
select employee_id as 사원번호, first_name as 사원명, 
case
    when salary<10000 then '초급'
    when salary<20000 then '중급'
    else '고급'
end "구분"
from employees
order by 3, 2;

--문제7
select employee_id as 사원번호, first_name as 이름, salary as 급여, 
nvl(commission_pct,0) as 커미션,  -- 커미션에 nvl 적용하는 건 선택사항
to_char(salary*12+(salary*12*nvl(commission_pct, 0)), '$9,999,999') as 연봉
from employees;

--문제8
select employee_id as 사원번호, first_name as 이름, nvl(manager_id, 1000) as 매니저ID
from employees;

-------------------------------
--23년 8월 2일

--문제1
select job_id, to_char(sum(salary), '999,999') as 급여합계 from employees group by job_id;

--문제2~4번에 해당하는 테이블의 컬럼정보
select department_id, department_name, manager_id, location_id from DEPARTMENTS; 
select location_id, street_address, postal_code, city, state_province, 
        country_id from LOCATIONS;
select employee_id, first_name, last_name, email, phone_number, hire_date, job_id, 
        salary, commission_pct, manager_id, department_id from EMPLOYEES;
select country_id, country_name, region_id from COUNTRIES;   
--문제2 (4가지 방법)
select department_id, city from DEPARTMENTS, LOCATIONS where DEPARTMENTS.location_id = LOCATIONS.location_id;
select d.department_id, l.city from DEPARTMENTS d, LOCATIONS l where d.location_id = l.location_id;
select department_id, city from DEPARTMENTS join LOCATIONS using(location_id);
select d.department_id, l.city from DEPARTMENTS d join LOCATIONS l on d.location_id = l.location_id;

--문제3
select (e.first_name||' '||e.last_name) as 사원이름 , l.city as 도시, d.department_name as 부서이름
from DEPARTMENTS d
join LOCATIONS l using(location_id)
join EMPLOYEES e  using(department_id)
where l.city ='Seattle' or l.city ='Oxford'
order by l.city asc;  -- or 2 asc;

--문제4 (모든 사원을 포함한다는 left join. but, 어차피 where조건에 걸려서 의미가 없다.)
select e.employee_id as 사원번호, (e.first_name||' '||e.last_name) as 사원이름, d.department_name as 부서이름, 
    l.city as 도시, l.street_address as 도시주소, c.country_name as 나라이름
from DEPARTMENTS d
join LOCATIONS l using(location_id)
join EMPLOYEES e using(department_id)
join COUNTRIES c using(country_id)
where l.street_address like '%Ch%' or
      l.street_address like '%Sh%' or
      l.street_address like '%Rd%'
order by c.country_name asc, l.city asc;  -- or order by 6, 4;


-----------모야...위에 왜 한글 다 깨짐??
---23/08/03

create table locations2 as select * from locations;
alter table locations2 rename column location_id to loc_id;
alter table locations2 rename column loc_id  to location_id;

create table salgrade(
salvel varchar2(2),
lowst number,
highst number);

insert into salgrade values('A', 20000, 29999);
insert into salgrade values('B', 10000, 19999);
insert into salgrade values('C', 0, 9999);
commit;

select * from salgrade;

select last_name, salary, salvel
from employees
join salgrade on(salary between lowst and highst)
order by salary desc;

select e.employee_id as 사원번호,
          e.last_name as 사원이름,
          m.last_name as 관리자
from employees e, employees m
where m.employee_id = e.manager_id;

-----------------------------------------------------
create table employees_role as select * from employees where 1=0;

select * from employees;
select * from employees_role;

insert into employees_role values(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
insert into employees_role values(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
insert into employees_role values(101, 'Nee', 'Ko', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
insert into employees_role values(200, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
insert into employees_role values(200, 'Nee', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
insert into employees_role values(300, 'GilDong', 'Hong', 'NKOCHHAR', '010-123-4567', '2009-03-01', 'IT_PROG', 23000.00, NULL, 100, 90);

commit;

--UNION 문제1
select last_name as 사원이름, job_id as 업무ID, department_id as 부서ID
from employees
where department_id = '10'
union
select last_name as 사원이름, job_id as 업무ID, department_id as 부서ID
from employees_role
where job_id = 'IT_PROG';

-----------------------------------------------------
-- 23/08/04 서브쿼리

select * from employees;
select * from departments; department_id, department_name, manager_id, location_id
--문제1 최저급여를 받는 사원들의 이름과 급여를 구하시오
select first_name, salary from employees where salary = (select min(salary) from employees);

--문제2 부서별 급여 합계 중 최대급여를 받는 부서의 부서명과 급여합계를 구하시오
select department_name, sum(salary) from employees join departments using(department_id) group by department_name
having sum(salary) = (select max(sum(salary)) from employees group by department_id);

--문제3 'IT_PROG' 직급 중 가장 많이 받는 사원의 급여보다 더 많은 급여를 받는 'FI_ACCOUNT' 또는 'SA_REP' 직급 직원들을 조회하시오
select first_name as 사원명, job_id as 업무ID, to_char(salary, 'L999,999') as 급여 from employees 
where job_id in ('FI_ACCOUNT', 'SA_REP') 
    and salary >= any (select max(salary) from employees where job_id = 'IT_PROG')
order by salary desc;

-- by 쌤
select first_name as 사원명, job_id as 업무ID, to_char(salary, '999,999l') as 급여 from employees 
where job_id in ('FI_ACCOUNT', 'SA_REP') 
    and salary >= all (select salary from employees where job_id = 'IT_PROG')
order by salary desc;

select * from employees where last_name = 'Bell';
select * from jobs;
--문제4 자기 업무id(job_id)의 평균급여를 받는 직원들을 조회하시오
select last_name as 사원명, job_id as 업무id, j.job_title as 직무, to_char(salary, '$999,900') as 급여
from employees join jobs j using(job_id)
where salary = any (select ((min_salary + max_salary)/2) as salary from jobs)
order by salary asc;

select last_name as 사원명, job_id as 업무id, job_title as 직무, to_char(salary, '$999,999') as 급여
from employees 
join jobs using(job_id)
where (job_id, salary) in (select job_id, trunc(avg(salary), -3) from employees group by job_id)
order by salary asc;

select job_id, trunc(avg(salary), -3) from employees group by job_id;

select job_id, avg(salary) as 평균급여 from employees group by job_id order by avg(salary);

select last_name as 사원이름,
       job_id as 업무ID,
       job_title as 직무,
       to_char(salary,'999,999')||'$' as 급여
from employees
join jobs using(job_id)
where (job_id, salary) in 
(select job_id, trunc(avg(salary),-3) from employees group by job_id)
order by 4;

select last_name as 사원이름,
       job_id as 업무ID,
       job_title as 직무,
       to_char(salary,'999,999')||'$' as 급여
from employees
join jobs using(job_id)
where job_id in 
(select job_id from employees group by job_id) and salary in (select trunc(avg(salary),-3) from employees group by job_id)
order by 4;


----------------------------------------------------------------------
--23/08/07
create table user1(
idx     number  primary key,
id      varchar2(10) unique,
name    varchar2(10) not null,
phone   varchar2(15),
address varchar2(50),
score   number(6,2)  check(score >= 0 and score <= 100),
subject_code  number(5),
hire_date  date default sysdate,
marriage   char(1)  default 'N'  check(marriage in('Y', 'N')));

select constraint_name, constraint_type
from user_constraints
where table_name='USER1';

create table user2(
idx     number        constraint PKIDX primary key,
id      varchar2(10)  constraint UNID unique,
name    varchar2(10)  constraint NOTNAME not null,
phone   varchar2(15),
address varchar2(50),
score   number(6,2)   constraint CKSCORE check(score >= 0 and score <= 100),
subject_code  number(5),
hire_date  date default sysdate,
marriage   char(1)  default 'N' constraint CKMARR check(marriage in('Y','N')));

select constraint_name, constraint_type
from user_constraints
where table_name='USER2';

select *
from user_constraints
where table_name='USER2';

create table test(
id number(5),
name char(10),
address varchar2(50));

insert into user1(idx,id,name,phone,address,score,subject_code,hire_date,marriage)
values(1,'aaa','kim','010-000-0000','서울',75,100,'2010-08-01','Y');

insert into user1(idx,id,name,phone,address,score,subject_code,hire_date,marriage)
values(2,'aaa','kim','010-000-0000','서울',75,100,'2010-08-01','Y'); 

insert into user1(idx,id,name,phone,address,score,subject_code,hire_date,marriage)
values(2,'bbb','lee','010-000-0000','서울',75,100,'2010-08-01','N');

select * from user1;
commit;

select * from tab;

desc user1;

alter table test rename to user3;

alter table user3 add phone varchar2(15);

desc user3;

alter table user3 add constraint UID2 unique(id);

select constraint_name, constraint_type
from user_constraints
where table_name='USER3';

alter table user3 drop constraint UID2;

select *
from user_constraints
where table_name='USER3';

alter table user3 add no number primary key;  // no라는 컬럼이 추가(number 타입, pk제약조건)
alter table user3 modify name varchar2(10);
alter table user3 drop column address;
drop table user3;
desc user3;
drop table user3;
select * from tab;
purge recyclebin; 
drop table user1 purge;
drop table user2;
flashback table user2 to before drop;
select * from recyclebin;

--뷰
create or replace view v_view1
as select employee_id, last_name, salary, department_id from employees
where department_id=90;

select * from v_view1;

delete from v_view1;
--문제1 사원테이블에서 급여가 5000 이상 10000 이하인 사원들만 v_view2으로 뷰를 만드시오.
create or replace view v_view2
as select employee_id, last_name, salary, department_id from employees
where salary between 5000 and 10000;

create or replace view v_view2(사원ID, 사원이름, 급여, 부서ID)
as select employee_id, last_name, salary, department_id from employees
where salary between 5000 and 10000;
-- 이런식으로 select문에 as 주는 대신 뷰테이블명 옆에 직접 컬럼명 지정 가능

select * from v_view2;
update v_view2 set salary=12000 where employee_id=103;
-- -> 만약 create할때 컬럼명을 따로 지정했으면 여기서도 그 지정한 컬럼명을 써야 에러가 안뜬다
select * from employees where employee_id=103;
update employees set salary=9000 where employee_id=103;
select * from employees where employee_id=103;
select * from v_view2;
--문제2
 create or replace view v_view3 (사원번호, 사원명, 부서명)
 as select employee_id, last_name, department_name 
     from employees
     join DEPARTMENTS using(department_id)
     where department_id in(10, 90)
     order by 1 asc;

 select * from v_view3;
--문제3
create or replace view v_view4 (사원번호, 사원명, 급여, 입사일, 부서명, 부서위치)
as select e.employee_id, e.last_name, 
        to_char(trunc(salary, -3), '999,999L'), 
        to_char(e.hire_date, 'YY"년"MM"월"DD"일"'),
        d.department_name, l.city
    from DEPARTMENTS d
    join employees e using(department_id)
    join LOCATIONS l using(location_id)
    where department_id in(10, 90)
    order by 1 asc;

--쌤버전
create or replace view v_view4 (사원번호, 사원명, 급여, 입사일, 부서명, 부서위치)
as select employee_id,
        last_name, 
        to_char(trunc(salary, -3), '999,999') || '원', 
        to_char(hire_date, 'YYYY"년" MM"월" DD"일"'),
        department_name, 
        city
    from employees
    left join DEPARTMENTS using(department_id)
    join LOCATIONS2 on(location_id = loc_id)
    where department_id in(10, 90)
    order by 1;

select * from v_view4;

commit;

----------------------------------------------------------------------
--23/08/08
--문제4
commit;
--1) ①
create table bookshop (
isbn     varchar2(10) constraint PISBN primary key,  -- 기본키 (제약조건명 : PISBN)
title    varchar2(50) constraint CTIT not null,  -- 널값 허용X (제약조건명 : CTIT), 책제목
author   varchar2(50),  -- 저자 
price    number,      -- 금액
company  varchar2(30)  -- 출판사
);
--②
insert into bookshop(isbn, title, author, price, company) values('is001', '자바3일완성', '김자바', 25000, '야메루출판사');
insert into bookshop(isbn, title, author, price, company) values('pa002', 'JSP달인되기', '이달인', 28000, '공갈닷컴');
insert into bookshop(isbn, title, author, price, company) values('or003', '오라클무작정따라하기', '박따라', 23500, '야메루출판사');

select constraint_name, constraint_type from user_constraints where table_name='BOOKSHOP';
--③
select * from bookshop;
--2) ①
create table bookorder  (
idx   number primary key,  
isbn  varchar2(10),
qty   number,
constraint FKISBN foreign key(isbn) references bookshop
);

or 

create table bookorder  (
idx   number primary key,  
isbn  varchar2(10) constraint FKISBN references bookshop(isbn),
qty   number,
);
--②
select constraint_name, constraint_type from user_constraints where table_name='BOOKORDER';
--③
select * from bookorder;
--3) ①
create sequence idx_seq increment by 1 start with 1 nocycle nocache;
select idx_seq.nextval from dual;
select idx_seq.currval from dual; -- 현재 내가 진행한 시퀀스의값

select * from user_sequences;
--4) ①
insert into bookorder(idx, isbn, qty) values(idx_seq.nextval, 'is001', 2);
insert into bookorder(idx, isbn, qty) values(idx_seq.nextval, 'or003', 3);
insert into bookorder(idx, isbn, qty) values(idx_seq.nextval, 'pa002', 5);
insert into bookorder(idx, isbn, qty) values(idx_seq.nextval, 'is001', 3);
insert into bookorder(idx, isbn, qty) values(idx_seq.nextval, 'or003', 10);
--② ①
select * from bookorder;
--5) 여기서 중요한건 sum!!!!으로 합쳐줘야 group by가 된다.
create or replace view bs_view
as select distinct title as 책제목, author as 저자, to_char(sum(qty * price), '99,999,999') as 총판매금액
    from bookshop
    join bookorder using(isbn)
    group by title, author -- (title, author) 괄호 치던 안치던 똑같다. 각각을 그루핑 하는 게 아님
with read only;
--②
select * from bs_view;

------------------------------
select * from departments;
select * from employees;
--문제5-1 (내거 틀림, 연구필요)
select department_name as "부서명", "최대급여"
from departments, (select max(salary) as "최대급여" from employees group by department_id order by department_id)
order by department_name;
-- by쌤
select department_name as "부서명", max(salary) as "최대급여" from employees join departments using(department_id) group by department_name;
select "부서명", "최대급여"
from (select department_name as "부서명", max(salary) as "최대급여" 
      from employees join departments using(department_id) 
      group by department_name);   -- 이 문제는 인라인 뷰의 의미가 없지만 굳이 만들자면
    
--문제5-2 (내거 틀림, 연구필요)
select "이름" ,department_name as "부서명", "최대급여"
from departments, 
    (select last_name as "이름", max(salary) as "최대급여" from employees 
        group by department_id, last_name order by department_id);
--by쌤
select 이름, 부서명, 최대급여
from (select last_name as "이름", department_name as "부서명", salary as "최대급여" 
      from employees join departments using(department_id) 
      where (department_name, salary) in (select department_name, max(salary) as salary
                                        from departments join employees using(department_id) 
                                        group by department_name)
      );
or
select 이름, 부서명, 최대급여
from (select last_name as "이름", department_name as "부서명", salary as "최대급여" 
      from employees join departments using(department_id) 
      where (department_name, salary) in (select department_name, max(salary) as salary
                                          from employees
                                        group by department_id) -- 굳이 in절에서 select걸 필요가 없어서 이렇게 해도 된다.
     );

-- 문제6
select 사원이름, 부서명, 연봉
from (select last_name as 사원이름,
            department_name as 부서명,
            to_char(trunc(salary*12+(salary*12*nvl(commission_pct, 0)), -3), 'L999,999') as "연봉" 
     from employees 
     join departments using(department_id)
     order by 연봉 asc)
where rownum <= 5;

-- synonym 실습 1번
grant all on employees to c##java;