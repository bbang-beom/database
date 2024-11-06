-- 테이블 생성
 create table theater(
    theaterid number primary key,
    name varchar2(20) not null,
    rocation varchar2(20) not null
    );
 create table room(
    theaterid number not null,
    roomid number check(roomid between 1 and 10),
    title varchar2(20) not null,
    price number check(price <= 20000),
    seat number,
    foreign key(theaterid) references theater(theaterid) on delete cascade,
    primary key(theaterid, roomid)
    );
create table reservation(
    theaterid number not null,
    roomid number check(roomid between 1 and 10),
    customerid number not null,
    seatnumber number unique,
    reservation_date Date,
    foreign key(theaterid, roomid) references room(theaterid, roomid) on delete cascade,
    foreign key(customerid) references theater_customer(customerid) on delete cascade,
    primary key(theaterid, roomid, customerid)
);
create table theater_customer(
    customerid number primary key,
    name varchar2(20) not null,
    address varchar2(20) not null
);
select * from theater;
-- 데이터 입력
insert into theater (theaterid, name, rocation) VALUES (1, '롯데', '잠실');
insert into theater (theaterid, name, rocation) VALUES (2, '메가', '강남');
insert into theater (theaterid, name, rocation) VALUES (3, '대한', '잠실');

select * from room;
-- 데이터 입력
insert into room VALUES (1, 1, '어려운 영화', 15000, 48);
insert into room VALUES (3, 1, '멋진 영화', 7500, 120);
insert into room VALUES (3, 2, '재밌는 영화', 8000, 110);

select * from theater_customer;
-- 데이터 입력
insert into theater_customer VALUES (3, '홍길동', '강남');
insert into theater_customer VALUES (4, '김철수', '잠실');
insert into theater_customer VALUES (9, '박영희', '강남');

select * from reservation;
-- 데이터 입력
insert into reservation VALUES (3, 2, 3, 15, '2020-09-01');
insert into reservation VALUES (3, 1, 4, 16, '2020-09-01');
insert into reservation VALUES (1, 1, 9, 48, '2020-09-01');



-- 단순 질의
-- 모든 극장의 이름과 위치
select name, rocation from theater;
-- 잠실에 있는 극장
select name, rocation from theater where rocation = '잠실';
-- 잠실에 사는 고객의 이름을 오름차순
select name, address from theater_customer where address = '잠실' order by name;
-- 가격이 8000원 이하인 영화의 극장번호, 상영관번호, 영화제목
select theaterid, roomid, title from room where price >= 8000;
-- 극장 위치와 고객의 주소가 같은 고객
select name, address from theater_customer where address in (select rocation from theater);

-- 집계 질의
-- 극장의 수
select count(*) from theater;
-- 상영되는 영화의 평균 가격
select avg(price) as "평균 가격" from room;
-- 2020년 9월 1일에 영화를 관람한 고객의 수
select count(customerid) from reservation group by reservation_date having reservation_date = '2020-09-01';

-- 부속 질의
-- 대한극장에서 상영된 영화제목
select r.title from room r where r.theaterid = (select t.theaterid from theater t where t.name = '대한'); 
-- 대한극장에서 영화를 본 고객의 이름
select c.name from theater_customer c
where c.customerid in (select re.customerid from reservation re where re.theaterid = 
(select t.theaterid from theater t where t.name = '대한'));
-- 대한 극장의 전체 수입
select sum(r.price) from room r where r.theaterid in 
(select re.theaterid from reservation re where re.theaterid = 
(select t.theaterid from theater t where t.name = '대한')) group by r.theaterid;

-- 그룹 질의
-- 극장별 상영관 수
select count(r.roomid) from room r group by r.theaterid;
-- 잠실에 있는 극장의 상영관
select r.theaterid, r.roomid from room r where r.theaterid in (select t.theaterid from theater t where t.rocation = '잠실');
-- 2020년 9월 1일의 극장별 평균 관람 고객 수
select  r.theaterid, count(customerid) from reservation r where r.reservation_date = '2020-09-01' group by r.theaterid;
-- 2020년 9월 1일에 가장 많은 고객이 관람한 영화
select r.title, count(*) from room r, reservation re 
where r.theaterid = re.theaterid and r.roomid = re.roomid and re.reservation_date = '2020-09-01'
group by r.title having count(*) = (select max(cnt) from (select count(*) as cnt from room r, reservation re 
where r.theaterid = re.theaterid and r.roomid = re.roomid and re.reservation_date = '2020-09-01' group by r.title));

-- DML
-- 각 테이블에 데이터 삽입
-- theater
insert into theater (theaterid, name, rocation) VALUES (4, 'CGV', '강남');
-- room
insert into room VALUES (1, 2, '무서운 영화', 10000, 100);
-- theater_customer
insert into theater_customer VALUES (10, '이미애', '잠실');
-- reservation
insert into reservation VALUES (1, 2, 10, 60, '2020-09-01');

-- 영화의 가격을 10%씩 인상
Update room set price = price * 1.1;
select * from room;

