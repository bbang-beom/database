-- 각 테이블에 대해 기본키, 외래키 표시
-- JOB_HISTORY
-- 기본키: (EMPLOYY_ID, START_DATE)
-- 외래키: START_DATE, job_ID, DEPARTMENT_ID

-- DEPARTMENTS
-- 기본키: DEPARTMENT_ID
-- 외래키: MANAGER_ID, LOCATION_ID

-- LOCATIONS
-- 기본키: LOCATION_ID
-- 외래키: country_ID

-- JOBS
-- 기본키 : JOB_TITLE
-- 외래키 : 없음

-- JOB_GRADES
-- 기본키 : 없음
-- 외래키 : 없음

-- EMPLOYEES
-- 기본키 : EMPLOYY_ID
-- 외래키 : MANAGER_ID, DEPARTMENT_ID

-- COUNTRIES
-- 기본키 : country_ID
-- 외래키 : REGION_ID

-- REGIONS
-- 기본키 : REGION_ID
-- 외래키 : 없음

-- 테이블의 구조
-- 테이블에서 각 테이블 조회하면 나옴
-- ex) countries
-- coulumn name | data_type          | nullable | column_id | comments
-- COUNTRY_ID   |	CHAR(2 BYTE)     |	No		|   1       | Primary key of countries table.
-- COUNTRY_NAME |	VARCHAR2(40 BYTE)|	Yes		|   2	    | Country name
-- REGION_ID    |	NUMBER	         |   Yes	|	3	    | Region ID for the country. Foreign key to region_id column in the departments table.

-- employees, departments 테이블에 저장된 투플의 개수
select count(*) from employees;
select count(*) from departments;
-- employees테이블에 대한 employee_id, last_name, hire_date 출력
select employee_id, last_name, hire_date from employees;
-- employees 테이블에서 salary가 12000 이상인 직원의 last_name, salary 출력
select last_name, salary from employees where salary >= 12000;
-- 부서번호(department_id)가 20 혹은 50인 직원의 last_name과 salary department_id + last_name 오름차순 정렬
select last_name, department_id from employees where department_id = 20 or department_id = 50 order by last_name;
-- last_name의 세번째에 a가 들어가는 직원의 last_name을 출력
select last_name from employees where last_name like '__a%';
-- 같은 일(job)을 하는 사람의 수 출력
select count(*), job_id from employees group by job_id;
-- 급여(salary)의 최댓값, 최솟값의 차이
select (max(salary) - min(salary)) as "최대 급여 - 최소 급여" from employees;
-- Toronto에서 일하는 직원의 last_name, department_id, department_name 출력
select e.last_name, d.department_id, d.department_name from employees e, departments d 
where e.department_id = d.department_id and d.location_id = (select location_id from LOCATIONS where city = 'Toronto');
