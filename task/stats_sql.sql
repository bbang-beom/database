-- sql
-- 각 테이블의 모든 정보
select * from teams;
select * from games; 
select * from players;
select * from batters;
select * from pitchers;
-- update
-- teams의 승,무,패가 0으로 초기화 되어있는데 이를 games의 result를 통해 update
-- 승
update teams set win = (select count(*) from games where result = '기아 승') where teamname = '기아 타이거즈';
update teams set win = (select count(*) from games where result = '삼성 승') where teamname = '삼성 라이온즈';
update teams set win = (select count(*) from games where result = 'LG 승') where teamname = 'LG 트윈스';
update teams set win = (select count(*) from games where result = '두산 승') where teamname = '두산 베어스';
update teams set win = (select count(*) from games where result = 'KT 승') where teamname = 'KT 위즈';
update teams set win = (select count(*) from games where result = 'SSG 승') where teamname = 'SSG 랜더스';
update teams set win = (select count(*) from games where result = '롯데 승') where teamname = '롯데 자이언츠';
update teams set win = (select count(*) from games where result = '한화 승') where teamname = '한화 이글스';
update teams set win = (select count(*) from games where result = 'NC 승') where teamname = 'NC 다이노스';
update teams set win = (select count(*) from games where result = '키움 승') where teamname = '키움 히어로즈';
-- 무
update teams set draw = 
(select count(*) from games where result = '무승부' and 
(home_teamname = '기아 타이거즈' or away_teamname = '기아 타이거즈')) 
where teamname = '기아 타이거즈';
update teams set draw = 
(select count(*) from games where result = '무승부' and 
(home_teamname = '삼성 라이온즈' or away_teamname = '삼성 라이온즈')) 
where teamname = '삼성 라이온즈';
update teams set draw = 
(select count(*) from games where result = '무승부' and 
(home_teamname = 'LG 트윈스' or away_teamname = 'LG 트윈스')) 
where teamname = 'LG 트윈스';
update teams set draw = 
(select count(*) from games where result = '무승부' and 
(home_teamname = '두산 베어스' or away_teamname = '두산 베어스')) 
where teamname = '두산 베어스';
update teams set draw = 
(select count(*) from games where result = '무승부' and 
(home_teamname = 'KT 위즈' or away_teamname = 'KT 위즈')) 
where teamname = 'KT 위즈';
update teams set draw = 
(select count(*) from games where result = '무승부' and 
(home_teamname = 'SSG 랜더스' or away_teamname = 'SSG 랜더스')) 
where teamname = 'SSG 랜더스';
update teams set draw = 
(select count(*) from games where result = '무승부' and 
(home_teamname = '롯데 자이언츠' or away_teamname = '롯데 자이언츠')) 
where teamname = '롯데 자이언츠';
update teams set draw = 
(select count(*) from games where result = '무승부' and 
(home_teamname = '한화 이글스' or away_teamname = '한화 이글스')) 
where teamname = '한화 이글스';
update teams set draw = 
(select count(*) from games where result = '무승부' and 
(home_teamname = 'NC 다이노스' or away_teamname = 'NC 다이노스')) 
where teamname = 'NC 다이노스';
update teams set draw = 
(select count(*) from games where result = '무승부' and 
(home_teamname = '키움 히어로즈' or away_teamname = '키움 히어로즈')) 
where teamname = '키움 히어로즈';
-- 패
update teams set lose = 
(select count(*) from games where (result != '기아 승' and result != '무승부' 
and result != '경기 예정' and result != '우천 취소') and 
(home_teamname = '기아 타이거즈' or away_teamname = '기아 타이거즈')) 
where teamname = '기아 타이거즈';

update teams set lose = 
(select count(*) from games where (result != '삼성 승' and result != '무승부' 
and result != '경기 예정' and result != '우천 취소') and 
(home_teamname = '삼성 라이온즈' or away_teamname = '삼성 라이온즈')) 
where teamname = '삼성 라이온즈';

update teams set lose = 
(select count(*) from games where (result != 'LG 승' and result != '무승부' 
and result != '경기 예정' and result != '우천 취소') and 
(home_teamname = 'LG 트윈스' or away_teamname = 'LG 트윈스')) 
where teamname = 'LG 트윈스';

