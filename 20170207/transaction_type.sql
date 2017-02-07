-- transaction type

commit;

set transaction read only;

-- error : read only 이기 때문에 현재 트랜젝션에서는 update delete insert 불가
delete from book;

-- default
commit;
set transaction read write;

insert into book values(3, '토지', sysdate, '대여중', 1);
select * from book;