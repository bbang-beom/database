-- tabla 생성
-- teams
CREATE TABLE teams (
    teamname   VARCHAR2(40) NOT NULL,
    supervisor VARCHAR2(20) NOT NULL,
    hometown   VARCHAR2(20) NOT NULL,
    win        NUMBER DEFAULT 0,
    draw       NUMBER DEFAULT 0,
    lose       NUMBER DEFAULT 0
);

ALTER TABLE teams ADD CONSTRAINT teams_pk PRIMARY KEY ( teamname );
-- games
CREATE TABLE games (
    gameid        NUMBER NOT NULL,
    home_teamname VARCHAR2(40) NOT NULL,
    away_teamname VARCHAR2(40) NOT NULL,
    rocation      VARCHAR2(40)
        CONSTRAINT notnull NOT NULL,
    game_date     DATE
        CONSTRAINT "not null" NOT NULL,
    result        VARCHAR2(40) DEFAULT '경기 예정'
);

ALTER TABLE games ADD CONSTRAINT games_pk PRIMARY KEY ( gameid );

ALTER TABLE games
    ADD CONSTRAINT games_teams_fk FOREIGN KEY ( home_teamname )
        REFERENCES teams ( teamname );

ALTER TABLE games
    ADD CONSTRAINT games_teams_fkv2 FOREIGN KEY ( away_teamname )
        REFERENCES teams ( teamname );
-- players
CREATE TABLE players (
    playerid   NUMBER NOT NULL,
    playername VARCHAR2(20) NOT NULL,
    position   VARCHAR2(30) NOT NULL,
    teamname   VARCHAR2(40) NOT NULL,
    nation     VARCHAR2(40) NOT NULL,
    birth_date DATE NOT NULL
);

ALTER TABLE players ADD CONSTRAINT player_pk PRIMARY KEY ( playerid,
                                                           playername );

ALTER TABLE players
    ADD CONSTRAINT player_teams_fk FOREIGN KEY ( teamname )
        REFERENCES teams ( teamname );
-- batters
CREATE TABLE batters (
    gameid     NUMBER NOT NULL,
    playerid   NUMBER NOT NULL,
    playername VARCHAR2(20) NOT NULL,
    ab         NUMBER DEFAULT 0,
    hit        NUMBER DEFAULT 0,
    homerun    NUMBER DEFAULT 0,
    rbi        NUMBER DEFAULT 0
);

ALTER TABLE batters
    ADD CONSTRAINT batter_games_fk FOREIGN KEY ( gameid )
        REFERENCES games ( gameid );

ALTER TABLE batters
    ADD CONSTRAINT batter_player_fk
        FOREIGN KEY ( playerid,
                      playername )
            REFERENCES players ( playerid,
                                 playername );
-- pitchers
CREATE TABLE pitchers (
    gameid     NUMBER NOT NULL,
    playerid   NUMBER NOT NULL,
    playername VARCHAR2(20) NOT NULL,
    win        NUMBER DEFAULT 0,
    inning     NUMBER DEFAULT 0,
    los_point  NUMBER DEFAULT 0, 
    k          NUMBER DEFAULT 0   
);

ALTER TABLE pitchers
    ADD CONSTRAINT pitcher_games_fk FOREIGN KEY ( gameid )
        REFERENCES games ( gameid );

ALTER TABLE pitchers
    ADD CONSTRAINT pitcher_player_fk
        FOREIGN KEY ( playerid,
                      playername )
            REFERENCES players ( playerid,
                                 playername );
                                 