update teams set lose = 
(select count(*) from games where (result != '두산 승' and result != '무승부' 
and result != '경기 예정' and result != '우천 취소') and 
(home_teamname = '두산 베어스' or away_teamname = '두산 베어스')) 
where teamname = '두산 베어스';

update teams set lose = 
(select count(*) from games where (result != 'KT 승' and result != '무승부' 
and result != '경기 예정' and result != '우천 취소') and 
(home_teamname = 'KT 위즈' or away_teamname = 'KT 위즈')) 
where teamname = 'KT 위즈';

update teams set lose = 
(select count(*) from games where (result != 'SSG 승' and result != '무승부' 
and result != '경기 예정' and result != '우천 취소') 
and (home_teamname = 'SSG 랜더스' or away_teamname = 'SSG 랜더스')) 
where teamname = 'SSG 랜더스';

update teams set lose = 
(select count(*) from games where (result != '롯데 승' and result != '무승부' 
and result != '경기 예정' and result != '우천 취소') 
and (home_teamname = '롯데 자이언츠' or away_teamname = '롯데 자이언츠')) 
where teamname = '롯데 자이언츠';

update teams set lose = 
(select count(*) from games where (result != '한화 승' and result != '무승부' 
and result != '경기 예정' and result != '우천 취소') 
and (home_teamname = '한화 이글스' or away_teamname = '한화 이글스')) 
where teamname = '한화 이글스';

update teams set lose = 
(select count(*) from games where (result != 'NC 승' and result != '무승부' 
and result != '경기 예정' and result != '우천 취소') 
and (home_teamname = 'NC 다이노스' or away_teamname = 'NC 다이노스')) 
where teamname = 'NC 다이노스';

update teams set lose = 
(select count(*) from games where (result != '키움 승' and result != '무승부' 
and result != '경기 예정' and result != '우천 취소') 
and (home_teamname = '키움 히어로즈' or away_teamname = '키움 히어로즈')) 
where teamname = '키움 히어로즈';

-- basic
-- between
-- 90~99년생 선수들 출력 (생년월일 빠른 순 정렬)
select * from players where birth_date between '90/01/01' and '99/12/31' order by birth_date;
-- date -> char로 변환
-- 생일이 화요일인 선수들 출력
select playername, TO_CHAR(birth_date, 'DAY') from players 
where TO_CHAR(birth_date, 'DAY') = '화요일';
-- 8월에 생일인 선수들 출력
select playername, TO_CHAR(birth_date, 'MM') as month from players 
where TO_CHAR(birth_date, 'MM') = '08';
-- 생일이 같은 사람들 출력
select p1.playername, p2.playername, TO_CHAR(birth_date, 'MM/DD') as birthday
from players p1, (select playername, TO_CHAR(birth_date, 'MM/DD') as birthday  from players) p2
where TO_CHAR(birth_date, 'MM/DD') = p2.birthday and p1.playername != p2.playername;
-- 기본 연산
-- 각 팀들의 승률(승 / (승 + 무 + 패))출력:
select teamname, (win / (win + draw + lose)) as "win_rate" from teams;
-- 정렬
-- 위의 sql을 승률 순으로 정렬
select teamname, (win / (win + draw + lose)) as "win_rate" from teams order by "win_rate" desc;
-- 최대, 최소(max, min)
-- 위의 sql에서 최대 최소 승률 출력
select max((win / (win + draw + lose))) "최고 승률", 
min((win / (win + draw + lose))) "최저 승률" from teams;
-- 문자열
-- 문자열 연결
-- 홈 팀 및 경기장 이름
select home_teamname, rocation from games;
-- games의 rocation은 home_team의 구장 이름이다 이를 이용하여 문자열을 연결하면
select distinct home_teamname || '의 구장은 ' || rocation as stadium from games; 
-- like 문자열
-- 경기장이 '파크'로 끝나는 구장을 가진 팀이름 출력
select distinct home_teamname, rocation from games where rocation like '%파크';
-- 이름이 두글자인 선수들 출력
select playername from players where playername like '__';
-- '스'로 끝나는 팀 이름들 출력
select teamname from teams where teamname like '%스';

