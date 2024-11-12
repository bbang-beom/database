-- 이상현상의 발생과 해결 예
-- 잘못 설계된 계절학기 수강 테이블 예(계절학기 수강 정보를 저장하는 summer테이블)
-- 계절학기는 한 학생이 한 과목만 신청할 수 있다. summer테이블은 sid(학번), class(수강과목),
-- price(수강료)로 구성되어 있으며, 한 학생이 한 과목만 신청할 수 있으므로
-- sid(학번)가 키가 된다.

drop table summer;

create table summer(
    sid number,
    class varchar2(20),
    price number
);

insert into summer values(100, 'java', 20000);
insert into summer values(150, 'database', 15000);
insert into summer values(200, 'html5', 10000);
insert into summer values(250, 'javascript', 20000);

select * from summer;

-- 계절학기를 듣는 학생의 학번과 수강하는 과목
select sid, class from summer;

-- java강좌의 수강료
select price from summer where class = 'java';

-- 수강료가 가장 비싼 과목
select class from summer 
where price = (select max(price) from summer);

-- 계절학기를 듣는 학생 수와 수강료 총액
select count(*), sum(price) from summer;

-- select 문을 이용한 조회 작업은 별 문제없이 처리할 수 있다.
-- 그러나 데이터를 조작하는 작업의 경우 이상현상이 발생한다.

-- 삭제이상
-- 200번 학생이 수강신청을 취소하여 delete문으로 관련 투플을 삭제하였다.
-- 200번 학생의 수강신청은 잘 취소되었으나 한가지 문제가 있다.
-- 학생의 수강신청을 취소하면서 수강료도 함께 삭제하였기 때문에
-- 삭제 전에 조회할 수 있었던 c강좌의 수강료를 조회할 수 없게 되었다.
-- 200번 학생의 계절학기 수강신청 취소
select price "html5 수강료" from summer where class = 'html5';
delete from summer where sid = 200;
-- 취소 후 조회
select price "html5 수강료" from summer where class = 'html5';

-- 삽입이상
-- react 강좌 새로 개설, 수강료(price): 25000, 신청한 학생 없음
-- insert문에 학생이 없기에 학번에 null 입력
-- null값은 집계 함수 사용 시 원하지 않는 결과를 만들어낸다. null값이 포함된 테이블에
-- 집계 함수를 사용하면 어떤 문제가 발생하는지 sql문으로 확인

-- react 강좌 개설
-- react 강좌 삽입
insert into summer values (null, 'react', 25000);

-- summer 테이블 조회
select * from summer;

-- null 값이 있는 경우 주의할 점
-- 투플은 5개지만 수강학생은 총 4명
select count(*) "수강인원" from summer;
select count(sid) "수강인원" from summer;
select count(*) "수강인원" from summer where sid is not null;

-- 수정 이상
-- javascript 강좌의 수강료를 20000원에서 15000으로 변경
update summer set price = 15000 where class = 'javascript';
-- 조건을 잘못 주면 데이터 불일치 문제 발생
update summer set price = 15000 where class = 'javascript' and sid = 250;

drop table summerprice;
drop table summerenroll;

-- summerprice테이블 생성
create table summerprice(
    class varchar(20),
    price integer
);
insert into summerprice values('java', 20000);
insert into summerprice values('html5', 10000);
insert into summerprice values('database', 15000);
insert into summerprice values('javascript', 20000);

select * from summerprice;

--summerenroll테이블 생성
create table summerenroll(
    sid Integer,
    class varchar(20)
);

insert into summerenroll values(100, 'java');
insert into summerenroll values(150, 'database');
insert into summerenroll values(200, 'html5');
insert into summerenroll values(250, 'javascript');
insert into summerenroll values(300, 'javascript');

select * from summerenroll;

-- 삭제이상 없음
-- 200번 학생의 계절학기 수강신청 취소
select price "html 수강료" from summerprice where class = 'html5';
delete from summerenroll where sid = 200;

-- 삽입이상 없음
-- 계절학기에 react 강좌 개설
insert into summerprice values('react', 30000);
select * from summerprice;

-- 수정이상 없음
-- 자바 강좌의 수강료를 30000원으로 수정
update summerprice set price = 30000 where class = 'java';
select price "자바 수강료" from summerprice where class = 'java';

