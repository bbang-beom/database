select * from book;
select * from customer;
select * from orders;
-- 도서번호가 1인 도서의 이름
select bookname from book where bookid = 1;
-- 가격이 20000원 이상인 도서의 이름
select bookname from book where price >= 20000;
-- 박지성의 총 구매액
select sum(saleprice) from orders group by custid having custid = 1;
-- 박지성이 구매한 도서의 수
select count(*) from orders group by custid having custid = 1;
-- 박지성이 구매한 도서의 출판사 수
select count(book.publisher) from book, orders where book.bookid = orders.bookid and orders.custid =1;
-- 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select book.bookname, book.price,(book.price - orders.saleprice) from book, orders where book.bookid = orders.bookid and orders.custid = 1;
-- 박지성이 구매하지 않은 도서의 이름
select book.bookname from book, orders where book.bookid = orders.bookid and orders.custid not in (1);
-- 서점 도서의 총수
select count(*) from book;
-- 서점에 도서를 출고하는 출판사의 총수
select publisher, count(publisher) from book group by publisher;
-- 모든 고객의 이름, 주소
select name, address from customer;
-- 2020년 7월 4일~ 7월 7일 사이에 주문받은 도서의 주문번호
select orderid, orderdate from orders where orderdate between '20/07/04' and '20/07/07';
-- 2020년 7월 4일~ 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
select orderid, orderdate from orders where orderdate not in (select orderdate from orders where orderdate between '20/07/04' and '20/07/07');
-- 성이 '김'씨인 고객의 이름과 주소
select name, address from customer where name like '김%';
-- 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
select name, address from customer where name like '김%아';
-- 주문하지 않은 고객의 이름(부속질의 사용)
select name from customer where name not in (select customer.name from customer, orders where customer.custid = orders.custid);
-- 주문 금액의 총액과 주문의 평균 금액
select sum(saleprice) as 총액, avg(saleprice) as "평균 금액" from orders;
-- 고객의 이름과 고객별 구매액
select customer.name, sum(orders.saleprice) from customer, orders where customer.custid = orders.custid group by customer.name;
-- 고객의 이름과 고객이 구매한 도서 목록
select customer.name, book.bookname from customer, book , orders
where customer.custid = orders.custid and book.bookid = orders.bookid order by customer.name;
-- 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
select book.bookname, max(book.price - orders.saleprice) from book, orders where book.bookid = orders.bookid group by book.bookname order by max(book.price - orders.saleprice) desc;
-- 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
select customer.name from customer, orders where customer.custid = orders.custid group by name having avg(orders.saleprice) > (select avg(book.price) from book);




