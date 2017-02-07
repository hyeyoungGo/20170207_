--transaction savepoint
commit;

select * from book;

-- DML1
insert into book values(2, '토지', sysdate, '대여중', 2);

-- savepoint a
savepoint a;

-- DML2
delete from book where no = 2;

--savepoint b
savepoint b;

--DML3
insert into book values(2, '토지2', sysdate, '대여가능', 1);

--test
rollback to b;
