CREATE SEQUENCE seq_user;

-- 사용자 정보 저장하는 유저 테이블 tbl_user
-- 사용자 번호
-- 아이디
-- 비밀번호
-- 이름
-- 나이
-- 성별
-- 생일

CREATE TABLE tbl_user(
	USER_number	NUMBER
  , user_id		varchar2(100)
  , user_pw		varchar2(100)
  , user_name	varchar2(10)
  , user_age	NUMBER
  , user_gender char(1) DEFAULT 'M'
  , user_birth	DATE
  , CONSTRAINT pk_user PRIMARY key(user_number)
	
);

SELECT 	*
FROM 	tbl_user;

INSERT INTO tbl_user
VALUES
--(seq_user.nextVal, 'aaa', '1234', '홍길동', 22, 'M', '20000101');
--(seq_user.nextVal, 'bbb', '1234', '길진수', 10, 'M', '19980723');

INSERT INTO tbl_user(user_number, USER_id, USER_pw, USER_name, user_age, user_gender, user_birth)
VALUES
--(seq_user.nextval, 'ABC', '1234', '짱구', 5, 'M', '2000-01-01');

SELECT * from tbl_user;

DELETE FROM tbl_user
WHERE user_number = 21;

SELECT user_number
FROM	tbl_user
WHERE 	user_id = 'aaa' AND user_pw = '1234';

SELECT user_id
FROM	tbl_user
WHERE 	user_name = '홍길동' AND user_birth = '20000101';

UPDATE	tbl_user
SET		USER_id = ?
	  , user_pw = ?
	  , user_name = ?
	  , user_age = ?
	  , user_gender = ?
	  , user_birth = ?
;

SELECT 	user_id
	  , user_pw
	  , user_name
	  , user_age
	  , user_gender
	  , user_birth
FROM	tbl_user
WHERE 	user_number = 1
;

DELETE FROM tbl_user WHERE user_number = ?