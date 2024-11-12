-- 테이블 생성
-- part
CREATE TABLE part (
    partnumber  NUMBER NOT NULL,
    description VARCHAR2(60)
);
-- supplier
ALTER TABLE part ADD CONSTRAINT part_pk PRIMARY KEY ( partnumber );

CREATE TABLE supplier (
    suppid      NUMBER NOT NULL,
    name        VARCHAR2(20),
    suppaddress VARCHAR2(60)
);

ALTER TABLE supplier ADD CONSTRAINT supplier_pk PRIMARY KEY ( suppid );
-- payment
CREATE TABLE payment (
    suppid     NUMBER NOT NULL,
    partnumber NUMBER NOT NULL,
    price      NUMBER
);

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( suppid,
                                                            partnumber );

ALTER TABLE payment
    ADD CONSTRAINT order_part_fk FOREIGN KEY ( partnumber )
        REFERENCES part ( partnumber );

ALTER TABLE payment
    ADD CONSTRAINT order_supplier_fk FOREIGN KEY ( suppid )
        REFERENCES supplier ( suppid );
        
 
-- 데이터 삽입
-- Part
insert into part values(10, '20GB Disk');
insert into part values(20, '256MB RAM');
insert into part values(40, 'LCD MONITOR');
-- supplier
insert into supplier values(1, 'Seagate', 'CA');
insert into supplier values(2, 'IBM', 'NY');
insert into supplier values(3, 'Kensington', 'CA');
insert into supplier values(4, 'Samsung', 'Seoul');
-- payment
insert into payment values(1, 10, 100000);
insert into payment values(2, 10, 90000);
insert into payment values(3, 20, 22000);
insert into payment values(2, 20, 29000);
insert into payment values(4, 20, 31000);
insert into payment values(2, 40, 210000);

select * from Part;
select * from supplier;
select * from payment;

-- order
-- 테이블 생성
-- customer
CREATE TABLE tcustomer (
    custid  NUMBER NOT NULL,
    name    VARCHAR2(20),
    address VARCHAR2(60),
    city    VARCHAR2(60)
);

ALTER TABLE tcustomer ADD CONSTRAINT tcustomer_pk PRIMARY KEY ( custid );
-- part
CREATE TABLE tpart (
    partid   VARCHAR2(50) NOT NULL,
    partname VARCHAR2(50),
    price    NUMBER
);

ALTER TABLE tpart ADD CONSTRAINT tpart_pk PRIMARY KEY ( partid );
-- order
CREATE TABLE torder (
    custid     NUMBER NOT NULL,
    orderid    NUMBER NOT NULL,
    partid     VARCHAR2(50) NOT NULL,
    amount     NUMBER,
    order_date DATE
);

ALTER TABLE torder ADD CONSTRAINT torder_pk PRIMARY KEY ( orderid,
                                                          partid );

ALTER TABLE torder
    ADD CONSTRAINT torder_tcustomer_fk FOREIGN KEY ( custid )
        REFERENCES tcustomer ( custid );

ALTER TABLE torder
    ADD CONSTRAINT torder_tpart_fk FOREIGN KEY ( partid )
        REFERENCES tpart ( partid );
-- 데이터 삽입
-- customer
insert into tcustomer values(9876, '홍길동', '도봉구 101번지', '서울 대한민국');
-- part
insert into tpart values('A123', '연필', 1000);
insert into tpart values('B123', '지우개', 500);
insert into tpart values('C345', '샤프', 2000);

-- order
insert into torder values(9876, 1234, 'A123', 100, '2014/01/01');
insert into torder values(9876, 1234, 'B123', 200, '2014/01/01');
insert into torder values(9876, 1234, 'C345', 5, '2014/01/01');

select * from tcustomer;
select * from tpart;
select * from torder;


