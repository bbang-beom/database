-- 뷰
-- 뷰는 가상의 테이블
-- select문을 통해 얻은 최종 결과를 가상의 테이블로 정의하여 실제 테이블처럼 사용할 수 있도록 만든 데이터베이스 개체

-- 뷰의 장점
-- 편리성: 여러 테이블에서 데이터를 가져와 하나의 테이블로 정의함으로써 질의 작성이 간단해짐
-- 또, 미리 작성된 질의를 뷰로 정의해두면 질의 재사용 가능
-- 보안성: 원본 테이블에서 보안이 필요한 속성을 제외하고 새로운 테이블을 정의하여 사용자에게 제공하여
-- 데이터 보안성을 높임
-- 논리적 데이터 독립성: 뷰를 정의하여 응용 프로그램이 사용하게 하면 개념스키마에 정의된
-- 테이블 구조가 변경되어도 응용 프로그램의 변경을 막아주어 논리적 데이터 독립성 제공

-- 뷰는 테이블처럼 사용할 수 있지만, select문을 제외한 일부 물리적인 테이블의 갱신 작업을 수행하는데 제약이 있음
-- ex) insert, update, delete 등의 dml 작업은 일반적으로 수행되지 않는다.

-- 뷰의 생성
-- 문법
-- create view 뷰이름 [(열이름[,...n])]
-- as <select 문>

-- book테이블에서 '축구'라는 문구가 포함된 자료만 보여주는 뷰
select * from book where bookname like '%축구%';

create view vw_book as select * from book where bookname like '%축구%';

select * from vw_book;
-- 뷰가 생성되면 일반 테이블처럼 사용할 수 있다.
-- 뷰는 실제 데이터가 저장되는 것이 아니라 뷰의 정의가 dbms에 저장되는 것이다.
-- book 테이블에 축구라는 문구를 포함한 도서가 새로 추가되면 이 데이터 역시 뷰에도 나타난다.
-- 만약 추가되는 도서이름에 '축구'라는 문구가 포함되어있지 않으면 book테이블에 존재하지만 
-- 뷰에서는 나타나지 않는다.

-- 주소에 대한민국을 포함하는 고객들로 구성된 뷰 생성, 조회
-- 뷰 이름: vw_customer
create view vw_customer as select * from customer
where address like '%대한민국%';

select * from vw_customer;
-- create view 문에 열이름에 대한 특별한 정의가 없으면 
-- vw_customer는 select문의 열이름을 그대로 가져와 뷰를 생성

-- orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후
-- 김연아 고객이 구입한 도서의 주문번호, 도서이름, 주문액 출력
-- 뷰 없이 select
select o.orderid, o.custid, c.name,
    o.bookid, b.bookname, o.saleprice, o.orderdate
from orders o, customer c, book b
where o.custid = c.custid and o.bookid = b.bookid;
-- 뷰 생성, 출력
create view vw_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
as select o.orderid, o.custid, c.name,
    o.bookid, b.bookname, o.saleprice, o.orderdate
from orders o, customer c, book b
where o.custid = c.custid and o.bookid = b.bookid;

select * from vw_orders;

select orderid, bookname, saleprice
from vw_orders;