-- 데이터 삽입
-- teams
insert into teams (teamname, supervisor, hometown) values('기아 타이거즈', '이범호', '광주');
insert into teams (teamname, supervisor, hometown) values('삼성 라이온즈', '박진만', '대구');
insert into teams (teamname, supervisor, hometown) values('LG 트윈스', '염경엽', '잠실');
insert into teams (teamname, supervisor, hometown) values('두산 베어스', '이승엽', '잠실');
insert into teams (teamname, supervisor, hometown) values('KT 위즈', '이강철', '수원');
insert into teams (teamname, supervisor, hometown) values('SSG 랜더스', '이숭용', '인천');
insert into teams (teamname, supervisor, hometown) values('롯데 자이언츠', '김태형', '부산');
insert into teams (teamname, supervisor, hometown) values('한화 이글스', '김경문', '대전');
insert into teams (teamname, supervisor, hometown) values('NC 다이노스', '이호준', '창원');
insert into teams (teamname, supervisor, hometown) values('키움 히어로즈', '홍원기', '고척');
-- games
insert into games values(1, '기아 타이거즈', '삼성 라이온즈', '챔피언스 필드', '2024/04/02', '기아 승');
insert into games values(2, 'LG 트윈스', '두산 베어스', '잠실 야구장', '2024/04/02', 'LG 승');
insert into games values(3, 'KT 위즈', 'SSG 랜더스', '위즈 파크', '2024/04/02', 'KT 승');
insert into games values(4, '롯데 자이언츠', '한화 이글스', '사직 야구장', '2024/04/02', '롯데 승');
insert into games values(5, 'NC 다이노스', '키움 히어로즈', 'NC 파크', '2024/04/02', 'NC 승');

insert into games values(6,'삼성 라이온즈', '기아 타이거즈', '라이온즈 파크', '2024/04/05', '삼성 승');
insert into games values(7, '두산 베어스', 'LG 트윈스', '잠실 야구장', '2024/04/05', 'LG 승');
insert into games values(8, 'SSG 랜더스', 'KT 위즈', '랜더스 필드', '2024/04/05', 'KT 승');
insert into games values(9, '한화 이글스', '롯데 자이언츠', '이글스 파크', '2024/04/05', '롯데 승');
insert into games values(10, '키움 히어로즈', 'NC 다이노스', '고척 스타디움', '2024/04/05', '키움 승');

insert into games values(11, '기아 타이거즈', 'LG 트윈스', '챔피언스 필드', '2024/04/08', '기아 승');
insert into games values(12, '두산 베어스', '삼성 라이온즈', '잠실 야구장', '2024/04/08', '삼성 승');
insert into games values(13, 'KT 위즈', '롯데 자이언츠', '위즈 파크', '2024/04/08', '롯데 승');
insert into games values(14, 'SSG 랜더스', 'NC 다이노스', '랜더스 필드', '2024/04/08', 'NC 승');
insert into games values(15, '한화 이글스', '키움 히어로즈', '이글스 파크', '2024/04/08', '한화 승');

insert into games values(16, 'LG 트윈스', '기아 타이거즈', '잠실 야구장', '2024/04/11', '우천 취소');
insert into games values(17, '삼성 라이온즈', '두산 베어스', '라이온즈 파크', '2024/04/11', '우천 취소');
insert into games values(18, '롯데 자이언츠', 'KT 위즈', '사직 야구장', '2024/04/11', '우천 취소');
insert into games values(19, 'NC 다이노스', 'SSG 랜더스', 'NC 파크', '2024/04/11', '우천 취소');
insert into games values(20, '키움 히어로즈', '한화 이글스', '고척 스타디움', '2024/04/11', '무승부');

insert into games values(21, '기아 타이거즈', '두산 베어스', '챔피언스 필드', '2024/04/13', '기아 승');
insert into games values(22, '삼성 라이온즈', 'KT 위즈', '라이온즈 파크', '2024/04/13', '삼성 승');
insert into games values(23, 'LG 트윈스', '롯데 자이언츠', '잠실 야구장', '2024/04/13', '롯데 승');
insert into games values(24, 'SSG 랜더스', '키움 히어로즈', '랜더스 필드', '2024/04/13', 'SSG 승');
insert into games values(25, '한화 이글스', 'NC 다이노스', '이글스 파크', '2024/04/13', '한화 승');

insert into games values(26, '기아 타이거즈', 'SSG 랜더스', '챔피언스 필드', '2024/04/16', '기아 승');
insert into games values(27, '삼성 라이온즈', '롯데 자이언츠', '라이온즈 파크', '2024/04/16', '삼성 승');
insert into games values(28, 'LG 트윈스', '한화 이글스', '잠실 야구장', '2024/04/16', 'LG 승');
insert into games values(29, '키움 히어로즈', '두산 베어스', '고척 스타디움', '2024/04/16', '두산 승');
insert into games values(30, 'KT 위즈', 'NC 다이노스', '위즈 파크', '2024/04/16', 'KT 승');

