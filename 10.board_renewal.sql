 -- 여러 사용자가 1개의 글을 수정할 수 있다 가정후 DB 리뉴얼
 -- author와 post 가 n:m 관계가 되어 관계 테이블을 별도로 생성
 CREATE TABLE author (
   id bigint(20) NOT NULL AUTO_INCREMENT,
   email varchar(255) NOT NULL,
   name varchar(255) NULL,
   password varchar(255) NULL,
   created_time datetime NULL default current_timestamp(),
   PRIMARY KEY (`id`)
 );

 CREATE TABLE post (
   id bigint(20) NOT NULL AUTO_INCREMENT,
   title varchar(255) NOT NULL,
   contents varchar(255) NULL,
   created_time datetime NULL default current_timestamp(),
   PRIMARY KEY (`id`)
 );

-- 1:1 관계인 author_address
-- 1:1 관계의 보장 author_id unique 설정
 CREATE TABLE author_address (
   id bigint(20) NOT NULL AUTO_INCREMENT,
   author_id bigint(20) NOT NULL unique,
   country varchar(255) NULL,
   cit varchar(255) NULL,
   street varchar(255) NULL ,
   created_time datetime NULL default current_timestamp(),
   PRIMARY KEY (`id`),
   foreign key(author_id) references author(id)
 );

 -- author_post 는 연결테이블로 생성
 create table author_post(id bigint auto_increment primary key,
 author_id bigint not null, post_id bigint not null,
 foreign key(author_id) references author(id),
 foreign key (post_id) references post(id));

 -- 복합키로 author_post 생성
 create table author_post2(
    author_id bigint not null,
    post_id bigint not null,
    primary key(author_id,post_id),
    foreign key(author_id) references author(id),
    foreign key (post_id) references post(id)
 );

insert into author(email, name) values ('hans1@naver.com',  'hans');
insert into author(email, name) values ('hans2@naver.com',  'hansi');
insert into author(email, name) values ('hans3@naver.com',  'hansu');
insert into author(email, name) values ('july1@naver.com',  'july');
insert into author(email, name) values ('july2@naver.com',  'jully');

insert into author_address(author_id, country, city, street) values ( 1, 'japan', 'osaka', 'nara');
insert into author_address(author_id, country, city, street) values ( 2, 'korea', 'incheon', 'san-ro');
insert into author_address(author_id, country, city, street) values ( 3, null, null, null);
insert into author_address(author_id, country, city, street) values ( 4, null, null, null);
insert into author_address(author_id, country, city, street) values ( 5, null, null, null);

insert into post(title, contents) values ( 'hello,java' , 'hi,i`m java!');
insert into post(title, contents) values ( 'hello,python' , 'hi,we are python!');

insert into author_post(author_id, post_id) values ( 1, 1);
insert into author_post(author_id, post_id) values ( 2, 1);
insert into author_post(author_id, post_id) values ( 5, 1);
insert into author_post(author_id, post_id) values ( 3, 2);
insert into author_post(author_id, post_id) values ( 4, 2);
insert into author_post(author_id, post_id) values ( 5, 2);

-- 내 id로 내가 쓴 글 조회
select * from post p inner join author_post ap on p.id = ap.post_id where ap.author_id =1;

-- 글 2번 이상 쓴 사람에 대한 정보 조회
select a.* from author a inner join author_post ap on a.id = ap.author_id 
group by a.id having count(a.id)>=2 order by author_id;


create table user(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    email varchar(255) not null,
    password varchar(255) not null,
    created_time datetime NOT NULL default current_timestamp()
 );

create table celler(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    email varchar(255) not null,
    password varchar(255) not null,
    created_time datetime NOT NULL default current_timestamp()
 );

create table product(
    id bigint auto_increment primary key,
    celler_id bigint not null,
    product varchar(255) not null,
    stock bigint not null,
    created_time datetime NOT NULL default current_timestamp(),
    foreign key(celler_id) references celler(id)
 );


CREATE TABLE user_address (
   id bigint(20) NOT NULL AUTO_INCREMENT,
   user_id bigint(20) NOT NULL,
   country varchar(255) NULL,
   city varchar(255) NULL,
   street varchar(255) NULL ,
   created_time datetime NULL default current_timestamp(),
   PRIMARY KEY (id),
   foreign key(user_id) references user(id)
 );


create table order(
    id bigint(20) auto_increment primary key,
    customer_id bigint(20) not null,
    foreign key(customer_id) references user(id)
 );

create table order_detail(
    id bigint(20) auto_increment primary key,
    order_id bigint(20) not null,
    customer_id bigint(20) not null,
    product_id bigint(20) not null,
    foreign key(order_id) references order(id),
    foreign key(customer_id) references order(customer_id),
    foreign key(product_id) references product(id)
 );

 -- 같은 상품을 2번 구매한 구매자의 이름과 상품명을 출력
 -- 1. 같은 상품을 2번 구매한 사람의 customer id 와 product id
 select customer_id,product_id from order_detail group by product_id, customer_id having count(*)>=2;
 -- 답안
 select u.name, p.product from user u inner join product p 
 where u.id = (select customer_id from order_detail group by product_id, customer_id having count(*)>=2)
 and p.id = (select product_id from order_detail group by product_id, customer_id having count(*)>=2);