select * from book;
select * from customer;
select * from orders;
-- 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객 이름
select customer.name from orders, customer, book where orders.bookid = book.bookid
and orders.custid = customer.custid and publisher in (select publisher from orders, customer, book
where orders.bookid = book.bookid and orders.custid = customer.custid and customer.name = '박지성')
and customer.name != '박지성';
-- 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
select name from (select name, count(distinct publisher) cnt from customer, book, orders 
where customer.custid = orders.custid and book.bookid = orders.bookid group by name) where cnt >= 2;
-- 전체 고객의 30%이상 구매한 도서
select bookname from book, customer, orders where customer.custid = orders.custid 
and book.bookid = orders.bookid group by bookname 
having count(name) >= (select count(name) * 30 / 100 from customer);

select * from customer c1 where not exists (select * from orders c2 where c1.custid = c2.custid);
-- 5 박세리 대한민국 대전 null
select * from customer c1 where exists (select * from orders c2 where c1.custid = c2.custid);
-- 박세리를 제외한 모든 내용 출력

-- 테이블 생성
 create table theater(
    theaterid number primary key,
    name varchar2(20) not null,
    rocation varchar2(20) not null
    );
    
 create table room(
    roomid number primary key check(roomid between 1 and 10),
    title varchar2(20) not null,
    price number check(price < 20000),
    seat number,
    foreign key(theaterid) references theater(theaterid) on delete cascade
    );
create table reserveation(
    seatnumber number unique,
    date Date,
    foreign key(roomid) references room(roomid) on delete cascade,
    foreign key(theaterid) references theater(theaterid) on delete cascade,
    foreign key(customerid) references customer(customerid) on delete cascade
);
create table customer(
    customerid number primary key,
    name varchar2(20) not null,
    address varchar2(20) not null
);

-- 테이블 생성2
create table customer(
    name varchar2(20) primary key,
    city varchar2(20) not null,
    industrytype varchar2(20) not null
);

create table saleperson(
    name varchar2(20) primary key,
    age number not null,
    salary number not null
);

create table order(
    number number not null,
    amount number not null,
    foreign key(custname) references customer(name) on delete cascade,
    foreign key(saleperson) references saleperson(name) on delete cascade
);

-- 테이블 생성3
create table employee(
    empno number primary key,
    name varchar2(20) not null,
    phoneno number,
    address varchar2(20) not null,
    sex varchar2(20) not null,
    position varchar2(20) not null,
     foreign key(deptno) references department(deptno) on delete cascade
);

create table department(
    deptno number primary key,
    deptname varchar2(20) not null,
    manager varchar2(20) not null
);

create table project(
    projno number primary key,
    projname varchar2(20) not null,
    foreign key(empno) references employee(empno) on delete cascade,
    foreign key(deptno) references department(deptno) on delete cascade
);

create table works(
    hours_worked number,   
    foreign key(empno) references employee(empno) on delete cascade,
    foreign key(projno) references project(projno) on delete cascade
);