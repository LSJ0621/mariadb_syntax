--inner  join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from author inner join post on author.id = post.author_id;
select * from author a inner join post p on a.id = p.author_id; -- 두문장은 같은 뜻이다
-- 출력 순서만 달라질뿐 조회결과는 동일.
select * from post inner join author on author.id = post.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일만 출력하시오.
-- post의 글쓴이가 없는 데이터는 포함x, 글쓴이중에 글을 한번도 안쓴 사람 포함x
select p.*, a.email from post p inner join author a on a.id = p.author_id;
-- 글쓴이가 있는 글 제목, 내용, 그리고 글쓴이의 이메일만 출력하시오.
select p.title,p.contents, a.email from post p inner join author a on a.id = p.author_id;

-- 모든 글목록을 출력하고, 만약에 글쓴이가 있다면 이메일정보를 출력
-- left outer join -> left join으로 생략 가능
-- 글을 한번도 안쓴 글쓴이 정보는 포함x
select p.*, a.email from post p left join author a on a.id = p.author_id;

-- 글쓴이를 기준으로 left join 할 경우, 글쓴이가 n개의 글을 쓸수  있으므로 같은 글쓴이가 여러번 출력될 수 있음.
-- author와 post 가 1:n  관계이므로.
-- 글쓴이가 없는 글은 포함 x
select * from author a left join post p on a.id = p.author_id;

-- 실습) 글쓴이가 있는 글중에서 글의 title과 저자의 email만을 출력하되,
-- 저자의 나이가 30세 이상인 글만 출력
select p.title, a.email from post p inner join author a on a.id = p.author_id where a.age >=30;

-- 글의 내용과 글의 저자의 이름이 있는(not null), 글 목록을 출력하되 2024-06 이후에 만들어진 글만 출력
select p.* from post p inner join author a on a.id = p.author_id 
where a.name is not null and p.contents is not null and p.created_time >= '2024-06-01';

-- 조건에 맞는 도서와 저자 리스트 출력
SELECT B.BOOK_ID, A.AUTHOR_NAME, date_format(PUBLISHED_DATE , '%Y-%m-%d') from BOOK B 
inner join AUTHOR A on A.AUTHOR_ID = B.AUTHOR_ID 
where B.CATEGORY like '%경제%' order by B.PUBLISHED_DATE asc;

-- union : 두 테이블의 select 결과를 횡으로 결합(기본적으로 distinct 적용)
-- 컬럼의 개수와 컬럼으 타입이 같아야함에 유의
-- union all : 중복까지 모두 포함
select name, email from author union select title, contents from post;

-- 서브쿼리 : select문 안에 또다른 select문을 서브쿼리라 한다.
-- where절 안에 서브쿼리
-- 한번이라도 글을 쓴 author 목록 조회
select distinct a.* from author a inner join post p on a.id = p.author_id; --distinct *은 안됌 왜냐면 post가 중복이 아니면 author 파트가 중복이어도 삭제가 안됌
select * from author where id in (select author_id from post);
-- select절 안에 서브쿼리
-- author의 email과 author 별로 본인이 쓴 글의 개수를 출력
select (select name, post_number from author) as a;
select a.email, (select count(*) from post where author_id = a.id) as count from author a;
-- from절 안에 서브쿼리
select a.name from (select * from author) as a;

-- 없어진 기록 찾기
-- 1.서브쿼리
select ANIMAL_ID, NAME from ANIMAL_OUTS where ANIMAL_ID NOT IN (select ANIMAL_ID from ANIMAL_INS);
-- 2. join으로 풀기
select o.animal_id, o.name from animal_outs o left join animal_ins i on o.animal_id =i.animal_id where i.animal_id is null;

-- 집계함수
-- null은 count에서 제외
select count(*) from author;
select sum(price) from post;
select avg(price) from post;
-- 소수점 첫번째자리에서 반올림해서 소수점을 없앰
select round(avg(price),0) from post;

-- group by : 그룹화된 데이터를 하나의 행(row)처럼 취급.
-- author_id로 그룹핑 하였으면, 그 외의 컬럼을 조회하는 것은 적절치 않음.
select author_id from post group by author_id;
-- group by 와 집계함수
-- 아래 쿼리에서 * 은 그룹화된 데이터내에서의 개수
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price) from post group by author_id;
-- author의 email과 author 별로 본인이 쓴 글의 개수를 출력
select a.email, (select count(*) from post where author_id = a.id) as count from author a;
-- join과 group by, 집계함수 활용한 글의 개수 출력
select a.email,count(p.id) from author a left join post p on a.id = p.author_id group by a.email;

-- where와 group by
-- 연도별 post 글의 개수 출력, 연도가 null 값은 제외
select date_format(created_time, '%Y') as year,count(*) from post where created_time is not null group by year;

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
SELECT car_type, count(*) as cars from car_rental_company_car 
where options like '%가죽시트%'or options like '%열선시트%' or options like '%통풍시트%'
group by car_type order by car_type;

--입양 시각 구하기(1)
SELECT date_format(datetime, '%H') as HOUR,count(*) as COUNT from animal_outs 
where date_format(datetime, '%H') >= '09' and date_format(datetime, '%H') <'20' 
group by HOUR order by HOUR;

-- having : group by를 통해 나온 집계값에 대한 조건
-- 글을 2개 이상 쓴 사람에 대한 정보조회
select author_id from post group by author_id having count(*)>=2;
select author_id, count(*) as count from post group by author_id having  count>=2;

--동명 동물 수 찾기
select NAME, count(*) as COUNT from ANIMAL_INS 
where NAME is not null group by NAME having  count>=2 order by name;

-- 다중열 group by
-- post에서 작성자가 만든 제목의 개수를 출력하시오.
select author_id, title, count(*) from post group by author_id, title;

-- 재구매가 일어난 상품과 회원 리스트 구하기
select user_id, product_id from ONLINE_SALE 
group by user_id, product_id having count(*)>= 2 
order by user_id asc, product_id desc;
