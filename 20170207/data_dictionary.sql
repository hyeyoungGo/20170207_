-- data dictionary

SELECT * FROM dictionary;

SELECT * FROM user_objects;

-- table 조회

SELECT *
  FROM user_objects
 WHERE object_type = 'TABLE';

-- 제약조건 확인

SELECT *
  FROM user_constraints
 WHERE table_name = 'BOOK';

-- 현재 접속한 계정 정보

SELECT * FROM user_users;