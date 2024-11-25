-- view : 실제 데이터를 참조하는 가상의 테이블
-- 사용 목적: 1)복잡한 쿼리 대신 2) 테이블의 컬럼까지 권한 분리

-- view 생성
create view author_for_marketing as select name, email from author;

-- view 조회
select * from author_for_marketing;

-- view 제거
drop view author_for_marketing;

-- view 권한부여
grant select on board.author_for_marketing to '계정명'@'localhost';

-- procedure 생성
DELIMITER //
create procedure hello_procedure()
begin
    select 'hello world';
end
// DELIMITER ;

-- procedure 호출
call hello_procedure();

--프로시저 삭제
drop procedure hello_procedure;

-- 게시글 목록 조회 procedure 생성
DELIMITER //
create procedure 게시글목록조회()
begin
    select * from post;
end
// DELIMITER ;

call 게시글목록조회();

-- 게시글 id 단건 조회
DELIMITER //
create procedure 게시글id단건조회(in postid bigint)
begin
    select * from post where id = postid;
end
// DELIMITER ;

call 게시글id단건조회(1);


-- 게시글목록조회 by email
DELIMITER //
create procedure 게시글목록조회byemail(in inputEmail varchar(255))
begin
    select p.id, p.title, p.contents from post p inner join author_post ap 
    on p.id = ap.post_id inner join author a on a.id = ap.author_id where a.email = inputEmail;
end
// DELIMITER ;


-- 글쓰기
DELIMITER //
create procedure 글쓰기(in inputTitle varchar(255), inputContents varchar(255),inputEmail varchar(255))
begin
   declare authorId bigint;
   declare postId bigint;
   insert into post(title,contents) values(inputTitle, inputContents);
   select id into postId from post order by id desc limit 1;
   select id into authorId from author where email = inputEmail;
   insert into author_post(author_id, post_id) values(authorId,postId);
end
// DELIMITER ;

--글삭제 : 입력값으로 글 id 본인 email
DELIMITER //
create procedure 글삭제(in inputPostId bigint ,inputEmail varchar(255))
begin
    declare authorPostCount bigint;
    declare authorId bigint
    select count(*) into authorPostCount from author_post where post_id = inputPostId;
    select id into authorId from author where email = inputEmail;
    If authorPostCount>=2 then
       delete from author_post where post_id = inputPostId and author_id = authorId;
    else
       delete from author_post where post_id = inputPostId;
       delete from post where id = (select post_id from author_post where post_id = inputPostId);
    end if;
end
// DELIMITER ;


-- 반복문을 통해 post 대량생성 : 입력값은 반복횟수 count, 글쓴이 email
DELIMITER //
create procedure 글도배(in count int ,inputEmail varchar(255))
begin
   declare countValue int default 0;
   declare authorId bigint;
   declare postId bigint;
   while countValue < count do
      insert into post(title) values('안녕하세요');
      select id into postId from post order by id desc limit 1;
      select id into authorId from author where email = inputEmail;
      insert into author_post(author_id, post_id) values(authorId,postId);
      set countValue = countValue + 1;
   end while;
end
// DELIMITER ;