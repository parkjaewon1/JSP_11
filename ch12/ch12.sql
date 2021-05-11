create table manager (
	managerId varchar2(12) primary key, 
	managerPasswd varchar2(12) not null
);

select * from member2;
insert into manager values ('master','1234');
create sequence book_seq;
select * from book;
create table book (
	book_id number(10) primary key,
	book_kind varchar2(3) not null, 
	book_title varchar2(100) not null,
	book_price number(10) not null, 
	book_count number(5) not null,
	author varchar2(20),
	publishing_com varchar2(30), 
	publishing_date varchar2(15),
	book_image varchar2(16) default 'nothing.jpg',
	book_content varchar2(500), 
	discount_rate number(3),
	reg_date date
);


create table bank (
	account varchar2(30) primary key, 
	bank varchar2(16) not null, 
	name varchar2(12) not null
);


insert into bank values('111-111-1111','신한','길동');
insert into bank values ('222-2222-2222','국민', '설현');
insert into bank values('333-333-3333', '하나', '수지');
select * from bank;

create sequence cart_seq;
create table cart (
	cart_id number(10) primary key,
	buyer varchar2(12) not null, 
	book_id number(10) not null,
	book_title varchar2(100), 
	buy_price number(10) not null,
	buy_count number(5) not null,
	book_image varchar2(16) default 'nothing.jpg'
);

create table buy (
	buy_id number primary key , 
	buyer varchar2(12) not null, 
	book_id varchar2(12), 
	book_title varchar2(100), 
	buy_price number(10) not null, 
	buy_count number(5) not null, 
	book_image varchar2(16) default 'nothing.jpg', 
	buy_date date, account varchar2(50), 
	deliveryName varchar2(12), 
	deliveryTel varchar2(20), 
	deliveryAddress varchar2(80), 
	sanction varchar2(12) default '준비중' 
);

alter table member2 add(del char(1));