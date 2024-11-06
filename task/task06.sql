
drop table emp;
drop table dept;
drop table salgrade;

CREATE TABLE DEPT (
  DEPTNO integer NOT NULL,
  DNAME varchar(14) DEFAULT NULL,
  LOC varchar(13) DEFAULT NULL,
  PRIMARY KEY (DEPTNO)
);

INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES(20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES(30, 'SALES', 'CHICAGO');
INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES(40, 'OPERATIONS', 'BOSTON');

CREATE TABLE EMP(
  EMPNO integer NOT NULL PRIMARY KEY,
  ENAME varchar(10) DEFAULT NULL,
  JOB varchar(9) DEFAULT NULL,
  MGR integer DEFAULT NULL,
  HIREDATE date DEFAULT NULL,
  SAL integer DEFAULT NULL,
  COMM integer DEFAULT NULL,
  DEPTNO integer DEFAULT NULL,
  FOREIGN KEY (deptno) REFERENCES Dept(deptno)
);

INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000, NULL, 20);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100, NULL, 20);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);

CREATE TABLE SALGRADE(
GRADE INTEGER,
LOSAL INTEGER,
HISAL INTEGER
);

INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);

select * from emp; 
select * from dept;
select * from SALGRADE;

-- 사원의 이름과 업무 출력
select ename as "사원 이름", job as "사원 업무" from emp;
-- 30번 부서에 근무하는 모든 사원의 이름과 급여
select ename, sal from emp where deptno = 30;
-- 사원번호와 이름, 현재 급여, 증가된 급여분(증가액), 10% 인상된 급여(인상된 급여)를 사원번호 순 출력
select ename, sal as "현재 급여", (sal * 1.1 - sal) as "증가액", (sal * 1.1) as "인상된 급여" from emp order by empno;
-- S로 시작하는 모든 사원과 부서번호 출력
select ename, deptno from emp where ename like 'S%';
-- 모든 사원의 최대 및 최소 급여, 합계 및 평균 급여 출력
select max(sal) as MAX, min(sal) as MIN, sum(sal) as SUM, Round(avg(sal)) as AVG from emp;
-- 업무 이름과 업무별로 동일한 업무를 하는 사원의 수
select job as "업무", count(*) as "업무별 사원 수" from emp group by job;
-- 사원의 최대 급여와 최소 급여의 차액
select (max(sal) - min(sal)) as "차액" from emp;
-- 30번 부서의 사원 수와 사원들 급여의 합계와 평균
select sum(sal) as SUM, Round(avg(sal)) as AVG from emp group by deptno having deptno = 30;
-- 평균 급여가 가장 높은 부서의 번호
select deptno from emp group by deptno having avg(sal) = (select max(avg(sal)) from emp group by deptno);
-- 세일즈맨(salesman)을 제외하고, 각 업무별 사원의 총급여가 3000 이상인 각 업무에 대해서 업무명과 각 업무별 평균 급여 출력(평균 급여 내림차순)
select job, avg(sal) from emp group by job having job != 'salsman' and avg(sal) >= 3000 order by avg(sal) desc;
-- 전체 사원 가운데 직속상관이 있는 사원의 수를 출력
select count(*) from emp e1 , emp e2 where e1.empno = e2.mgr;
-- emp 테이블에서 이름, 급여, 커미션 금액, 총액을 구하여 총액이 많은 순서대로 출력
select ename, sal, comm, (sal * 12 + comm) as "total" from emp where comm is not null order by (sal * 12 + comm) desc;
-- 각 부서 별 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무 이름, 인원수를 출력
select deptno, job, count(*) from emp group by deptno, job;
-- 사원이 1명도 없는 부서의 이름 출력
select dname from dept where deptno not in (select deptno from emp);
-- 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원 수
select job, count(*) from emp group by job having count(*) >= 4;
-- 사원번호가 7400 이상 7600 이하인 사원의 이름
select ename from emp where empno between 7400 and 7600;
-- 사원의 이름과 사원의 부서이름 출력
select e.ename, d.dname from emp e, dept d where e.deptno = d.deptno;
-- 사원의 이름과 팀장(mgr)의 이름 출력
select e1.ename, e2.ename from emp e1, emp e2 where e1.mgr = e2.empno;
-- 사원 SCOTT보다 급여를 많이 받는 사람의 이름 출력
select ename from emp where sal > (select sal from emp where ename = 'SCOTT');
-- 사원 SCOTT이 일하는 부서번호 혹은 DALLAS에 있는 부서번호를 출력
select e.deptno from emp e where deptno = (select deptno from emp where ename = 'SCOTT') 
or e.deptno = (select deptno from dept where loc = 'DALLAS');







