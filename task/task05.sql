-- 테이블 생성
create table employee(
    empno number primary key,
    name varchar2(20) not null,
    phoneno varchar2(40),
    address varchar2(20) not null,
    sex varchar2(20) not null,
    position varchar2(20) not null,
    deptno number not null,
    foreign key(deptno) references department(deptno) on delete cascade
);

create table department(
    deptno number primary key,
    deptname varchar2(20) not null,
    manager varchar2(20) not null
);

create table project(
    projno number primary key,
    projname varchar2(20) not null,
    deptno number not null,
    foreign key(deptno) references department(deptno) on delete cascade
);

create table works(
    empno number not null,
    projno number not null,
    hours_worked number,
    foreign key(empno) references employee(empno) on delete cascade,
    foreign key(projno) references project(projno) on delete cascade,
    primary key(empno, projno)
);

-- insert
-- department
insert into department VALUES (1, '인사', '홍길동');
insert into department VALUES (2, 'IT', '김철수');
insert into department VALUES (3, '법무', '박영희');
-- employee
insert into employee VALUES (1, '홍길동', '010-1234-5678', '강남', '남자', '팀장', 1);
insert into employee VALUES (2, '김철수', '010-1234-5679', '마포', '남자', '팀장', 2);
insert into employee VALUES (3, '박영희', '010-1234-5680', '잠실', '여자', '팀장', 3);
insert into employee VALUES (4, '고길동', '010-1234-5681', '송파', '남자', '사원', 1);
insert into employee VALUES (5, '이미애', '010-1234-5682', '강서', '여자', '사원', 2);
insert into employee VALUES (6, '최영희', '010-1234-5683', '서초', '여자', '사원', 3);
insert into employee VALUES (7, '정미애', '010-1234-5684', '광진', '여자', '대리', 2);
-- project
insert into project VALUES (1, '어플 개발', 2);
insert into project VALUES (2, '저작권 관리', 3);
insert into project VALUES (3, '인사 고과', 1);
-- works
insert into works VALUES (1, 3, 60);
insert into works VALUES (2, 1, 65);
insert into works VALUES (3, 2, 70);
insert into works VALUES (4, 3, 75);
insert into works VALUES (5, 1, 80);
insert into works VALUES (6, 2, 85);
insert into works VALUES (7, 1, 90);

select * from department;
select * from employee;
select * from project;
select * from works;

-- 질의
-- 모든 사원의 이름
select name from employee;
-- 여자 사원의 이름
select name from employee where sex = '여자';
-- 팀장의 이름
select name from employee where position = '팀장';
-- IT부서에 일하는 사원의 이름과 주소
select name, address from employee where deptno in (select deptno from department where deptname = 'IT');
-- 홍길동 팀장 부서에서 일하는 사원의 수
select count(*) from employee where deptno = (select deptno from department where manager = '홍길동');
-- 사원들이 일한 시간 수를 부서별, 사원 이름별 오름차순 정렬
select w.hours_worked, e.name, e.deptno from works w, employee e where w.empno = e.empno order by e.deptno, e.name;
-- 2명 이상의 사원이 참여한 프로젝트의 번호, 이름, 사원의 수
select w.projno, p.projname, count(*) from project p, works w where p.projno = w.projno
group by w.projno, p.projname having count(*) >= 2;
-- 3명 이상의 사원이 있는 부서의 사원 이름
select name, deptno from employee where deptno in (select deptno from employee group by deptno having count(*) >= 3);


