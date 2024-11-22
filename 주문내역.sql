create database shopping;
use shopping;
ALTER DATABASE shopping DEFAULT CHARACTER SET = utf8mb4;

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
   country varchar(255) ,
   city varchar(255) ,
   street varchar(255) ,
   created_time datetime NULL default current_timestamp(),
   PRIMARY KEY (id),
   foreign key(user_id) references user(id)
 );

CREATE TABLE order_cart(
    id bigint(20) auto_increment,
    customer_id bigint(20) not null,
    PRIMARY KEY (id),
    foreign key(customer_id) references user(id)
 );

create table order_detail(
    id bigint(20) auto_increment primary key,
    order_id bigint(20) not null,
    customer_id bigint(20) not null,
    product_id bigint(20) not null,
    foreign key(order_id) references order_cart(id),
    foreign key(customer_id) references order_cart(customer_id),
    foreign key(product_id) references product(id)
 );
 select * from user;
 insert into celler(name,email ,password) values('임성재','99dlatjdwo@naver.com','1234');
 insert into celler(name,email ,password) values('김호영','kim@naver.com','1353');
 insert into celler(name,email ,password) values('김유민','mini@naver.com','fw232');
 insert into celler(name,email ,password) values('고준혁','gogoo@naver.com','hy5h65');
 insert into celler(name,email ,password) values('홍노스','hong@naver.com','f53fq2');
 insert into celler(name,email ,password) values('추가연','choo@naver.com','j67j6j');
 
 insert into user(name,email ,password) values('박종현','park@naver.com','j3f211');
 insert into user(name,email ,password) values('김도영','dododo@naver.com','i9j89h9o');
 insert into user(name,email ,password) values('두형서','millitary@naver.com','ji2jio1');
 insert into user(name,email ,password) values('김승준','jun@naver.com','v54vb65e6e');
 insert into user(name,email ,password) values('윤지민','yoon@naver.com','v3qghq35');
 insert into user(name,email ,password) values('이승리','victory@naver.com','929um91');
 
 select * from celler;
 insert into product(celler_id, product, stock) values(3,'orange',5);
 insert into product(celler_id, product, stock) values(2,'banana',9);
 insert into product(celler_id, product, stock) values(1,'grape',3);
 insert into product(celler_id, product, stock) values(5,'pineapple',17);
 insert into product(celler_id, product, stock) values(4,'apple',14);
 insert into product(celler_id, product, stock) values(3,'coconut',4);
 insert into product(celler_id, product, stock) values(2,'orange',0);
 
 select * from user_address;
 insert into user_address(user_id, country, city, street) values(1,'한국','남양주시', '덕소로');
 insert into user_address(user_id, country, city, street) values(2,'한국','서울시', '도봉로');
 insert into user_address(user_id, country, city, street) values(3,'한국','구리시', '신대방로');
 insert into user_address(user_id, country, city, street) values(4,'중국','청주시', '미래로');
 insert into user_address(user_id, country, city, street) values(5,'일본','오산시', '오산로');
 insert into user_address(user_id, country, city, street) values(6,'호주','nimo', 'sun street');
 
 select * from order_cart;
 insert into order_cart(customer_id) values(3);
 insert into order_cart(customer_id) values(1);
 insert into order_cart(customer_id) values(2);
 insert into order_cart(customer_id) values(5);
 insert into order_cart(customer_id) values(6);
 insert into order_cart(customer_id) values(4);
 insert into order_cart(customer_id) values(2);
 
 select * from product;
 insert into order_detail(order_id,customer_id,product_id) values (1, 3, 4);
 insert into order_detail(order_id,customer_id,product_id) values (2, 3, 5);
 insert into order_detail(order_id,customer_id,product_id) values (3, 1, 2);
 insert into order_detail(order_id,customer_id,product_id) values (4, 2, 2);
 insert into order_detail(order_id,customer_id,product_id) values (5, 5, 1);
 insert into order_detail(order_id,customer_id,product_id) values (6, 6, 6);
 insert into order_detail(order_id,customer_id,product_id) values (7, 5, 7);
 insert into order_detail(order_id,customer_id,product_id) values (8, 2, 1);

 update product set price = 5000 where id=1;
 update product set price = 4000 where id=2;
 update product set price = 7000 where id=3;
 update product set price = 10000 where id=4;
 update product set price = 12000 where id=5;
 update product set price = 9000 where id=6;
 update product set price = 10000 where id=7;
 update order_detail set order_id = 2 where id=2;

 --주문 내역이 가장 많은 사람
 select customer_id,count(*) from order_detail group by 