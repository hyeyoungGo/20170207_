-- constraint 추가하는 방법 2(alter table)

drop table book  cascade constraint;

-- create table
create table book (
	no       number(10),
	title    varchar2(100) not null,
	author   varchar2(10),
	pub_date date,
	state 	 varchar2(20),
	author_no number(10)
);

insert into book
	values (1, '토지', to_date('2017/02/07', 'yyyy/mm/dd'), '대여가능', 1);
	
alter table book add constraint c_book_pk primary key(no);
alter table book add constraint c_book_check check(state in ('대여중', '대여가능'));
alter table book add constraint c_book_fk foreign key(author_no) references author(no);

-- 제약조건 삭제
alter table book drop constraint c_book_check;
alter table author drop primary key cascade;

