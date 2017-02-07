-- constraints


drop table book;

-- create table
create table book (
	no       number(10),
	title    varchar2(100) not null,
	author   varchar2(10), -- default '',
	pub_date date,
	
	constraint c_book_u unique(no) -- nuique constranint
);

--insert
insert into book
	values (null, '토지', '박경리', to_date('2017/02/07', 'yyyy/mm/dd'));
	
insert into book(title, author, pub_date)
	values ('토지', '박경리', to_date('2017/02/07', 'yyyy/mm/dd'));

-- title not null 에러
insert into book(author, pub_date)
	values ('박경리', to_date('2017/02/07', 'yyyy/mm/dd'));


-- unique 컬럼은 null이 insert 될 수 있다.
insert into book(no, title, author, pub_date)
	values (1, '토지1', '박경리1', to_date('2017/02/07', 'yyyy/mm/dd'));

-- no가 중복되면 unique 에러가 난다.
insert into book(no, title, author, pub_date)
	values (1, '토지2', '박경리2', to_date('2017/02/07', 'yyyy/mm/dd'));

-- select
select * from book;

---------------------------------------------------------------------------------------------
-- drop
drop table book cascade constraint;

-- create table
create table book (
	no       number(10),
	title    varchar2(100) not null,
	author   varchar2(10),
	pub_date date,
	state 	 varchar2(20),
	
	--constraint c_book_u unique(no) -- nuique constraint
	primary key(no),				 -- primary key constraint
	constraint c_book_check check(state in ('대여중', '대여가능'))
);

-- error : check constraraint (state)
insert into book
	values (1, '토지2', '박경리2', to_date('2017/02/07', 'yyyy/mm/dd', '대여'));

insert into book
	values (1, '토지3', '박경리3', to_date('2017/02/07', 'yyyy/mm/dd'),'대여중');
	
insert into book
	values (3, '토지5', '박경리5', to_date('2017/02/07', 'yyyy/mm/dd'), '대여가능');
	
-- primary key는 null이 삽입될수 없다.
insert into book(title, author, pub_date)
	values ('토지2', '박경리2', to_date('2017/02/07', 'yyyy/mm/dd'));
	
insert into book
	values (1, '토지2', '박경리2', to_date('2017/02/07', 'yyyy/mm/dd'));

-- select
select * from book;

-----------------------------------------------------------------------------------------------

-- author table 생성
create table author (
	no number(10),
	name varchar(50) not null,
	description varchar(2000) default '',
	primary key(no)
);

insert into author values(1, '박경리', '호롤롤로');
insert into author values(2, '고혜영', DEFAULT);
select * from author;

drop table author cascade constraint;

------------------------------------------------------------------------------------------------------

-- drop
drop table book;

-- create table
create table book (
	no       number(10),
	title    varchar2(100) not null,
	pub_date date,
	state 	 varchar2(20),
	author_no number(10),
	
	--constraint c_book_u unique(no) -- nuique constraint
	primary key(no),				 -- primary key constraint
	constraint c_book_check check(state in ('대여중', '대여가능')),
	constraint c_book_fk 			 -- foreign key constraint
	foreign key (author_no)
	references author(no)
	-- on delete cascade
	on delete set null
);
-- error: foreign key constraint
delete from author where no = 1;

-- error: foreign key constraint(author_no)
insert into book
	values (1, '토지2', to_date('2017/02/07', 'yyyy/mm/dd'), '대여가능', 2);

-- error: not null constraint(author_no)
insert into book
	values (1, '토지2', to_date('2017/02/07', 'yyyy/mm/dd'), '대여가능', null);

-- success
insert into book
	values (1, '토지', to_date('2017/02/07', 'yyyy/mm/dd'), '대여가능', 1);

delete from author where no = 1;
select * from author;
select * from book;

select a.TITLE,
	   to_char(a.PUB_DATE, 'yyyy/mm/dd') as PUB_DATE,
	   a.STATE,
	   b.NAME, 
	   b.DESCRIPTION
 	from book a, author b
	where a.author_no = b.no;