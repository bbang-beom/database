-- 뷰 수정
create or replace view highorders (bookid, bookname, name, publisher)
as select b.bookid, b.bookname, c.name, b.publisher from book b, customer c, orders o
where b.bookid = o.bookid and c.custid = o. custid and o.saleprice >= 20000;
-- 판매된 도서의 이름과 고객의 이름을 출력
select bookname, name from highorders;


select * from emp;
select * from dept;
-- 팀장(mgr)이 없는 직원
select ename from emp where mgr is null;
-- 사원의 이름과 부서의 이름
select e.ename, d.dname from emp e, dept d where e.deptno = d.deptno;
-- 'CHICAGO'에 근무하는 사원의 이름
select e.ename from emp e, dept d where e.deptno = d.deptno and d.loc = 'CHICAGO';
-- 평균보다 급여가 많은 직원의 이름
select ename from emp where sal > (select avg(sal) from emp);
-- 자기 부서의 평균보다 급여가 많은 직원의 이름
select e1.ename, e1.deptno from emp e1 where e1.sal > (select avg(e2.sal) from emp e2 where e1.deptno = e2.deptno);
-- 극장-고객 뷰
create view theater_theater_customer (theater_name, customer_name) as
select t.name, c.name from theater t, customer c;
-- 대한-고객수 뷰
create view dahan_customer (name, cnt, reservaion_date) as
select t.name, count(r.customerid), r.reservation_date from theater t, reservation r 
where t.theaterid = r.theaterid and t.name = '대한' group by r.reservation_date, t.name;
-- 극장예약 뷰
create view theater_reservation(name, cnt) as 
select t.name, count(*) from theater t, reservation r
where t.theaterid = r.theaterid group by t.name;

-- 1
select * from theater_reservation; -- 예약한 고객이 있는 극장별 예약한 고객의 수 출력
-- 2
select cnt from theater_reservation where name = '강남'; -- 극장이름이 강남인 극장의 예약한 고객 수 출력
-- 강남이란 이름을 가진 극장은 없으므로 null
-- 3
select min(cnt) from theater_reservation; -- 가장 적은 예약 수 출력
-- 4
select count(*) from theater_reservation; -- theater_reservation 투플의 수 출력 -> 즉, (예약한 고객이 있는 극장의 수)
-- 5
select name from theater_reservation where cnt > 100; -- 예약인원이 100명이 넘는 극장의 이름
-- 예약인원이 100명이 넘는 극장은 없음
-- 6
select name from theater_reservation order by cnt; -- 예약인원 순 오름차순 정렬하여 극장이름 출력



