-- 04 index
-- index와 B-tree
-- index란 자료를 쉽고 빠르게 찾을 수 있도록 만든 데이터 구조
-- 데이터베이스에서 index란 원하는 데이터를 빨리 찾기위해 투플의 키값에 대한 물리적 위치를 기록해 둔 자료구조
-- 일반적인 RDBMS의 index는 대부분 B-tree구조로 되어있다.

-- B-tree(Balanced-tree)는 데이터의 검색 시간을 단축하기 위한 자료 구조
-- B-tree는 루트 노드, 내부 노드, 리프 노드로 구성, 리프 노드가 모두 같은 레벨에 존대

-- 오라클 index
-- index 생성
-- 경우에 따라 index는 검색이 더 느려지고 저장 공간만 낭비하게 된다.
-- 따라서, index 생성에 앞서 고려사항을 충분히 살펴봐야 한다.
-- index는 where절에 자주 사용되는 속성이어야 한다.
-- index는 조인에 자주 사용되는 속성이어야 한다.
-- 단일 테이블에 index가 많으면 속도가 느려질 수 있다.(테이블당 4~5개 정도 권장)
-- 속성이 가공되는 경우 사용하지 않는다.
-- 속성의 선택도가 낮을 때 유리(속성의 모든 값이 다른 경우)

-- index 생성 문법
-- create [reverse] [unique] index [인덱스이름]
-- on 테이블이름 (컬럼 asc|desc) [{,컬럼[asc|dexc]}...])[;]
-- reverse는 역순으로 index 생성
-- unique는 테이블의 속성값에 대해 종복이 없는 유일한 index 생성
-- asc | desc는 컬럼 값의 정렬 방식을 의미한다.

-- book 테이블의 bookname열을 대상으로 index ix_book 생성
create index ix_book on book(bookname);

-- book 테이블의 publisher, price 열을 대상으로 index ix_book2 생성
create index ix_book2 on book(bookname, price);

-- 오라클이 생성된 index를 활용하여 sql문을 처리하는지 확인하려면 sql developer에서
-- sql문을 실행하기 전에 f10키를 누르면 된다. 실행 계획이 나타나면서 
-- index를 활용하여 결과를 출력하는 과정을 볼 수 있다.
select * from book
where publisher = '대한미디어' and price >=30000;

-- index의 재구성과 삭제
-- index의 재구성 문법
-- alter [reverse] [unique] index index이름
-- [on {only]테이블 이름 (컬럼이름[{,컬럼이름}...)] rebuild[;]

-- B-tree index는 데이터 수정, 삭제, 삽입이 잦으면 노드의 갱신이 주기적으로 일어나
-- 단편화 현상이 일어난다. 단편화란 삭제된 레코드의 index값 자리가 비게되는 상태를 말한다.

-- index ix_book 재생성
alter index ix_book rebuild;

-- 하나의 테이블에 index가 많으면 데이터베이스 성능에 좋지않은 영향을 미친다.
-- 그러므로 사용하지 않는 index는 삭제해야한다.
-- index 삭제문법
-- drop index index이름[;]

-- index ix_bbok 삭제
drop index ix_book;

-- 데이터베이스 성능을 향상시키는 것을 테이터베이스 튜닝이라 한다.
-- 데이터베이스 튜닝에 index를 활용할 수 있다.
-- 원초적인 해결은 데이터를 분리 저장해서 검색대상을 줄여 속도를 대폭적으로 개선하는 방법이다.