-- 순위 함수
-- 야구는 승패마진(승-패)로 순위를 결정한다. 이에따라 현재 순위 출력
select teamname, win, draw, lose, (win - lose) as gains, rank() over(order by (win - lose) desc) as rank from teams;
-- 위를 이용해 1위 팀의 연고지를 출력
select rownum as rank, teamname, hometown 
from (select teamname, rank() over(order by (win - lose) desc) as rank, hometown from teams order by rank)
where rownum = 1;
-- 또 위를 이용하여 1위 팀의 선수들 출력(부속질의와 palyers의 조인)
select p.teamname, p.playername, p.position from players p,
(select rownum as rank, teamname, hometown 
from (select teamname, rank() over(order by (win - lose) desc) as rank, hometown from teams order by rank) 
where rownum = 1) t
where p.teamname = t.teamname;
-- 문자열에서 이용한 문장을 순위함수와 함께 이용하여 스로 끝나는 팀들의 순위 출력
select t.teamname, r.rank from 
(select teamname,(win - lose) as gains, rank() over(order by (win - lose) desc) as rank from teams) r,
(select teamname from teams where teamname like '%스') t
where t.teamname = r.teamname;

-- 조인
-- 문자열에서 했던 취소되었거나 or 치뤄지지 않은 경기 확인
select * from games where result like '%취소%' or result like '%예정%';
-- 위를 이용하여 players와 조인하여 치뤄지지 않은 경기에 출전할 선수들 출력
select p.teamname, p.playername, p.position from players p, teams t,
(select * from games where result like '%예정%') g
where (g.home_teamname = t.teamname or g.away_teamname = t.teamname)
and t.teamname = p.teamname;

-- gameid를 이용해 투수 '반즈'선수가 경기를 했던 경기에 타자들의 기록을 출력
select p.playername, b.playername, b.ab, b.hit, b.homerun, b.rbi 
from batters b, pitchers p
where p.gameid = b.gameid and p.playername = '반즈';
-- 위의 sql문에서 롯데 자이언츠 타자들의 gmaeid를 제외하면 상대팀의 타자들의 기록
-- 즉, 상대기록을 볼 수 있다.(부속 질의)
select p.playername, b.playername, b.ab, b.hit, b.homerun, b.rbi 
from batters b, pitchers p
where p.gameid = b.gameid and p.playername = '반즈' 
and b.playerid not in (select playerid from players where teamname = '롯데 자이언츠');

-- 그룹 함수
-- batters와 pitchers 테이블을 만든 이유는 각 경기마다 선수의 성적을 집계하기 위함이다.
-- 이를 이용하여 각 선수의 기록들을 출력
-- 평균보다 많은 이닝을 던진 투수 출력
select playerid, playername, avg(inning) from pitchers p 
group by playerid, playername 
having avg(inning) > (select avg(inning) from pitchers) order by avg(inning) desc;

-- 타자들의 기록들의 합 출력
select playername, sum(ab), sum(hit), sum(homerun), sum(rbi) from batters group by playerid, playername;
-- 타자의 타율은 타석당 안타개수(hit/ab)이다. 이를 이용하여 타율 순으로 정렬하여 출력
select playername, (sum(hit)/sum(ab)) as "batting_average" 
from batters group by playerid, playername order by "batting_average" desc;
-- 문자열 표현
-- 위의 sql 문장의 batting_average는 소수점 표현이 너무 길다. TO_CHAR를 통해 소수점 3자리까지만 출력하자
select playername, TO_CHAR((sum(hit)/sum(ab)), '0.999') as "batting_average" 
from batters group by playerid, playername order by "batting_average" desc;
-- 위의 함수들을 이용하여 타자들의 타율, 안타, 홈런, 타점의 각 1위 선수들을 출력
-- 타율 왕
select playername as "타율 왕", TO_CHAR((sum(hit)/sum(ab)), '0.999') as "타율" 
from batters group by playerid, playername having TO_CHAR((sum(hit)/sum(ab)), '0.999') = 
(select max(TO_CHAR((sum(hit)/sum(ab)), '0.999')) from batters group by playerid, playername);
-- 타격 왕
select playername as "타격 왕", sum(hit) as "안타" 
from batters group by playerid, playername having sum(hit) = 
(select max(sum(hit)) from batters group by playerid, playername);
-- 홈런 왕
select playername as "홈런 왕", sum(homerun) as "홈런" 
from batters group by playerid, playername having sum(homerun) = 
(select max(sum(homerun)) from batters group by playerid, playername);
-- 타점 왕
select playername as "타점 왕", sum(rbi) as "타점" 
from batters group by playerid, playername having sum(rbi) = 
(select max(sum(rbi)) from batters group by playerid, playername);

