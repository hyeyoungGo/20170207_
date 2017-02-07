insert into book values(1, '토지', sysdate, '대여중', 1);

update book set title = '토지1-1' where no = 1;

commit;

select * from book;