insert into games values(31, '기아 타이거즈', '키움 히어로즈', '챔피언스 필드', '2024/04/19', '기아 승');
insert into games values(32, '삼성 라이온즈', 'NC 다이노스', '라이온즈 파크', '2024/04/19', '삼성 승');
insert into games values(33, '두산 베어스', '한화 이글스', '잠실 야구장', '2024/04/19', '무승부');
insert into games values(34, 'SSG 랜더스', '롯데 자이언츠', '랜더스 필드', '2024/04/19', '롯데 승');
insert into games values(35, 'KT 위즈', 'LG 트윈스', '위즈 파크', '2024/04/19', 'LG 승');

insert into games values(36, '기아 타이거즈', '롯데 자이언츠', '챔피언스 필드', '2024/04/22', '롯데 승');
insert into games values(37, 'LG 트윈스', '삼성 라이온즈', '잠실 야구장', '2024/04/22', '삼성 승');
insert into games values(38, 'NC 다이노스', '두산 베어스', 'NC 파크', '2024/04/22', '무승부');
insert into games values(39, 'SSG 랜더스', '한화 이글스', '랜더스 필드', '2024/04/22', 'SSG 승');
insert into games values(40, '키움 히어로즈', 'KT 위즈', '고척 스타디움', '2024/04/22', '키움 승');

insert into games values(41, '롯데 자이언츠', '기아 타이거즈', '사직 야구장', '2024/04/24', '무승부');
insert into games values(42, '삼성 라이온즈', 'LG 트윈스', '라이온즈 파크', '2024/04/24', 'LG 승');
insert into games values(43, '두산 베어스', 'NC 다이노스', '잠실 야구장', '2024/04/24', 'NC 승');
insert into games values(44, '한화 이글스', 'SSG 랜더스', '이글스 파크', '2024/04/24', '한화 승');
insert into games values(45, 'KT 위즈', '키움 히어로즈', '위즈 파크', '2024/04/24', '키움 승');

insert into games (gameid, home_teamname, away_teamname, rocation, game_date) values(46, 'LG 트윈스', '기아 타이거즈', '잠실 야구장', '2024/05/05');
insert into games (gameid, home_teamname, away_teamname, rocation, game_date) values(47, '삼성 라이온즈', '두산 베어스', '라이온즈 파크', '2024/05/05');
insert into games (gameid, home_teamname, away_teamname, rocation, game_date) values(48, '롯데 자이언츠', 'KT 위즈', '사직 야구장', '2024/05/05');
insert into games (gameid, home_teamname, away_teamname, rocation, game_date) values(49, 'NC 다이노스', 'SSG 랜더스', 'NC 파크', '2024/05/05');

-- players
insert into players values(1, '김도영', '3B', '기아 타이거즈', '대한민국', '2003/10/02');
insert into players values(2, '최형우', 'DH', '기아 타이거즈', '대한민국', '1983/12/16');
insert into players values(3, '양현종', 'SP', '기아 타이거즈', '대한민국', '1988/03/01');
insert into players values(4, '네일', 'SP', '기아 타이거즈', '미국', '1993/02/08');


insert into players values(5, '구자욱', 'RF', '삼성 라이온즈', '대한민국', '1993/02/12');
insert into players values(6, '강민호', 'C', '삼성 라이온즈', '대한민국', '1985/08/18');
insert into players values(7, '레예스', 'SP', '삼성 라이온즈', '도미니카 공화국', '1996/11/02');
insert into players values(8, '원태인', 'SP', '삼성 라이온즈', '대한민국', '2000/04/06');

insert into players values(9, '오스틴', 'RF', 'LG 트윈스', '미국', '1993/10/14');
insert into players values(10, '홍창기', 'RF', 'LG 트윈스', '대한민국', '1993/11/21');
insert into players values(11, '임찬규', 'SP', 'LG 트윈스', '대한민국', '1992/11/20');
insert into players values(12, '에르난데스', 'SP', 'LG 트윈스', '베네수엘라', '1995/05/03');

insert into players values(13, '양의지', 'C', '두산 베어스', '대한민국', '1987/06/05');
insert into players values(14, '정수빈', 'CF', '두산 베어스', '대한민국', '1990/10/07');
insert into players values(15, '곽빈', 'SP', '두산 베어스', '대한민국', '1999/05/28');
insert into players values(16, '최원준', 'SP', '두산 베어스', '대한민국', '1997/03/23');

