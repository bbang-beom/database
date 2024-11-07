select abs(-15) from dual; -- 절대값
select ceil(15.7) from dual; -- 올림
select cos(3.14159) from dual; -- cosign
select floor(10.100) from dual; -- 내림
select mod(11,4) from dual; -- 나머지
select power(3, 2) from dual; -- 제곱
select round(15.7) from dual; -- 반올림
select sign(-15) from dual; -- 숫자가 음수면 -1 0이면 0 양수면 1
select trunc(15.7) from dual; -- 소수점 버림
select chr(67) from dual; -- 아스키코드를 문자로 변환
select concat('happy', 'birthday') from dual; -- 문자열 연결
select lower('Birthday') from dual; -- 소문자 변환
select lpad('Page 1', 15, '*') from dual; -- 대상 문자열의 왼쪽부터 지정한 자리수까지 지정한 문자로 채움
select ltrim('Page 1', 'ae') from dual; -- 대상 문자열의 왼쪽부터 지정한 문자들을 제거  
select replace('JACK', 'J', 'BL') from dual; -- 대상 문자열의 지정한 문자를 원하는 문자로 변경
select rpad('Page 1', 15, '*') from dual; -- 대상 문자열의 오른쪽부터 지정한 자리수까지 지정한 문자로 채움
select rtrim('Page 1', 'ae') from dual; -- 대상 문자열의 오른쪽부터 지정한 문자들을 제거  
select substr('ABCDEFG',3, 4) from dual; -- 대상 문자열의 지정된 자리에서부터 지정된 길이만큼 잘라서 반환
select trim(LEADING 0 FROM '00AA00') from dual; -- 대상 문자열의 양쪽에서 지정한 문자들을 제거
select upper('Birthday') from dual; -- 대문자 변환
select ASCII('A') from dual; -- 문자를 아스키코드로 변환
select instr('CORPORATE FLOOR', 'OR', 3, 2) FROM DUAL; -- 대상 문자열이 지정한 문자열에서 처음 나타나는 위치 반환
select length('Birthday') from dual; -- 문자열 길이 출력
select add_months('14/05/21', 1) from dual; -- 달(month) + 
select last_day(sysdate) from dual; -- 마지막 날짜 반환
select next_day(sysdate, '화') from dual; -- 다음 지정요일 날짜 반환
select round(sysdate) from dual; -- 마지막 날짜 반환 // 시간에 따라 일(day) 반올림
select sysdate from dual; -- 오늘 반환
select to_char(sysdate) from dual; -- date 문자열 변환
select to_char(123) from dual; -- number 문자열 변환
select to_date('12 05 2020', 'DD MM YYYY') from dual; -- 문자열 변환 DATE로 변환
select to_number('12.3') from dual; -- 문자열 number 변환
select decode(1, 1, 'aa', 'bb') from dual; -- 기준값(1)이 비교값1(1)이면 출력값1(aa) 비교값2(없음)면 출력값2(bb)
select nullif(123, 345) from dual; -- 기준값(123)이 null이면 출력값(345)출력 아니면 기준값 출력
select nvl(null, 123) from dual; -- 기준값이 null이면 출력값(123) 출력

create table mybook (
    bookid number primary key,
    price NUMBER
);

insert into mybook values(1,10000);
insert into mybook values(2,20000);
insert into mybook values(3,null);

-- 1
select * from mybook; -- 모든 투플 출력
-- 1 | 10000
-- 2 | 20000
-- 3 | null

-- 2
select bookid, nvl(price, 0) from mybook; -- null값은 0으로 바꿔 출력
-- 1 | 10000
-- 2 | 20000
-- 3 | 0

-- 3
select * from mybook where price is null; -- 가격이 null인 투플 출력
-- 3 | null

-- 4
select * from mybook where price = ''; -- 가격이 ''인 투플 출력
-- 결과 없음

-- 5
select bookid, price + 100 from mybook; -- price에 100 더해서 출력(null은 더해도 null)
-- 1 | 10100
-- 2 | 20100
-- 3 | null

-- 6
select sum(price), avg(price), count(*) from mybook where bookid >= 4; -- bookid가 4이상인 투플의 합, 평균, count 출력
-- 합, 평균은 없으면 null, count 는 0
-- null | null | 0

-- 7
select count(*), count(price) from mybook; -- 투플의 개수와 count price의 개수(null은 포함X)출력
-- 3 | 2

-- 8
select sum(price), avg(price) from mybook; -- price 합, 평균 출력
-- 30000 | 15000

-- 1
select * from book; -- book의 모든 투플 출력

-- 2
select * from book where rownum <= 5; -- 행 번호가 5 이하인 투플만 출력

-- 3
select * from book where rownum <= 5 order by price; 
-- where문을 order by문 보다 먼저 실행하기 때문에 원하는 결과가 나오지 않음

-- 4 
select * from (select * from book order by price) where rownum <= 5;
-- 부속질의를 사용하여 원하는 결과 출력(where보다 order by 먼저 실행)

-- 5
select * from (select * from book where rownum <= 5) b order by price;
-- 행 먼저 결정하고 price 순 정렬-> 원하는 결과 X(where이 먼저 실행)

-- 6
select * from (select * from book where rownum <= 5 order by price) b;
-- 5와 같음 where이 먼저 실행