-- 위를 이용하여 players와 조인하면 소속팀까지 출력가능
-- ex) 타점 왕
select  p.playername "타점 왕", p.teamname "소속 팀", b.rbi "타점" 
from players p, 
(select playername, sum(rbi) as rbi from batters group by playerid, playername having sum(rbi) = 
(select max(sum(rbi)) from batters group by playerid, playername)) b
where p.playername = b.playername;

-- 투수도 위의 예와 같이 삼진 왕을 출력
select  p.playername "삼진 왕", p.teamname "소속 팀", pc.k "삼진" 
from players p, 
(select playername, sum(k) as k from pitchers group by playerid, playername having sum(k) = 
(select max(sum(k)) from pitchers group by playerid, playername)) pc
where p.playername = pc.playername;

-- 사직 야구장에서 경기 예정인 선수(타자)들의 성적 출력 
select b.playername, sum(ab) "타수", sum(hit) "안타", sum(homerun) "홈런", sum(rbi)"타점" 
from batters b,
(select p.teamname, p.playername, p.position from players p, teams t,
(select * from games where result like '%예정%' and rocation = '사직 야구장') g
where (g.home_teamname = t.teamname or g.away_teamname = t.teamname)
and t.teamname = p.teamname) ep
where ep.playername = b.playername     
group by b.playerid, b.playername;                     

-- 골든글러브
-- 야구에서는 매년 각 포지션에서 가장 뛰어난 활약을 보인 선수에게 골든글러브라는 상을 수여한다.
-- 안타와 타점은 1점, 홈런은 2점의 가산점을 부여한다고 가정하고 각 포지션 별 골든글러브 출력
-- 3루수 골든글러브 수상자 출력
select p.playername as "수상자", p.position, b.point from players p, 
(select playerid, playername, (sum(hit) * 1 + sum(homerun) * 2 + sum(rbi) * 1) as point 
from batters group by playername, playerid order by point desc ) b
where p.playerid = b.playerid and p.position = '3B' and rownum = 1;
-- 투수 골든 글러브 삼진 + (실점/이닝 * -1)
select p.playername as "수상자", p.position, pc.point from players p, 
(select playerid, playername, floor(sum(k) * 1 + (sum(los_point)/(sum(inning) * (-1)))) as point 
from pitchers group by playername, playerid order by point desc ) pc
where p.playerid = pc.playerid and p.position = 'SP' and rownum = 1;

-- 야구에는 '규정 이닝', '규정 타석'이 존재한다. 
-- 규정 이닝(타석)이란 정식 기록으로 인정할 수 있는 이닝(타석) 수이고,
-- 이는 진행한 경기수에 따라 정해진다.
-- 규정 이닝은 소속된 팀이 진행한 경기 수 만큼 이닝을 소화해야 하고
-- 규정 타석은 소속된 팀이 진행한 경기 수 * 3.1에서 소수점을 뺀 수 만큼 타석을 진행해야 한다.

-- 한화 이글스팀 소속 선수의 규정타석 출력
select floor(count(*) * 3.1) as "규정 타석" from games 
where (home_teamname = '한화 이글스' or away_teamname = '한화 이글스')
and (result != '우천 취소' and result != '경기 예정');
-- 위를 이용하여 한화 이글스팀 소속의 선수 중 규정 타석을 채우지 못한 선수(타자) 출력
select playername, ab as "타석 수", 
(select floor(count(*) * 3.1) as "규정 타석" from games 
where (home_teamname = '한화 이글스' or away_teamname = '한화 이글스')
and (result != '우천 취소' and result != '경기 예정')) as "규정 타석" 
from 
(select playerid from players where teamname = '한화 이글스') p,
(select playerid, playername, sum(ab) ab from batters group by playerid, playername 
having sum(ab) < (select floor(count(*) * 3.1) as "규정 타석" from games 
where (home_teamname = '한화 이글스' or away_teamname = '한화 이글스')
and (result != '우천 취소' and result != '경기 예정'))) b
where p.playerid = b.playerid;