insert into players values(17, '강백호', 'DH', 'KT 위즈', '대한민국', '1999/07/29');
insert into players values(18, '로하스', 'RF', 'KT 위즈', '미국', '1990/05/24');
insert into players values(19, '고영표', 'SP', 'KT 위즈', '대한민국', '1991/09/16');
insert into players values(20, '소형준', 'SP', 'KT 위즈', '대한민국', '2001/09/16');

insert into players values(21, '에레디아', 'LF', 'SSG 랜더스', '쿠바', '1991/01/31');
insert into players values(22, '최정', '3B', 'SSG 랜더스', '대한민국', '1987/02/28');
insert into players values(23, '김광현', 'SP', 'SSG 랜더스', '대한민국', '1988/07/22');
insert into players values(24, '앤더슨', 'SP', 'SSG 랜더스', '대한민국', '1994/10/29');

insert into players values(25, '레이예스', 'RF', '롯데 자이언츠', '베네수엘라', '1994/10/05');
insert into players values(26, '윤동희', 'CF', '롯데 자이언츠', '대한민국', '2003/09/18');
insert into players values(27, '반즈', 'SP', '롯데 자이언츠', '미국', '1995/10/01');
insert into players values(28, '윌커슨', 'SP', '롯데 자이언츠', '미국', '1989/05/24');

insert into players values(29, '페라자', 'RF', '한화 이글스', '베네수엘라', '1998/11/10');
insert into players values(30, '노시환', '3B', '한화 이글스', '대한민국', '2000/12/03');
insert into players values(31, '류현진', 'SP', '한화 이글스', '대한민국', '1987/03/25');
insert into players values(32, '문동주', 'SP', '한화 이글스', '대한민국', '2003/12/23');

insert into players values(33, '박민우', '2B', 'NC 다이노스', '대한민국', '1993/02/06');
insert into players values(34, '데이비슨', '1B', 'NC 다이노스', '미국', '1991/03/26');
insert into players values(35, '하트', 'SP', 'NC 다이노스', '미국', '1992/11/23');
insert into players values(36, '신민혁', 'SP', 'NC 다이노스', '대한민국', '1999/02/04');

insert into players values(37, '김혜성', '2B', '키움 히어로즈', '대한민국', '1999/01/27');
insert into players values(38, '송성문', '3B', '키움 히어로즈', '대한민국', '1996/08/29');
insert into players values(39, '후라도', 'SP', '키움 히어로즈', '파나마', '1996/01/30');
insert into players values(40, '헤이수스', 'SP', '키움 히어로즈', '대한민국', '1996/12/10');

-- batter
insert into batters values(1, 1, '김도영', 5, 3, 1, 3);
insert into batters values(1, 2, '최형우', 5, 1, 0, 1);
insert into batters values(1, 5, '구자욱', 5, 1, 0, 2);
insert into batters values(1, 6, '강민호', 5, 0, 0, 0);

insert into batters values(2, 9, '오스틴', 5, 2, 1, 4);
insert into batters values(2, 10, '홍창기', 5, 2, 0, 0);
insert into batters values(2, 13, '양의지', 5, 1, 1, 3);
insert into batters values(2, 14, '정수빈', 5, 1, 0, 0);

insert into batters values(3, 17, '강백호', 5, 1, 0, 1);
insert into batters values(3, 18, '로하스', 5, 2, 1, 2);
insert into batters values(3, 21, '에레디아', 5, 2, 0, 0);
insert into batters values(3, 22, '최정', 5, 1, 1, 1);

insert into batters values(4, 25, '레이예스', 5, 3, 0, 2);
insert into batters values(4, 26, '윤동희', 5, 2, 0, 1);
insert into batters values(4, 29, '페라자', 4, 1, 0, 0);
insert into batters values(4, 30, '노시환', 4, 1, 0, 0);

insert into batters values(5, 33, '박민우', 5, 2, 0, 2);
insert into batters values(5, 34, '데이비슨', 5, 1, 1, 1);
insert into batters values(5, 37, '김혜성', 5, 2, 0, 1);
insert into batters values(5, 38, '송성문', 5, 1, 0, 0);

insert into batters values(6, 5, '구자욱', 5, 2, 1, 2);
insert into batters values(6, 6, '강민호', 5, 1, 0, 0);
insert into batters values(6, 1, '김도영', 5, 1, 1, 1);
insert into batters values(6, 2, '최형우', 5, 2, 0, 0);

