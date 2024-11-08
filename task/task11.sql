-- view 생성
create view salesmanview as 
select e.empno, e.ename, e.sal, d.dname from emp e, dept d
where e.deptno = d.deptno and job = 'SALESMAN';

-- 3행까지의 직원번호, 이름, 급여 출력
select empno, ename, sal from salesmanview
where rownum <= 3;

select * from salesmanview;

-- view를 이용한 새로운 view
create view salestop as 
select empno, ename, sal, dname from salesmanview
where sal >= 1500;

-- 1500이상의 급여를 갖는 직원들만 가진 뷰 출력
-- -> view를 이용한 새로운 view 정의 가능
select * from salestop;

-- index
-- 1
select name, address from customer where name like '박세리';

-- 2
-- 데이터베이스에서 데이터를 검색하고 가져오는 방법을 결정하는데 사용
-- 계획 설명에서 쿼리 실행에 필요한 단계를 보여주고 필요한 리소스 및 비용 정보 제공

-- 3
-- customer 테이블에 name으로 index 생성 후 (1) 실행 및 실행계획(f10)
create index name_index on customer(name);
select name, address from customer where name like '박세리';


-- 4
-- TABLE ACCESS 에 INDEX 추가, OBJECT_NAME에 NAME_INDEX 추가 
-- OBJECT_NAME에 CUSTOMER의 COST(비용)는 2로 감소
-- NAME_INDEX는 COST 1

-- 5
-- index 삭제
drop index name_index;

