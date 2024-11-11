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

ALTER TABLE track ADD CONSTRAINT track_pk PRIMARY KEY ( trackid );

ALTER TABLE track
    ADD CONSTRAINT track_cd_fk FOREIGN KEY ( cdid )
        REFERENCES cd ( cdid );

-- dml
-- artist
insert into artist values(1, '홍길동');
insert into artist values(2, '김철수');
insert into artist values(3, '이미애');
-- cd
select * from cd;
insert into CD values(1, '홍길동');