-- 한화 이글스팀 소속의 선수 중 규정 이닝을 채운 선수(투수) 출력
select playername, inning as "이닝 수", 
(select count(*) as "규정 이닝" from games 
where (home_teamname = '한화 이글스' or away_teamname = '한화 이글스')
and (result != '우천 취소' and result != '경기 예정')) as "규정 이닝" 
from 
(select playerid from players where teamname = '한화 이글스') p,
(select playerid, playername, sum(inning) inning from pitchers group by playerid, playername 
having sum(inning) >= (select count(*) as "규정 이닝" from games 
where (home_teamname = '한화 이글스' or away_teamname = '한화 이글스')
and (result != '우천 취소' and result != '경기 예정'))) pc
where p.playerid = pc.playerid;

-- view
-- players에서 우리나라 국적이 아닌 선수들을 뽑아 외국인선수(foreign_players)라는 새로운 view를 생성
create view foreign_players as select * from players where nation != '대한민국';
select * from foreign_players;

-- 생성한 view를 조인해 외국인 타자들만 출력 
select distinct f.playername, f.nation from batters b, foreign_players f
where b.playerid = f.playerid;

-- 외국인 타자들 중 홈런 개수 순으로 출력
select f.playername, b.homerun 
from (select playerid, sum(homerun) as homerun from batters group by playerid) b, 
foreign_players f
where b.playerid = f.playerid order by b.homerun desc;

-- 위의 sql문과 위에서 했던 순위 함수를 사용하여 가장 많은 홈런을 친 외국인 선수를 출력
select playername as "외국인 타자 중 최다 홈런", homerun from (select f.playername as playername, b.homerun as homerun
from (select playerid, sum(homerun) as homerun from batters group by playerid) b, 
foreign_players f
where b.playerid = f.playerid order by b.homerun desc)
where rownum = 1;

-- 국적(nation)별로 몇명의 선수가 있는지 출력
select nation, count(*) from foreign_players group by nation;
-- 위의 sql문과 foreign_players를 활용해 
-- 가장 많은 인원을 가진 나라의 선수들의 정보를 가진 view를 생성(view를 사용한 새로운 view)
create view most_numbers_of_foreign (playerid, playername, position, teamname, nation, birth_date) 
as 
(select f.playerid, f.playername, f.position, f.teamname, f.nation, f.birth_date 
from foreign_players f,
(select nation, count(*) from foreign_players group by nation 
having count(*) = (select max(count(*)) from foreign_players group by nation)) c
where c.nation = f.nation);

select * from most_numbers_of_foreign;

-- alter
-- players에서 데이터가 사라지면 batters와 pitchers의 데이터도 함께 사라지도록 설정
-- 기존 제약조건 삭제
ALTER TABLE batters
    drop CONSTRAINT batter_player_fk;
ALTER TABLE pitchers
    drop CONSTRAINT pitcher_player_fk;    
-- 제약조건 새로 추가
ALTER TABLE batters
    ADD CONSTRAINT batter_player_fk
        FOREIGN KEY ( playerid,
                      playername )
            REFERENCES players ( playerid,
                                 playername ) on delete cascade;

ALTER TABLE pitchers
    ADD CONSTRAINT pitcher_player_fk
        FOREIGN KEY ( playerid,
                      playername )
            REFERENCES players ( playerid,
                                 playername ) on delete cascade;                                 
-- delete
-- players와 함께 batters도 29번(페라자) 삭제
delete from players where playerid = 29;
-- players와 함께 pitchers도 39번(후라도) 삭제
delete from players where playerid = 39;

select * from players;
select * from batters;
select * from pitchers;


