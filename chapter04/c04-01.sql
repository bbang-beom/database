-- sql 고급
-- 01 내장 함수

-- 1. sql 내장 함수
-- 숫자 함수
-- 숫자 함수의 종류
-- 함수 | 설명 | 예
-- abs(숫자) | 숫자의 절대값 계산 | abs(-4.5) = 4.5
-- ceil(숫자) | 숫자보다 크거나 같은 최소의 정수 | ceil(4.1) = 5
-- floor(숫자) | 숫자보다 작거나 같은 최소의 정수 | floor(4.1) = 4
-- round(숫자, m) | m 자리를 기준으로 숫자 반올림 | round(5.36, 1) = 5.40
-- log(n, 숫자) | 숫자의 자연로그 값 반환 | log(10) = 2.30259
-- power(숫자, n) | 숫자의 n제곱 값 계산 | power(2, 3) = 8
-- sqrt(숫자) | 숫자의 제곱근 값 계산 | sqrt(9, 3) = 3.0
-- sign(숫자) | 숫자가 음수면 -1 0이면 0 양수면 1 | sign(3.45) = 1

-- -78과 78의 절대값
select abs(-78), abs(78) from Dual;
-- Dual테이블
-- Dual 테이블은 오라클에서 일시적인 연산 작업에 사용하기 위해 만든 가상의 테이블

-- 4.875를 소수 첫째 자리까지 반올림
select round(4.875, 1) from Dual;

-- 숫자 함수는 입력값으로 숫자 대신 열이름도 사용할 수 있다. 떠, 여러 함수를 복합적으로 사용할 수도 있다.

-- 고객별 평균 주문 금액을 백 원 단위로 반올림한 값
select custid as "고객 번호", round(sum(saleprice)/count(*), -2) as "평균 금액"
from orders group by custid;

-- 문자 함수
-- 문자 함수의 종류: 문자값을 반환하는 함수 (s: 문자열, c: 문자, n,k: 정수)
-- 함수 | 설명 | 예
-- chr(k) | 정수 아스키코드를 문자로 반환 | char(68) = 'D'
-- concat(s1, s2) | 두 문자열을 연결 | concat('마당', '서점') = '마당서점'
-- initcap(s) | 문자열의 첫 번째 알파벳을 대문자로 변환 | initcap('the soap') = 'The Soap'
-- lower(s) | 대상 문자열을 모두 소문자로 변환 | lower('MR.SCOTT') = 'mr.scott'
-- LPAD(s, n, c) | 대상 문자열의 왼쪽부터 지정한 자리수까지 지정한 문자로 채움 | LPAD('page 1', 10 '*') = '***page 1'
-- LTRIM(s1, s2) | 대상 문자열의 왼쪽부터 지정한 문자들을 제거 | LTRIM('<==>BROWNING<==>', '<>=') = 'BROWNING<==>'
-- REPLACE(s1, s2, s3) | 대상 문자열의 지정한 문자를 원하는 문자로 변경
-- | REPLACE('JACK and JUE', 'J', 'BL') = 'BLACK and BLUE'
-- SUBSTR(s, n, k) | 대상 문자열의 지정된 자리에서부터 지정된 길이만큼 잘라서 반환 | substr('abcdefg', 3, 4) = 'cdef'
-- trim(c from s) | 대상 문자열의 양쪽에서 지정된 문자를 삭제(문자열만 넣으면 기본값으로 공백 제거)
-- | trim('=' from '==>browning<==') = '>browning<'
-- upper(s) | 대상 문자열을 모두 대문자로 변환 | upper('mr.scott') = 'MR.SCOTT'
-- length(s) | 대상 문자열의 글자 수를 반환 | length('candide') = 7

-- 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서 목록 출력
select bookid, replace(bookname, '야구', '농구') bookname, publisher, price from book;

-- '굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 출력
select bookname as "제목", length(bookname) as "글자 수", length(bookname) as "바이트 수" 
from book where publisher = '굿스포츠';

-- 마당서점의 고객 중 같은 성을 가진 사람의 인원수
select substr(name, 1, 1) as "성", count(*) as "인원"
from customer
group by substr(name, 1, 1);

select * from customer;

insert into customer values(5, '박세리', '대한민국 서울', null);

-- 날짜, 시간 함수
-- 날짜 시간 함수의 종류
-- 함수 | 설명 | 예
-- to_date(char, datetime) | 문자형(char)테이블 date형으로 변환
-- | to_date('2020-09-14', 'yyyy-mm-dd'=2020-09-14)
-- to_char | date형 데이터를 문자열(varchar2)로 변환
-- | to_char(to_date('2020-09-14','yyyy-mm-dd'), 'yyyymmdd') = '20200914'
-- add_months(date, 숫자) | 날짜에 지정한 달을 더해 date형으로 변환(1:다음 달, -1:이전 달)
-- add_months(to_date('2020-09-14', 'yyyy-mm-dd'),12) = 2021-09-14
-- last_day(date) | 날짜에 달의 마지막 날을 date형으로 변환
-- | last_day(to_date('2020-09-14', 'yyyy-mm-dd')) = 2020-09-30
-- sysdate | dbms시스템상의 당일 날짜를 date형으로 반환하는 인자가 없는 함수
-- | sysdate = 20/09/20 

