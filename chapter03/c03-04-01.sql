-- 집계 함수와 group by 검색
-- 집계를 위해 group by 문을 사용하고 구체적인 내용은 집계 함수를 사용

-- 집계 함수
-- 집계 함수는 테이블의 각 열에 대해 계산을 하는 함수로 sum, avg, min, count가 있다.

-- 주문 테이블의 모든 정보
select * from orders;

-- 고객이 주문한 도서의 총 판매액
select sum(saleprice) from orders;

-- 별칭을 사용하여 다시 출력
select sum(saleprice) as "총매출" from orders;

-- 집계 함수는 where 문과 같이 사용하면 더 유용하다.
-- 2번 김연아 고객이 주문한 도서의 총판매액
select * from customer;
select * from orders;
select sum(saleprice) as "총매출" from orders where custid = 2;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가
select sum(saleprice) as total, avg(saleprice) as average, min(saleprice) as "minimum",
        max(saleprice) as "maximum" from orders;
        
-- 집계 함수 count는 행의 개수를 센다.
-- count() 괄호 안에 * 혹은 속성의 이름을 사용한다.
-- 해당 속성의 투플의 개수를 세준다(null 제외)

-- 도서 판매 건수
select count(*) from orders;

-- group by 검색
-- sql문에서 group by 절을 사용하면 같은 속성값끼리 그룹을 만들 수 있다.

-- 고객별로 주문한 도서의 총수량과 총판매액
select custid, sum(saleprice), count(*) from orders group by custid;

-- having 절은 group by 절의 결과가 나타나는 그룹을 제한하는 역할을 한다.
-- 가격이 8000원 이상인 도서를 구매한 고객에 대해 고객별 주문 도서의 총수량
-- (2권 이상 구매한 고객만)
select custid, count(*) as 도서수량 from orders where saleprice >= 8000
group by custid having count(*) >= 2;

-- group by와 having 절의 문법과 주의사항
-- group by <속성>
-- 주의 사항
-- group by로 투플을 그룹으로 묶은 후 select 절에는 group by에서 사용한 <속성>과
-- 집계 함수만 나올 수 있다.
-- having 절은 반드시 group by 절과 같이 작성해야한다.
-- having 절은 where절보다 뒤에 나와야 한다.
-- having 절의 검색 조건에는 sum, avg, min, max, count와 같은 집계 함수가 나와야한다.

-- group by 절이 포함된 sql문의 실행 순서
-- sql문은 실행 순서가 없는 비절차적인 언어지만 sql문은 내부적으로 실행순서가 있다.
select custid, count(*) as 도서수량 -- 5
from orders -- 1
where saleprice >= 8000 -- 2
group by custid -- 3
having count(*) >= 2 -- 4
order by custid; -- 6

