-- insert into : 테이블에 데이터 삽입
insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3) values(데이테1,데이터2,데이터3);

-- 문자열은 일반적으로 작은따옴표 ''를 사용
insert into author(id,name,email) values(3,'Lim','Lim@naver.com');

-- select : 데이터조회, * : 모든컬럼을 의미 (중요)
select * from author;
selct name, email from author;

-- post 데이터 1줄 추가
insert into post(id,title) values(1,'Limseongjae');
insert into post(id,title,contents,author_id) values(3,'hello','hello...',4); --author 테이블에 4번 author이 없기때문에 에러가 남

-- 테이블 제약조건을 조회 (참조관계도 조회할수 있음)
select * from information_schema.key_column_usage where table_name = 'post';

--insert문을 통해 author 데이터 2개 추가 , post 데이터 2개 추가 (1개는 익명)

-- update : 데이터 수정
-- where문을 빠뜨리게 될 경우, 모든 데이터에 upedate문이 실행됨에 유의.
update author set name = '홍길동' where id=1; 
update author set name = '홍길동2', email= 'hongildong@naver.com',where id=2;

-- delete : 데이터 삭제
-- where조건을 생략할경우 모든데이터가 삭제됨에 유의
delete from author where id = 5;

-- select : 조회
select * from author; --어떠한 조회조건 없이 모든 컬럼 조회
select * from author where id =1; --where 뒤에 조회조건을 통해 조회
select * from author where name = 'hongildong';
select * from author where id>3;
select * from author where id>2 and name = 'Lim'; --또는일 경우에는 or 사용하면 됌

-- 중복제거 조회 : distinct
select name from author;
select distinct name from author;

-- 정렬 : order by
-- 아무런 정렬조건 없이 조회할 경우에는 pk 기준으로 오름차순 정렬
-- asc : 오름차순, desc : 내림차순
select * from author order by name desc;

-- 멀티 컬럼 order by : 여러 컬럼으로 정렬, 먼저 쓴 컬럼 우선 정렬, 중복시, 그 다음 정렬옵션 적용.
select * from author order by name desc, email asc; --asc 안넣어도 오름차순으로 정렬되지만 그냥 적어봄, name으로 정렬하고 중복되면 email로 정렬

-- 결과값 개수 제한
select  * from author order by id desc limit 2;

-- 별칭을 이용한 select 
select name as '이 름', email as '이메일' from author; --이름과 이메일로 출력되게끔 해서 조회하기
select a.name, a.email from author as a;
select a.name, a.email from author a;

-- null을 조회조건으로 활용
select * from author where password is null;
select * from author where password is not null;


-- 프로그래머스 sql 문제풀이
-- 여러 기준으로 정렬하기
SELECT ANIMAL_ID, NAME, DATETIME FROM ANIMAL_INS ORDER BY NAME, DATETIME desc;
-- 상위 n개 레코드
select name from ANIMAL_INS order by DATETIME limit 1;