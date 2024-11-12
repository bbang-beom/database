-- ddl
CREATE TABLE artist (
    artistid NUMBER NOT NULL,
    name     VARCHAR2(30)
);

ALTER TABLE artist ADD CONSTRAINT artist_pk PRIMARY KEY ( artistid );

CREATE TABLE cd (
    cdid       NUMBER NOT NULL,
    artistid   NUMBER NOT NULL,
    title      VARCHAR2(50),
    price      NUMBER,
    genre      VARCHAR2(40),
    track_list VARCHAR2(50)
);

ALTER TABLE cd ADD CONSTRAINT cd_pk PRIMARY KEY ( cdid );

ALTER TABLE cd
    ADD CONSTRAINT cd_artist_fk FOREIGN KEY ( artistid )
        REFERENCES artist ( artistid );
        
CREATE TABLE track (
    cdid    NUMBER NOT NULL,
    trackid NUMBER NOT NULL,
    title   VARCHAR2(50),
    runtime NUMBER
);

ALTER TABLE track ADD CONSTRAINT track_pk PRIMARY KEY ( trackid,
                                                        cdid );

ALTER TABLE track
    ADD CONSTRAINT track_cd_fk FOREIGN KEY ( cdid )
        REFERENCES cd ( cdid );
        
  

-- dml
-- artist
select * from artist;
insert into artist values(1, '홍길동');
insert into artist values(2, '김철수');
insert into artist values(3, '이미애');
-- cd
select * from cd;
insert into CD values(1, 1, '제목1', 10000, '장르1', '트랙1');
insert into CD values(2, 1, '제목2', 15000, '장르2', '트랙2');
insert into CD values(3, 2, '제목3', 13000, '장르3', '트랙3');
insert into CD values(4, 3, '제목4', 17000, '장르4', '트랙4');
insert into CD values(5, 3, '제목5', 11000, '장르5', '트랙5');
insert into CD values(6, 3, '제목6', 8000, '장르6', '트랙6');
-- track
select * from track;
insert into track values(1, 1, '트랙 제목1', 200);
insert into track values(1, 2, '트랙 제목2', 210);
insert into track values(2, 1, '트랙 제목3', 205);
insert into track values(3, 1, '트랙 제목4', 215);
insert into track values(3, 2, '트랙 제목5', 220);
insert into track values(3, 3, '트랙 제목6', 225);

-- 질의
-- 아티스트 정보
select * from artist;
-- cd 정보
select * from cd;
-- 아티스트 이름과 타이틀
select a.name, c.title from artist a, cd c where a.artistid = c.artistid;
-- 가장 많은 cd를 출반한 아티스트의 이름
select name from artist where artistid = 
(select count(max(artistid)) from cd group by artistid); 


 
