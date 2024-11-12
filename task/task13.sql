-- 테이블 생성
create table studentgrade(
    sid number,
    name varchar(20),
    address varchar(60),
    dept varchar(40),
    office varchar(50),
    class varchar(30),
    room varchar(40),
    grade number
);
-- 데이터 삽입
insert into studentgrade 
values (501,'박지성', '영국 맨체스터', '컴퓨터과', '공학관 110', '데이터베이스', '공학관 110', 3.5);
insert into studentgrade 
values (401,'김연아', '대한민국 서울', '체육학과', '공학관 110', '데이터베이스', '공학관 110', 4.0);
insert into studentgrade 
values (402,'장미란', '대한민국 강원도', '체육학과', '체육관 101', '스포츠경영학', '체육관 103', 3.5);
insert into studentgrade 
values (502,'추신수', '미국 클리블랜드', '컴퓨터과', '공학관 101', '자료구조', '공학관 111', 4.0);
insert into studentgrade 
values (501,'박지성', '영국 맨체스터', '컴퓨터과', '공학관 110', '자료구조', '공학관 111', 3.5);

select * from studentgrade;



-- sql
-- 컴퓨터과 학생들의 이름과 학번 출력
select sid, name from studentgrade where dept = '컴퓨터과';
-- 성적이 4.0이상인 학들의 이름과 학번 출력
select sid, name from studentgrade where grade >= 4.0;
-- 데이터베이스를 듣는 학생들 중 가장 성적이 높은 학생 출력
select sid, name from studentgrade where class = '데이터베이스' and grade = (select max(grade) from studentgrade where class = '데이터베이스');
-- 학과사무실과  다른 강의실에서 진행하는 강의, 강의실 출력
select distinct s1.class, s1.room, s2.office from studentgrade s1, studentgrade s2 where s1.class = s2.class and s1.room != s2.office;
-- 가장 적은 수강 학생을 가진 강의
select count(*), class from studentgrade group by class having count(*) = (select min(count(*)) from studentgrade group by class);

-- 수정
-- 김연아 학생의 성적을 4.5로 변경
update studentgrade set grade = 4.5 where name = '김연아';
-- 박지성 학생의 성적을 3.8로 변경
update studentgrade set grade = 3.8 where name = '박지성';
-- 박지성 학생 투플이 2개라 2개 모두 변경됨
-- 삭제
-- 추신수 학생 투플 삭제
delete from studentgrade where name = '추신수';
-- 박지성 학생 투플 삭제
delete from studentgrade where name = '박지성';
-- 박지성 학생 투플이 2개라 2개 모두 삭제됨
select * from studentgrade;

-- 병원
-- 병동 테이블 생성
create table ward (
    wardid number primary key,
    warname varchar(60)
);
-- 환자 테이블 생성
create table patient (
    patid varchar(60) primary key,
    patname varchar(60),
    roomid number,
    wardid number default 0,
    FOREIGN KEY (wardid) REFERENCES ward(wardid) on delete set null
);
-- 약 테이블 생성
create table medicine (
    medid number primary key,
    wardid number default 0,
    drugname varchar(60),
    prescribe varchar(60),
    method varchar(20),
    FOREIGN KEY (wardid) REFERENCES ward(wardid) on delete set null
);
-- 처방 테이블 생성
create table prescription(
    patid varchar(60),
    medid number default 0,
    measure number,
    start_date date,
    end_date date,
    FOREIGN KEY (patid) REFERENCES patient(patid) on delete cascade,
    FOREIGN KEY (medid) REFERENCES medicine(medid) on delete set null
);

-- 삽입
-- 병동
insert into ward values(11, '정형외과병동');
-- 환자
insert into patient values('P10034', 'MacDonald', 84, 11);
-- 약
insert into medicine values(10223, 11, 'Morphine', 'Pain Killer', '약물');
insert into medicine values(10334, 11, 'Testracyclene', 'Antibiotic', '주사');
-- 처방
insert into prescription values('P10034', 10223, 50, '24/03/13', '24/03/13');
insert into prescription values('P10034', 10334, 10, '24/03/13', '24/03/13');
insert into prescription values('P10034', 10223, 10, '24/04/09', '24/04/09');
select * from prescription;

-- 검색
-- 환자의 정보 출력
select * from patient;
-- MacDonald 환자가 받은 처방전 출력
select p.patid, p.patname, m.medid, m.drugname, pr.measure, m.method, pr.start_date, pr.end_date
from patient p, medicine m, prescription pr
where p.patid = pr.patid and m.medid = pr.medid and p.patname = 'MacDonald';
-- 수정
-- Testracyclene 복용법 약물로 변경
update medicine set method = '약물' where drugname = 'Testracyclene';
select * from medicine;
-- MacDonald 환자 병동 13으로 변경
update patient set roomid = 13 where patname = 'MacDonald';
-- 삭제
-- 약 Testracyclene 삭제
delete from medicine where drugname = 'Testracyclene';
select * from medicine;
select * from prescription; 
-- 처방전(prescription)은 제약조건으로 약(medicine)이 삭제되면 medid를 null로 하기로함(set null)
-- MacDonald 환자 삭제
delete from patient where patname = 'MacDonald';
select * from patient;
select * from prescription;
-- 처방전(prescription)은 제약조건으로 환자(patient)가 삭제되면 같이 사라짐(cascade)

