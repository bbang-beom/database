-- 데이터베이스 보안과 관리
-- 01 보안과 권한
-- 1. 오라클 DBMS 구조 및 접근 권한
-- 오라클 데이터베이스는 multi-tenant 구조로 이루어져 있다.
-- multi-tenant는 여러 데이터베이스(PDB-pluggable DB)를 하나의 물리적 데이터베이스에 구현하는
-- '다중 데이터베이스' 구현 기능이다.
-- 이는 오라클 12c부터 지원하는 기능으로 CDB(Container DB)라는 부모 데이터베이스에
-- PDB라는 여러 자식 데이터베이슬르 만들어 각 자식 데이터베이스는 독립적으로 동작할 수 있게하는 기술이다.
-- 오라클 DBMS는 이러한 multi-tenant 구조하에서 로그인 단계에서 DBMS 접근을 제한하는
-- 로그인 사용자 관리와 로그인한 사용자별로 특정 데이터로의 접근을 제한하는 권한관리 기능을 제공하게 된다.

-- 테이블스페이스와 로그인 사용자 관리
-- CDB USER인 c##madang을 만들고 사용하였다.
-- 이를 PDB 기준으로 진행한다.

-- 테이블스페이스 생성
-- 테이블스페이스는 오라클에서 데이터를 저장할 때 사용하는 논리적인 저장공간을 의미한다.
-- 자동으로 만들어지는 시스템 테이블스페이스와 사용자가 필요에 따라 만들어 사용하는 사용자 테이블스페이스가 있다.

-- create tablespace는 테이블스페이스 생성 시 사용하는 명령이다.
-- 문법
-- create tablespace 테이블스페이스명
-- detafile '저장될 경로 및 사용할 파일명'
-- size 저장공간

-- 10M의 용량을 가진 테이블스페이스 md_tbs, md_test를 c:\madang\oracledata 폴더에 생성
-- 파일이름은 md_tbs_data01.dbf, md_test_data01.dbf
create tablespace md_tbs datafile 'C:\madang\oracle\md_tbs_data01.dbf' size 10M;
create tablespace md_test datafile 'C:\madang\oracle\md_test_data01.dbf' size 10M;

-- drop tablespace는 테이블스페이스 삭제 시 사용하는 명령
-- drop tablespace 테이블스페이스명
-- [including contents [and datafiles] [cascade constraints]];
-- including contents: 테이블스페이스의 모든 데이터를 삭제
-- and datafiles: os상의 물리적인 데이터 파일을 삭제(이 옵션이 없다면 실제 데이터 파일은 삭제되지 않는다.)
-- cascade constraints: 다른 테이블스페이스의 테이블로부터 참조되는 제약조건들까지 모두 삭제



-- 오라클 pdb 생성
-- sysdba 계정 접속 
-- pdb 생성
-- create pluggable database "{pdb 이름}"
-- admin user "{dba id}" identified by "{password}" roles = {dba}
-- pdb 생성 확인
-- select * from V$PDBS;

-- 신규 사용자 계정 생성
-- create user
-- 문법
-- create user [사용자 이름]
-- identified by [비밀번호]
-- default tablespace [테이블스페이스];
-- default tablespace를 지정하지 않으면 오라클에서 기본으로 users 테이블스페이스를 할당한다.

-- alter user
-- 문법
-- alter user [사용자이름]
-- identified by [비밀번호];

-- drop user
-- 문법
-- drop user [사용자이름] cascade;
-- cascade를 사용하면 삭제 시점에 사용자가 보유한 모든 데이터를 같이 삭제한다.

-- (pdb1_system 계정) 새로운 사용자 mdguest를 생성(비밀번호는 mdguest)
-- 생성
create user mdguest identified by mdguest;

-- 권한 관리
-- 세션 생성 권한을 데이터베이스 접속, 테이블 생성 및 조회같이 
-- 데이터베이스 활용을 위한 전반적인 부분에서 필요하다.
-- connect role, 테이블 생성 권한인 resource role과 테이블스페이스를 사용하기 위한 
-- unlimited tablespace 권한을 grant문으로 부여

-- (pdb1_system 계정 접속)
-- mdguest 사용자에게 데이터베이스 접속 및 테이블 생성 권한, 테이블스페이스를 사용할 수 있는 권한 부여
grant connect, resource, unlimited tablespace to mdguest;

-- 권한 허가 - grant
-- 문법
-- grant 권한 [(컬럼[,...n)], [,...n] [on 객체] to {사용자 | 롤 | public [,...n]} [with grant option]

-- 컬럼
-- 사용 권한을 부여할 테이블의 열 이름을 지정한다. ()안에 표시해야 한다.
-- 객체 테이블이나 뷰 등의 이름이 올 수 있다.

-- to 사용자
-- 사용자나 권한의 묶음인 롤(role)에 권한을 추가할 수 있다.
-- public은 모든 사용자가 사용할 수 있도록 공개적으로 권한을 부여한다는 의미이다.

-- with grant option
-- 허가받은 권한을 다른 사용자에게 다시 부여할 수 있다.
-- 이 옵션이 없으면 권한의 재부여는 허가하지 않는다.

-- 권한
-- 허가할 권한을 지정, 객체 타입별로 지정 가능한 권한은 아래와 같다.
-- 객체 권한
-- alter, delete, index, insert, references, select, update

-- 데이터베이스 자체 작업을 위한 시스템 권한과 테이블, 뷰같은 객체 권한으로 나눌 수 있다.

-- 시스템 권한
-- 시스템 권한 | 설명
-- create table | 테이블 생성
-- create view | 뷰 생성
-- create user | 새로운 사용자 생성
-- create tablespace | 테이블스페이스 생성
-- create session | 데이터베이스 접속 권한
-- delete any table | 다른 사용자의 테이블 내용 삭제
-- alter any table | 다른 사용자의 테이블 수정
-- drop any table | 다른 사용자의 테이블 삭제

-- system 권한으로 생성
create table book (
    bookid number primary key,
    bookname varchar2(60)
);

insert into book values (1, '오라클 개론');

-- (pdb1_madang 계정) mdguest에게 Book테이블의 select 권한 부여
grant select on system.book to mdguest;

-- 권한 취소 - revoke
-- 문법
-- revoke 권한 [(컬럼[,...n])] [,...n] [on 객체] from {사용자 | 롤 | public[,...n]}
-- system 접속) mdguest에게 부여된 book테이블의 select 권한 취소
revoke select on system.book from mdguest;

