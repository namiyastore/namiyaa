
/* Drop Tables */

DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;
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
	sellerid varchar2(100) NOT NULL,
	buyerid varchar2(100) NOT NULL,
	regdate date DEFAULT sysdate,
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
	userid varchar2(100) NOT NULL,
	password varchar2(30) NOT NULL,
	username varchar2(20) NOT NULL,
	email varchar2(100) NOT NULL,
	phone varchar2(30) NOT NULL,
	zip varchar2(10) NOT NULL,
	address varchar2(150) NOT NULL,
	myurl varchar2(50) NOT NULL UNIQUE,
	PRIMARY KEY (userid)
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
	totalframes number NOT NULL,
	currentframe number NOT NULL,
	width number NOT NULL,
	height number NOT NULL,
	filename varchar2(200) NOT NULL,
	px number NOT NULL,
	py number NOT NULL,
	PRIMARY KEY (imagenum)
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
	store_owner varchar2(100) NOT NULL constraint userid4_fk references members(userid),
	PRIMARY KEY (reviewnum)
);


CREATE TABLE saving
(
	userid varchar2(100) NOT NULL,
	point number DEFAULT 0,
	priority number(1) DEFAULT 0,
	PRIMARY KEY (userid)
);

