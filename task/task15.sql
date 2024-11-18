-- hr 실습
-- sample
select * from employees;
select employee_id, first_name || last_name as "Name", salary, job_id, hire_date, manager_id
from employees;
-- 보너스 연봉
select first_name || ' ' || last_name as "Name", salary, (salary * 12 + 100) as "Increased Ann_Salary",
((salary + 100) * 12 ) as "Increased Salary" from employees;
-- 성(last_name)과 연봉 연결
select first_name || ': 1 Year Salary = $' || (salary * 12) as "Year Salary"
from employees;
-- 부서별로 담당하는 업무를 한번씩만 출력
select distinct department_id, job_id from employees;
-- sample2
select first_name || '' || last_name, salary from employees
where salary not between 7000 and 10000 order by salary;
-- 사원의 이름(last_name) 중 'e' 및 'o'가 포함된 사원 출력('e or o Name')
select last_name as "e or o Name" from employees
where last_name like '%e%' and last_name like '%o%';
-- 2006년05월20일~2007년05~20일에 고용된 사원들의 성과 이름(Name), 사원번호, 고용일자 출력
-- (입사일 순으로 정렬)
select first_name || ' ' || last_name as "Name", job_id, hire_date from employees
where hire_date between '2006/05/20' and '2007/05/20' order by hire_date;
-- 수당을 받는 모든 사원의 성과 이름, 급여, 업무, 수당률 출력(급여 순 정렬, 같으면 수당률 순)
select first_name || ' ' || last_name as "Name", salary, job_id, commission_pct 
from employees where commission_pct is not null order by salary desc, commission_pct desc;
-- smaple3
select employee_id, last_name || ' ' || first_name as "Name", salary,
Round(salary * 1.123, 0) as "Increased Salary" from employees
where department_id = 60;
-- 성(last_name)이 's'로 끝나는 사원의 이름과 업무를 출력
-- 이름(first_name)과 성(last_name)은 첫 자만 대문자, 업무는 모두 대문자,
-- 머리글은 "Employee JOBs."로 표시
select (INITCAP(first_name || ' ' || last_name) || 'is a' || UPPER(job_id)) 
as "Employee JOBs." from employees where last_name like '%s';
-- 모든 사원의 연봉 출력
-- 성과 이름, 급여, 수당여부(있으면 "Salary + commission", 없으면 "Salary only")
-- 출력은 연봉 순
select first_name || ' ' || last_name as "Name", salary, NVL2((salary * 12 * commission_pct), (salary * 12 + salary * commission_pct), (salary * 12)) as "Annual Salary",
NVL2(commission_pct, 'Salary + commission', 'Salary only') as "Commission ?" from employees
order by "Annual Salary" desc;
-- 모든 사원의 성과 이름, 입사일, 입사 요일을 출력(일요일부터 출력)
select first_name || ' ' || last_name as "Name", hire_date, TO_CHAR(hire_date, 'DAY') as "Day of week" 
from employees order by TO_CHAR(hire_date, 'D');
-- sample4
select count(distinct manager_id) as "Count Managers" from employees;
-- 각 사원의 부서별로 급여 합계, 급여 평균, 급여 최대,최소 값
-- 계산 값은 여섯 자리와 세자리 구분기호, $와 함께 출력
-- 부서번호의 오름차순 정렬(부서에 소속되지 않은 사원에 대한 정보는 제외, 머리글 별칭 처리)
select department_id, TO_CHAR(sum(salary), '$999,999.00') as "Sum Salary", TO_CHAR(avg(salary), '$999,999.00') as "Avg Salary",
TO_CHAR(max(salary), '$999,999.00') as "Max Salary", TO_CHAR(min(salary), '$999,999.00') as "Min Salary" 
from employees where department_id is not null group by department_id order by department_id;
-- 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력
-- 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력
select job_id, avg(salary) as "Avg Salary" from employees where job_id not like '%CLERK%'
group by job_id having avg(salary) > 10000 order by "Avg Salary" desc;
-- sample5
select * from employees;
select * from departments;
select * from locations;
select 'Han-Bit', (e.first_name || ' ' || e.last_name) as "Name", e.job_id,
d.department_name, l.city from employees e, departments d, locations l
where e.department_id = d.department_id and d.location_id = l.location_id
and l.city = 'Oxford';
-- 사원 수가 5명 이상인 부서의 부서명과 사원 수 출력(사원이 많은 순 정렬)
select d.department_name, count(*) from employees e, departments d
where e.department_id = d.department_id 
group by d.department_name having count(*) >= 5 order by count(employee_id) desc;
-- Job_Grades 테이블 생성
create table Job_Grades(
    grade_level varchar2(3),
    lowest_sal number,
    highest_sal number
);
insert into job_grades values('A', 1000, 2999);
insert into job_grades values('B', 3000, 5999);
insert into job_grades values('C', 6000, 9999);
insert into job_grades values('D', 10000, 14999);
insert into job_grades values('E', 15000, 24999);
insert into job_grades values('F', 25000, 40000);
commit;
select * from job_grades;
-- 각 사원의 성과 이름, 업무, 부서명, 입사일, 급여, 급여에 따른 급여 등급 출력
select (e.first_name || ' ' || e.last_name) as "Name", e.job_id, d.department_name,
e.hire_date, e.salary, j.grade_level from employees e, departments d, Job_Grades j
where e.department_id = d.department_id and e.salary between j.lowest_sal and highest_sal;
-- 어떤 사원이 어떤 사원에게 보고하는지 출력
-- 보고할 상사가 없는 사원도 포함하여 출력, 상사의 이름은 대문자
select (e1.first_name || ' ' || e1.last_name || ' reports to ' || UPPER(e2.first_name || ' ' || e2.last_name))
as "Employee vs Manager"
from employees e1, employees e2
where e1.manager_id = e2.employee_id(+);
-- sample6
select first_name || ' ' || last_name, job_id, salary from employees
where salary > (select salary from employees where last_name = 'Tucker');
-- 사원의 급여 중 업무별 최소 급여를 받고 있는 사원의 성과 이름, 업무, 급여, 입사일 출력
select e1.first_name || ' ' || e1.last_name as "Name", e1.job_id, e2.salary, e1.hire_date 
from employees e1, (select job_id, min(salary) as salary from employees group by job_id) e2
where e1.job_id = e2.job_id and e1.salary = e2.salary;
-- 소속 부서의 평균 급여보다 많은 급여를 받는 사원의 성과 이름, 급여, 부서번호, 업무 출력
select e1.first_name || ' ' || e1.last_name Name, e1.salary, e1.department_id, e1.job_id from employees e1,
(select department_id, avg(salary) salary from employees group by department_id) e2
where e1.department_id = e2.department_id and e1.salary > e2.salary;
-- 도시 이름이 영문 'O'로 시작하는 지역에 살고있는 사원의 사번, 성과 이름, 업무, 입사일 출력
select e.first_name || ' ' || e.last_name Name, e.job_id, e.hire_date 
from employees e, (select d.department_id as department_id from departments d, locations l where d.location_id = l.location_id
and l.city like 'O%') dl where e.department_id = dl.department_id;
-- 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 성과 이름, 업무, 급여, 부서번호, 부서 평균 연봉(Department Avg Salary) 출력
select e1.first_name || ' ' || e1.last_name Name, e1.job_id, e1.salary, e1.department_id, 
Round(e2.salary) as "Department Avg Salary"
from employees e1, (select department_id, avg(salary) as salary from employees group by department_id) e2
where e1.department_id = e2.department_id(+);
-- sample7
select employee_id, job_id from employees
union 
select employee_id, job_id from job_history;
-- 모든 사원의 업무 이력 전체
select employee_id, job_id, department_id from employees
union all 
select employee_id, job_id, department_id from job_history order by employee_id;
-- 업무 변경 없이 같은 업무를 보고 있는 사원의 사번과 업무 출력
select employee_id, job_id from employees
intersect 
select employee_id, job_id from job_history;
-- 위 결과를 이용하여 출력된 176번 사원의 업무 이력의 변경 날짜 이력 조회
select * from job_history;
select employee_id, job_id, NULL AS "start_date", NULL AS "end_date" from employees where employee_id = 176
union
select employee_id, job_id, start_date, end_date from job_history where employee_id = 176;
-- 한번도 업무가 변경되지 않은 사원의 사번 출력
select employee_id from employees
minus
select employee_id from job_history;

-- 데이터 삽입
-- teams
insert into teams (teamname, supervisor, hometown) values('롯데 자이언츠', '김태형', '부산');
-- games
insert into games values(4, '롯데 자이언츠', '한화 이글스', '사직 야구장', '2024/04/02', '롯데 승');
-- players
insert into players values(26, '윤동희', 'CF', '롯데 자이언츠', '대한민국', '2003/09/18');
-- batters
insert into batters values(23, 26, '윤동희', 6, 2, 1, 2);
-- pitchers
insert into pitchers values (9, 28, '윌커슨', 1, 9, 0, 10);
-- 경기를 뛰지 않은 선수
insert into batters (gameid, playerid, playername) values(37, 6, '강민호');



