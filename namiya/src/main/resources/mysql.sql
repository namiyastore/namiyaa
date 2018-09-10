/* Drop Tables */

DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE categories CASCADE CONSTRAINTS;
DROP TABLE favorite CASCADE CONSTRAINTS;
DROP TABLE history CASCADE CONSTRAINTS;
DROP TABLE interest CASCADE CONSTRAINTS;
DROP TABLE keyword CASCADE CONSTRAINTS;
DROP TABLE notice CASCADE CONSTRAINTS;
DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;
DROP TABLE message CASCADE CONSTRAINTS;
DROP TABLE mystore CASCADE CONSTRAINTS;
DROP TABLE saving CASCADE CONSTRAINTS;


/* Create Tables */

CREATE TABLE board
(
	boardnum number NOT NULL,
	productnum number NOT NULL constraint productnum_fk REFERENCES product(productnum),
	userid varchar2(100) NOT NULL,
	regdate date DEFAULT sysdate,
	title varchar2(100) NOT NULL,
	content varchar2(1000) NOT NULL,
	service varchar2(20) NOT NULL,
	originalfile varchar2(100),
	savedfile varchar2(100),
	PRIMARY KEY (boardnum)
);


CREATE TABLE categories
(
	categorynum number NOT NULL,
	categoryname varchar2(200) NOT NULL,
	depth number NOT NULL,
	parentnum number NOT NULL,
	PRIMARY KEY (categorynum)
);


CREATE TABLE favorite
(
	favoritenum number NOT NULL,
	myurl varchar2(50) NOT NULL,
	userid varchar2(100) NOT NULL constraint userid2_fk references members(userid),
	PRIMARY KEY (favoritenum)
);


CREATE TABLE history
(
   historynum number NOT NULL,
    productnum number NOT NULL,
   sellerid varchar2(100) NOT NULL,
   buyerid varchar2(100),
   deal_start date,
    deal_end date,
   PRIMARY KEY (historynum)
);


CREATE TABLE interest
(
	interestnum number NOT NULL,
	userid varchar2(100) NOT NULL constraint userid_fk references members(userid),
	boardnum number NOT NULL,
	PRIMARY KEY (interestnum)
);


CREATE TABLE keyword
(
	keywordnum number NOT NULL,
	keywordname varchar2(50) NOT NULL,
	category varchar2(100) NOT NULL,
	userid varchar2(100) NOT NULL,
	PRIMARY KEY (keywordnum)
);


CREATE TABLE members
(   
   userid varchar2(100) primary key,
   password varchar2(30) NOT NULL,
   username varchar2(20) NOT NULL,
   birthday varchar2(30) NOT NULL,
   gender varchar2(10) NOT NULL,
   email varchar2(100) NOT NULL,
   phoneno varchar2(30) NOT NULL,
   fulladdr varchar2(100) NOT NULL,
   zipcode varchar2(10) NOT NULL,
   myurl varchar2(50) NOT NULL UNIQUE
);


CREATE TABLE message
(
	messagenum number NOT NULL,
	writerid varchar2(100) NOT NULL,
	msg_title varchar2(100) NOT NULL,
	msg_content varchar2(1000) NOT NULL,
	regdate date DEFAULT sysdate,
	userid varchar2(100) NOT NULL,
	copy number NOT NULL,
	PRIMARY KEY (messagenum)
);


CREATE TABLE mystore
(
	imagenum number NOT NULL,
	userid varchar2(100) NOT NULL,
	itemnum number NOT NULL constraint itemnum_fk REFERENCES imageitem(itemnum), 
	currentframe number NOT NULL,
	px number NOT NULL,
	py number NOT NULL,
    imageorder number NOT NULL,
	PRIMARY KEY (imagenum)
);

create table imageitem 
(
    itemnum number NOT NULL,
	totalframes number NOT NULL,
	width number NOT NULL,
	height number NOT NULL,
	filename varchar2(200) NOT NULL,
    type varchar2(100) not null,
    PRIMARY KEY (itemnum)
);

create table useritem 
(
    useritemnum number NOT NULL,
    userid varchar2(100) NOT NULL,
	itemnum number NOT NULL constraint useritem_fk REFERENCES imageitem(itemnum),
    PRIMARY KEY (useritemnum)
);


CREATE TABLE notice
(
	noticenum number NOT NULL,
	userid varchar2(100) NOT NULL constraint userid3_fk references members(userid),
	boardnum number NOT NULL,
	PRIMARY KEY (noticenum)
);


CREATE TABLE product
(
	productnum number NOT NULL,
	categorynum number NOT NULL constraint categorynum_fk references categories(categorynum),
	productname varchar2(50) NOT NULL,
	sstatus varchar2(30) DEFAULT '등록',
	PRIMARY KEY (productnum)
);


CREATE TABLE review
(
        reviewnum number NOT NULL,
        userid varchar2(100) NOT NULL,
        review_content varchar2(1000) NOT NULL,
        regdate date DEFAULT sysdate,
        store_owner varchar2(100) NOT NULL,
        PRIMARY KEY (reviewnum)
);


create table saving (
	saving_seq number,
	userid varchar2(100) not null constraint saving_fk references members(userid),
	point number  NOT NULL ,
	type varchar2(50) not null,
	regdate date default sysdate,
	PRIMARY KEY (saving_seq) 
);

create table profile (
	profile_seq number not null,
	userid varchar2(100)  NOT NULL constraint profile_fk references members(userid),
	originalfile varchar2(100),
	savedfile varchar2(100),
	content varchar2(1000),
	nickname varchar2(100),
	PRIMARY KEY (profile_seq)
);

CREATE TABLE categoriesen
(
	categorynum number NOT NULL,
	categoryname varchar2(200) NOT NULL,
	depth number NOT NULL,
	parentnum number NOT NULL,
	PRIMARY KEY (categorynum)
);

CREATE TABLE categoriesja
(
	categorynum number NOT NULL,
	categoryname varchar2(200) NOT NULL,
	depth number NOT NULL,
	parentnum number NOT NULL,
	PRIMARY KEY (categorynum)
);

/* Create Tables */
create sequence boardnum_seq;
create sequence reviewnum_seq;
create sequence productnum_seq;
create sequence categorynum_seq;
create sequence favoritenum_seq;
create sequence interestnum_seq;
create sequence messagenum_seq;
create sequence keywordnum_seq;
create sequence historynum_seq;
create sequence noticenum_seq;
create sequence mystore_seq;
create sequence imageitem_seq;
create sequence useritem_seq;
create sequence profile_seq;