-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색
select * from book;
-- 모든 도서의 가격을 검색
select price from book;
-- 모든 도서의 아이디를 검색
select bookid from book;
-- 모든 도서의 도서번호, 도서 이름을 검색
select bookid, bookname from book;
-- 가격이 10000원 미만인 도서를 검색
select * from book where price < 10000;
-- 가격이 10000원 이상인 도서를 검색
select * from book where price >= 10000;
-- 가격이 35000원인 도서를 검색
select * from book where price = 35000;
-- 가격이 5000원 이상 15000원 이하인 도서를 검색
select * from book where price between 5000 and 15000;
-- 가격이 25000원 이상 40000원 미만인 도서를 검색
select * from book where price between 25000 and 40000;
-- 가격이 6000원 이상 14000원 이하인 도서를 검색
select * from book where price between 6000 and 14000;
-- 출판사가 나무수가 아닌 도서를 검색
select * from book where publisher not in '나무수';
-- 출판사가 삼성당 혹은 나무수인 도서를 검색
select * from book where publisher in ('나무수', '삼성당');
-- 출판사가 나무수 혹은 Pearson인 도서를 검색
select * from book where publisher in ('나무수', 'Pearson');
-- 모든 도서의 도서 번호, 도서 이름, 출판사, 가격을 검색하고 별칭을 한글로 이름으로 지정
select bookid as "도서 번호", bookname as "도서 이름", publisher as "출판사", price as "가격" from book;
-- 야구의 추억을 출간한 출판사를 검색
select bookname, publisher from book where bookname = '야구의 추억';
-- 축구의 이해라는 도서의 가격을 검색
select bookname, price from book where bookname = '축구의 이해';
-- 야구를 부탁해라는 도서의 도서번호를 검색
select bookid, bookname from book where bookname = '야구를 부탁해';
-- 도서 이름에 야구가 포함된 출판사를 검색
select bookname, publisher from book where bookname like '야구%';
-- 도서 번호가 3인 도서를 검색
select bookid, bookname from book where bookid = 3;
-- 출판사가 대한미디어인 도서를 검색
select bookname, publisher from book where publisher = '대한미디어';
-- 도서 이름이 야로 시작하는 도서를 검색
select bookname from book where bookname like '야%';
-- 도서 이름이 해로 끝나는 도서를 검색
select bookname from book where bookname like '%해';
-- 출판사 이름에 미디어가 포함된 출판사를 검색
select publisher from book where publisher like '%미디어%';
-- 야구에 관한 도서중 20000원 이상인 도서를 검색
select bookname, price from book where bookname like '%야구%' and price >= 20000;
-- 축구에 관한 도서중 굿스포츠에서 발간한 도서를 검색
select bookname, publisher from book where bookname like '%축구%' and publisher = '굿스포츠';
-- 대한미디어에서 발간한 도서중 30000원 이하의 도서를 검색
select bookname, publisher, price from book where price <= 30000 and publisher = '대한미디어';
-- 축구에 관한 도서중 나무수에서 발간한 도서를 검색
select bookname, publisher from book where bookname like '%축구%' and publisher = '나무수';
-- 이상미디어에서 발간한 도서중 도서번호가 8번인 도서를 검색
select bookid, bookname, publisher from book where bookid = 8 and publisher = '이상미디어';
-- 굿스포츠에서 발간한 도서중에서 도서 번호가 3미만인 도서를 검색
select bookid, bookname, publisher from book where bookid < 3 and publisher = '굿스포츠';