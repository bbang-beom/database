-- 테이블 생성
create table fruits(
    fruitid number primary key,
    name varchar(20)
);

insert into fruits values(10, '오렌지');
insert into fruits values(15, '키위');
insert into fruits values(19, '파인애플');

select * from fruits;

21 not in (select fruitid from fruits); -- 참
19 < any (select fruitid from fruits); -- 거짓
15 < all (select fruitid from fruits); -- 거짓
19 = all (select fruitid from fruits); -- 거짓

-- 부속질의
-- 1
select custid,(select address from customer c 
where c.custid = o.custid) "address", sum(saleprice) "total"
from orders o group by o.custid; -- 각 주소별 거주하는 고객의 고객번호, 고객이 구매한 도서의 총액

-- 2
select c.name, s from (select custid, avg(saleprice) s from orders group by custid) o,
customer c where c.custid = o.custid; -- 고객별 구매한 도서의 가격의 평균

-- 3
select sum(saleprice) "total" from orders o where exists 
(select * from customer c where custid <= 3 and c.custid = o.custid);
-- 고객번호가 3이하인 고객들이 구매한 도서의 총액

-- 뷰 작성
-- 판매가격이 20000원 이상인 도서의 도서번호, 도서이름, 고객이름, 출판사, 판매가격을 보여주는 view
create view highorders (bookid, bookname, name, publisher, saleprice)
as select b.bookid, b.bookname, c.name, b.publisher, o.saleprice from book b, customer c, orders o
where b.bookid = o.bookid and c.custid = o. custid and o.saleprice >= 20000;

-- 판매된 도서의 이름과 고객의 이름을 출력
select bookname, name from highorders;