insert into batters values(7, 13, '양의지', 4, 1, 0, 0);
insert into batters values(7, 14, '정수빈', 5, 2, 0, 0);
insert into batters values(7, 9, '오스틴', 5, 2, 0, 2);
insert into batters values(7, 10, '홍창기', 5, 1, 0, 0);

insert into batters values(8, 21, '에레디아', 5, 2, 0, 1);
insert into batters values(8, 22, '최정', 5, 1, 0, 1);
insert into batters values(8, 17, '강백호', 5, 1, 0, 1);
insert into batters values(8, 18, '로하스', 5, 2, 0, 2);

insert into batters values(9, 29, '페라자', 4, 0, 0, 0);
insert into batters values(9, 30, '노시환', 4, 0, 0, 0);
insert into batters values(9, 25, '레이예스', 5, 2, 0, 2);
insert into batters values(9, 26, '윤동희', 5, 1, 0, 0);

insert into batters values(10, 37, '김혜성', 5, 2, 0, 1);
insert into batters values(10, 38, '송성문', 5, 2, 0, 2);
insert into batters values(10, 33, '박민우', 5, 1, 0, 0);
insert into batters values(10, 34, '데이비슨', 5, 1, 0, 1);

insert into batters values(11, 1, '김도영', 5, 2, 2, 3);
insert into batters values(11, 2, '최형우', 5, 2, 1, 1);
insert into batters values(11, 9, '오스틴', 4, 0, 0, 0);
insert into batters values(11, 10, '홍창기', 5, 1, 0, 0);

insert into batters values(12, 13, '양의지', 5, 1, 1, 2);
insert into batters values(12, 14, '정수빈', 5, 1, 0, 0);
insert into batters values(12, 5, '구자욱', 5, 2, 1, 2);
insert into batters values(12, 6, '강민호', 5, 2, 0, 0);

insert into batters values(13, 17, '강백호', 5, 1, 0, 1);
insert into batters values(13, 18, '로하스', 4, 1, 1, 1);
insert into batters values(13, 25, '레이예스', 5, 1, 0, 1);
insert into batters values(13, 26, '윤동희', 5, 1, 1, 1);

insert into batters values(14, 21, '에레디아', 5, 1, 0, 1);
insert into batters values(14, 22, '최정', 5, 1, 0, 0);
insert into batters values(14, 33, '박민우', 5, 1, 0, 0);
insert into batters values(14, 34, '데이비슨', 5, 1, 1, 2);

insert into batters values(15, 29, '페라자', 5, 2, 1, 2);
insert into batters values(15, 30, '노시환', 5, 1, 1, 1);
insert into batters values(15, 37, '김혜성', 5, 1, 0, 0);
insert into batters values(15, 38, '송성문', 5, 1, 0, 1);

insert into batters values(20, 37, '김혜성', 6, 3, 0, 1);
insert into batters values(20, 38, '송성문', 6, 2, 1, 2);
insert into batters values(20, 29, '페라자', 6, 2, 0, 2);
insert into batters values(20, 30, '노시환', 6, 2, 0, 1);

insert into batters values(21, 1, '김도영', 5, 1, 1, 1);
insert into batters values(21, 2, '최형우', 5, 2, 0, 1);
insert into batters values(21, 13, '양의지', 4, 0, 0, 0);
insert into batters values(21, 14, '정수빈', 4, 0, 0, 0);

insert into batters values(22, 5, '구자욱', 6, 2, 0, 1);
insert into batters values(22, 6, '강민호', 4, 2, 1, 2);
insert into batters values(22, 17, '강백호', 5, 1, 0, 0);
insert into batters values(22, 18, '로하스', 5, 2, 0, 1);

insert into batters values(23, 9, '오스틴', 4, 0, 0, 1);
insert into batters values(23, 10, '홍창기', 3, 0, 0, 0);
insert into batters values(23, 25, '레이예스', 6, 2, 0, 2);
insert into batters values(23, 26, '윤동희', 6, 2, 1, 2);

insert into batters values(24, 21, '에레디아', 5, 3, 0, 2);
insert into batters values(24, 22, '최정', 5, 2, 1, 1);
insert into batters values(24, 37, '김혜성', 5, 2, 0, 0);
insert into batters values(24, 38, '송성문', 5, 3, 0, 2);

