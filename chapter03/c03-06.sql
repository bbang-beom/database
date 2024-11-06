-- 데이터 조작어 - 삽입, 수정, 삭제
-- 만들어진 테이블에 투플을 삽입, 삭제, 수정

-- insert문
-- insert문은 테이블에 새로운 투플 삽입하는 명령
-- 문법
-- insert into 테이블 [테이블(속성 리스트)] values (값리스트);

-- book 테이블에 새로운 도서 '스포츠 의학' 삽입, 출판사: 한솔의학서적, 가격: 90000원
insert into book(bookid, bookname, publisher, price) values(11, '스포츠 의학', '한솔의학서적', 90000);

-- 프로그래밍 언어와 sql문을 주로 다루기 때문에
-- 자바스크립트를 예로 들어
-- const addBookSql = "insert into book(bookid, bookname, publihser, price)
-- values(11, '스포츠의학', '한솔의학서적', 90000);
-- 프로그래밍 언어와 충돌을 피하기 위해 sql문의 문자열은 작은 따옴표를 사용한다.

-- sql문으로 확인
select * from book;

-- 새로운 투플을 삽입할 때 속성의 이름은 생략할 수 있다. 이 때 데이터의 입력 순서는 속성의 순서와 일치해야한다.
insert into book values(12, '스포츠 의학', '한솔의학서적', 9000);

-- 데이터는 항상 속성의 순서대로 입력하지 않아도 된다. 만약 price를 publisher 앞에 입력하고 싶다면
-- 속성의 이름과 데이터의 순서를 바꾸면 된다.
insert into book(bookid, bookname, price, publisher) values (13, '스포츠 의학', 90000, '한솔의학서적');

-- 만약 몇 개의 속성만 입력해야 한다면 해당되는 속성만 명시하면 된다.
-- book테이블에 새로운 도서 '스포츠 의학'을 삽입, 출판사: 한솔의학서적, 가격: 미정
insert into book(bookid, bookname, publisher) values(14, '스포츠 의학', '한솔의학서적');

-- insert 문은 select문을 사용하여 작성할 수 있다.
-- imported_book이라는 테이블이 있다.
-- 데이터베이스는 일반적으로 단어가 조합될 때 언더바(_)를 주로 사용한다.
select * from imported_book;
-- 수입도서 목록(imported_book)을 book 테이블에 모두 삽입
insert into book(bookid, bookname, price, publisher)
    select bookid, bookname, price, publisher
    from imported_book;
    
select * from book;

-- update문
-- update문은 특정 속성값을 수정하는 명령
-- 문법
-- update 테이블 이름
-- set 속성이름1 = 값1[, 속성이름2 = 값2...]
-- [where <검색조건>];

-- customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경
update customer set address = '대한민국 부산' where custid = 5;

select * from customer;

-- update문은 다른 테이블의 속성값을 이용할 수도 있다.
-- customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경
update customer set address = (select address from customer where name = '김연아') where name = '박세리';

-- update문 작성 시 주의사항
-- update문에서 여러 속성 값을 한번에 수정하는 작업은 가능하다.
-- update customer
-- set address = '대한민국 서울'
-- 위 sql문은 모든 고객의 주소를 서울로 바꾸는 문장이다.
-- 잘못 수정된 데이터를 다시 되돌릴 수 있지만, 경우에 따라 문제가 발생하므로 주의하자

-- delete문
-- delete문은 테이블에 있는 기존 투플을 삭제하는 명령이다.
-- 문법
-- delete from 테이블 이름
-- [where 검색조건];
-- delete문은 <검색조건>에 해당되는 투플을 삭제한다. <검색조건>이 없으면 모든 투플을 삭제한다.
-- customer 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인
delete from customer where custid = 5;
select * from customer;

-- commit문과 rollback문
-- insert, delete, update문의 결과는 최종적으로 commit문을 만나지 않으면 실제로 데이터베이스에 반영되지 않는다.
rollback;

select * from customer;

delete from customer where custid = 5;

-- 삭제 작업을 commit 명령어로 데이터베이스에 삭제 작업을 반영시킨다.
commit;
-- 반영 후에는 rollback 작업을 수행해도 삭제된 데이터의 복원이 불가능하다.
rollback;
select * from customer;
-- 모든 고객 삭제
delete from customer;
-- orders테이블에서 customer.custid 속성을 외래키로 참조하기 때문에 위 sql문은 실행되지 않는다.
-- 제약이 해제되지 않으면 데이터 삭제가 중지된다.