-- '-'와 '+'를 사용하여 원하는 날짜로부터 이전과 이후를 계산할 수 있다.
select to_date('2020-09-14', 'yyyy-mm-dd') + 5 as "before",
    to_date('2020-09-14', 'yyyy-mm-dd') - 5 as "after"
    from Dual;
    
-- 화이트 데이 때 100일이 되는 날짜
select to_date('2025-03-14', 'yyyy-mm-dd') - 100 as "100일 전" from Dual;

-- 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자 출력
select orderid "주문번호", orderdate "주문일", orderdate+10 "확정" from orders;

-- 날짜 포맷 형식
-- 예를 들어 2020년 7월 1일을 yyyymmdd로 쓰면 20200701이 된다.
-- 만약 14시 20분 같이 시각 정보도 포함하려면 yyyymmddhh24miss 형태로 쓰면 된다.
-- 결과는 20200701142014로 반환
select sysdate, to_char(sysdate, 'yy-mm-dd,hh24:ss') from dual;

-- 마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 출력
-- 주문일은 'yyyy-mm-dd 요일'형태로 표시
select orderid "주문번호", to_char(orderdate, 'yyyy-mm-dd day') "주문일", custid "고객번호", bookid "도서번호"
from orders where orderdate = TO_DATE('20200707', 'yyyymmdd');

-- sysdate 함수, systimestamp 함수
-- sysdate함수는 데이터베이스에 설정된 현재 날짜와 시간 반환
-- systimestamp함수는 현재 날짜, 시간과 함께 초 이하의 시간과 서버의 timezone까지 출력

-- dbms 서버에 설정된 현재 날짜와 시간, 요일을 확인
select sysdate, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') "sysdate_1" from dual;

-- null 값 처리
-- null 값: 아직 지정되지 않은 값, 값을 알 수 없고 적용할 수도 없다.
-- null 값은 비교 연산자로 비교할 수 없다.

-- null값에 대한 연산과 집계 함수
-- 집계 함수를 사용할 때 null값이 포함된 행에 대해 다음과 같은 주의가 필요하다.
-- null + 숫자 연산의 결과는 null
-- 집계 함수를 계산할 때 null이 포함된 행은 집계에서 빠진다.
-- 집계 함수에 적용되는 행이 하나도 없으면, sum, avg 함수의 결과는 null이 되고
-- count 함수의 결과는 0

create table mybook (
    bookid number primary key,
    price NUMBER
);

insert into mybook values(1,10000);
insert into mybook values(2,20000);
insert into mybook values(3,null);

select * from mybook;

select price + 100
from mybook
where bookid = 3;

select sum(price), avg(price), count(*), count(price) from mybook;

select sum(price), avg(price), count(*) from mybook
where bookid>=4;

-- null 값을 확인하는 방법- is null, is not null
-- null 값을 찾을 때 is null을 사용하고
-- null이 아닌 값을 찾을 때 is not null을 사용한다.
-- 빈문자열
select * from mybook where price = '';
-- null
select * from mybook where price is null;

-- nvl함수
-- nvl함수는 null값을 다른 값으로 대치하여 연산하거나 다른 값으로 출력
-- nvl함수는 nvl(속성, 값)형식으로 사용
-- '속성'이 null이면 '값'으로 대치

-- 이름, 전화번호가 포함된 고객목록 출력(null이면 '연락처 없음')
select name, nvl(phone, '연락처없음') as "전화번호" from customer;

-- rownum
-- rownum은 오라클 내장 함수는 아니지만 자주 사용되는 문법
-- rownum은 오라클 내부적으로 생성되는 가상 컬럼으로 sql 조회 결과의 순번을 나타낸다.
-- 자료를 일부분만 확인하여 처리할 때 유용하다.

-- 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오
select rownum "순번", custid, name, phone
from customer
where rownum <= 2;

-- rownum 사용 시 주의사항
-- 가나다순으로 정리된 고객목록에 고객번호, 이름, 전화번호를 앞의 두 명만 출력
select rownum, custid, name, phone from customer
where rownum <= 2
order by name;
-- where문을 order by문 보다 먼저 실행하기 때문에 원하는 결과가 나오지 않는다.

-- 오라클의 select문 처리 순서
-- 처리 순서 | 해당 문장 | 설명
-- 1 | from customer | customer 테이블을 읽음
-- 2 | where rownum <= 2 | 오라클이 데이터를 읽은 순서대로 두 개 투플 선택
-- 3 | select rownum, custid, name, phone | rownum, custid, name, phone 열을 선택
-- 4 | order by name | 이름순으로 정렬

-- 이 경우는 부속질의를 사용하여 먼저 정렬하면 원하는 결과를 얻을 수 있다.
select rownum, custid, name, phone 
from (select custid, name, phone from customer order by name)
where rownum <= 2;