insert into batters values(25,  29, '페라자', 4, 1, 1, 3);
insert into batters values(25, 30, '노시환', 4, 2, 0, 1);
insert into batters values(25, 33, '박민우', 4, 1, 0, 0);
insert into batters values(25, 34, '데이비슨', 6, 2, 2, 3);

insert into batters values(26, 1, '김도영', 3, 0, 0, 0);
insert into batters values(26, 2, '최형우', 4, 1, 0, 0);
insert into batters values(26, 21, '에레디아', 5, 2, 0, 0);
insert into batters values(26, 22, '최정', 3, 0, 0, 0);

insert into batters values(27, 5, '구자욱', 3, 1, 0, 1);
insert into batters values(27, 6, '강민호', 5, 1, 0, 0);
insert into batters values(27, 25, '레이예스', 5, 1, 0, 0);
insert into batters values(27, 26, '윤동희', 4, 0, 0, 0);

insert into batters values(28, 9, '오스틴', 6, 3, 1, 5);
insert into batters values(28, 10, '홍창기', 4, 5, 0, 0);
insert into batters values(28, 29, '페라자', 4, 1, 0, 1);
insert into batters (gameid, playerid, playername) values(28, 30, '노시환');

insert into batters values(29, 37, '김혜성', 5, 1, 0, 0);
insert into batters values(29, 38, '송성문', 3, 0, 0, 0);
insert into batters values(29, 13, '양의지', 5, 2, 1, 2);
insert into batters values(29, 14, '정수빈', 3, 1, 0, 0);

insert into batters values(30, 17, '강백호', 4, 1, 0, 1);
insert into batters values(30, 18, '로하스', 5, 2, 0, 1);
insert into batters values(30, 33, '박민우', 3, 1, 0, 0);
insert into batters values(30, 34, '데이비슨', 5, 2, 2, 2);

insert into batters values(31, 1, '김도영', 5, 2, 1, 2);
insert into batters values(31, 2, '최형우', 6, 2, 0, 1);
insert into batters values(31, 37, '김혜성', 5, 1, 0, 2);
insert into batters (gameid, playerid, playername) values(31, 38, '송성문');

insert into batters values(32, 5, '구자욱', 5, 2, 1, 4);
insert into batters (gameid, playerid, playername) values(32, 6, '강민호');
insert into batters values(32, 33, '박민우', 6, 2, 0, 0);
insert into batters values(32, 34, '데이비슨', 5, 2, 2, 3);

insert into batters values(33, 13, '양의지', 5, 1, 1, 2);
insert into batters values(33, 14, '정수빈', 5, 2, 1, 2);
insert into batters values(33, 29, '페라자', 5, 2, 0, 0);
insert into batters (gameid, playerid, playername) values(33, 30, '노시환');

insert into batters values(34, 21, '에레디아', 3, 2, 0, 1);
insert into batters values(34, 22, '최정', 6, 2, 1, 1);
insert into batters values(34, 25, '레이예스', 5, 3, 0, 2);
insert into batters values(34, 26, '윤동희', 4, 2, 0, 1);

insert into batters values(35, 17, '강백호', 4, 1, 0, 1);
insert into batters values(35, 18, '로하스', 3, 1, 0, 1);
insert into batters values(35, 9, '오스틴', 6, 2, 0, 4);
insert into batters values(35, 10, '홍창기', 5, 2, 0, 0);

insert into batters values(36, 1, '김도영', 3, 1, 1, 1);
insert into batters values(36, 2, '최형우', 3, 0, 0, 0);
insert into batters values(36, 25, '레이예스', 4, 1, 0, 0);
insert into batters values(36, 26, '윤동희', 4, 2, 0, 1);

insert into batters values(37, 9, '오스틴', 4, 1, 0, 2);
insert into batters values(37, 10, '홍창기', 5, 1, 0, 0);
insert into batters values(37, 5, '구자욱', 6, 3, 1, 3);
insert into batters (gameid, playerid, playername) values(37, 6, '강민호');

insert into batters values(38, 33, '박민우', 6, 2, 0, 1);
insert into batters values(38, 34, '데이비슨', 5, 1, 1, 2);
insert into batters values(38, 13, '양의지', 4, 1, 1, 1);
insert into batters values(38, 14, '정수빈', 4, 1, 0, 1);

insert into batters values(39, 21, '에레디아', 5, 2, 0, 1);
insert into batters values(39, 22, '최정', 4, 1, 1, 1);
insert into batters values(39, 29, '페라자', 3, 0, 0, 0);
insert into batters (gameid, playerid, playername) values(39, 30, '노시환');

insert into batters values(40, 37, '김혜성', 5, 2, 1, 2);
insert into batters (gameid, playerid, playername) values(40, 38, '송성문');
insert into batters values(40, 17, '강백호', 4, 1, 0, 0);
insert into batters values(40, 18, '로하스', 5, 2, 0, 1);

insert into batters values(41, 25, '레이예스', 5, 2, 0, 2);
insert into batters values(41, 26, '윤동희', 4, 1, 0, 0);
insert into batters values(41, 1, '김도영', 5, 2, 1, 2);
insert into batters values(41, 2, '최형우', 5, 1, 0, 0);

insert into batters values(42, 5, '구자욱', 4, 1, 0, 1);
insert into batters (gameid, playerid, playername) values(42, 6, '강민호');
insert into batters values(42, 9, '오스틴', 5, 1, 0, 3);
insert into batters values(42, 10, '홍창기', 5, 2, 0, 1);

insert into batters values(43, 13, '양의지', 5, 2, 0, 2);
insert into batters values(43, 14, '정수빈', 6, 2, 0, 1);
insert into batters values(43, 33, '박민우', 5, 2, 0, 1);
insert into batters values(43, 34, '데이비슨', 5, 1, 1, 2);

insert into batters values(44, 29, '페라자', 3, 1, 0, 1);
insert into batters (gameid, playerid, playername) values(44, 30, '노시환');
insert into batters values(44, 21, '에레디아', 4, 2, 0, 1);
insert into batters values(44, 22, '최정', 3, 1, 1, 1);

insert into batters values(45, 17, '강백호', 4, 1, 0, 1);
insert into batters values(45, 18, '로하스', 5, 2, 1, 2);
insert into batters values(45, 37, '김혜성', 6, 3, 1, 3);
insert into batters (gameid, playerid, playername) values(45, 38, '송성문');

-- pitchers
insert into pitchers values (1, 3, '양현종', 1, 6, 3, 4);
insert into pitchers values (1, 7, '레예스', 0, 7, 2, 8);

insert into pitchers values (2, 11, '임찬규', 0, 6, 3, 5);
insert into pitchers values (2, 15, '곽빈', 0, 6, 3, 7);

insert into pitchers values (3, 19, '고영표', 0, 5, 4, 6);
insert into pitchers values (3, 23, '김광현', 0, 6, 3, 5);

insert into pitchers values (4, 31, '류현진', 0, 6, 4, 6);
insert into pitchers values (4, 27, '반즈', 1, 7, 0, 9);

insert into pitchers values (5, 35, '하트', 1, 8, 0, 8);
insert into pitchers values (5, 39, '후라도', 0, 7, 2, 7);

insert into pitchers values (6, 8, '원태인', 1, 6, 2, 5);
insert into pitchers values (6, 4, '네일', 0, 6, 3, 8);

insert into pitchers values (7, 16, '최원준', 0, 4, 4, 3);
insert into pitchers values (7, 12, '에르난데스', 1, 6, 2, 7);

insert into pitchers values (8, 24, '앤더슨', 1, 6, 2, 6);
insert into pitchers values (8, 20, '소형준', 0, 6, 4, 3);

insert into pitchers values (9, 32, '문동주', 0, 3, 5, 2);
insert into pitchers values (9, 28, '윌커슨', 1, 9, 0, 10);

insert into pitchers values (10, 40, '헤이수스', 1, 6, 2, 6);
insert into pitchers values (10, 36, '신민혁', 0, 2, 4, 0);

insert into pitchers values (11, 3, '양현종', 0, 5, 2, 5);
insert into pitchers values (11, 11, '임찬규', 0, 6, 2, 4);

insert into pitchers values (12, 7, '레예스', 1, 7, 1, 8);
insert into pitchers values (12, 15, '곽빈', 0, 6, 2, 7);

insert into pitchers values (13, 19, '고영표', 0, 3, 6, 2);
insert into pitchers values (13, 27, '반즈', 1, 7, 1, 12);

insert into pitchers values (14, 23, '김광현', 0, 6, 2, 4);
insert into pitchers values (14, 35, '하트', 1, 8, 0, 11);

insert into pitchers values (15, 31, '류현진', 1, 7, 2, 5);
insert into pitchers values (15, 39, '후라도', 0, 6, 3, 7);

insert into pitchers values (20, 40, '헤이수스', 0, 6, 0, 7);
insert into pitchers values (20, 32, '문동주', 0, 5, 0, 6);

insert into pitchers values (21, 4, '네일', 1, 8, 1, 12);
insert into pitchers values (21, 15, '곽빈', 0, 7, 2, 7);

insert into pitchers values (22, 8, '원태인', 1, 6, 3, 5);
insert into pitchers values (22, 20, '소형준', 0, 5, 4, 4);

insert into pitchers values (23, 12, '에르난데스', 0, 6, 3, 8);
insert into pitchers values (23, 28, '윌커슨', 1, 7, 1, 8);

insert into pitchers values (24, 24, '앤더슨', 1, 7, 0, 9);
insert into pitchers values (24, 39, '후라도', 0, 5, 4, 6);

insert into pitchers values (25, 31, '류현진', 1, 6, 3, 4);
insert into pitchers values (25, 36, '신민혁', 0, 5, 5, 5);

insert into pitchers values (26, 3, '양현종', 0, 6, 2, 6);
insert into pitchers values (26, 23, '김광현', 0, 6, 1, 8);

insert into pitchers values (27, 7, '레예스', 1, 9, 0, 10);
insert into pitchers values (27, 27, '반즈', 0, 8, 1, 14);

insert into pitchers values (28, 4, '네일', 1, 6, 3, 7);
insert into pitchers values (28, 32, '문동주', 0, 4, 6, 2);

insert into pitchers values (29, 40, '헤이수스', 0, 6, 1, 7);
insert into pitchers values (29, 16, '최원준', 1, 7, 1, 8);

insert into pitchers values (30, 19, '고영표', 0, 6, 1, 5);
insert into pitchers values (30, 35, '하트', 0, 7, 1, 9);

insert into pitchers values (31, 3, '양현종', 0, 6, 2, 3);
insert into pitchers values (31, 39, '후라도', 0, 6, 1, 7);

insert into pitchers values (32, 8, '원태인', 1, 5, 4, 5);
insert into pitchers values (32, 36, '신민혁', 0, 4, 4, 6);

insert into pitchers values (33, 15, '곽빈', 0, 5, 3, 6);
insert into pitchers values (33, 31, '류현진', 0, 5, 4, 3);

insert into pitchers values (34, 24, '앤더슨', 0, 6, 7, 7);
insert into pitchers values (34, 28, '윌커슨', 0, 5, 5, 4);

insert into pitchers values (35, 20, '소형준', 0, 6, 2, 6);
insert into pitchers values (35, 11, '임찬규', 0, 5, 3, 5);

insert into pitchers values (36, 4, '네일', 0, 7, 2, 9);
insert into pitchers values (36, 27, '반즈', 1, 7, 1, 10);

insert into pitchers values (37, 12, '에르난데스', 0, 5, 3, 5);
insert into pitchers values (37, 7, '레예스', 0, 5, 2, 4);

insert into pitchers values (38, 35, '하트', 0, 7, 0, 8);
insert into pitchers values (38, 16, '최원준', 0, 6, 0, 5);

insert into pitchers values (39, 23, '김광현', 1, 6, 0, 5);
insert into pitchers values (39, 32, '문동주', 0, 6, 1, 4);

insert into pitchers values (40, 40, '헤이수스', 1, 6, 2, 7);
insert into pitchers values (40, 19, '고영표', 0, 5, 3, 3);

insert into pitchers values (41, 28, '윌커슨', 0, 7, 0, 9);
insert into pitchers values (41, 3, '양현종', 0, 5, 1, 5);

insert into pitchers values (42, 8, '원태인', 0, 6, 4, 7);
insert into pitchers values (42, 11, '임찬규', 1, 7, 3, 6);

insert into pitchers values (43, 15, '곽빈', 0, 7, 4, 6);
insert into pitchers values (43, 36, '신민혁', 1, 5, 3, 3);

insert into pitchers values (44, 31, '류현진', 1, 5, 1, 4);
insert into pitchers values (44, 24, '앤더슨', 0, 8, 4, 6);

insert into pitchers values (45, 20, '소형준', 0, 6, 2, 4);
insert into pitchers values (45, 39, '후라도', 1, 6, 1, 5);