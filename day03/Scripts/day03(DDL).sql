-- 2. DDL

CREATE TABLE TBL_USER(
	USER_NAME	VARCHAR2(100)
  , USER_AGE	NUMBER
);

SELECT 	*
FROM 	tbl_user;

-- 테이블명 수정
-- ALTER TABLE 테이블명 RENAME TO 새로운 테이블명;
ALTER TABLE tbl_user
RENAME TO TBL_MY_USER;

SELECT	*
FROM 	tbl_user;

SELECT 	*
FROM 	tbl_my_user;

-- 컬럼명 수정
-- ALTER TABLE 테이블명 RENAME COLUMN 기존컬럼명 TO 새로운테이블명;
ALTER TABLE TBL_MY_USER
RENAME COLUMN user_name TO USER_NICKNAME;

-- 컬럼 타입 수정
-- ALTER TABLE 테이블명 MODIFY(컬럼명 자료형(용량));
ALTER TABLE TBL_MY_USER
MODIFY(user_nickname varchar2(500));

-- 컬럼 추가
-- ALTER TABLE 테이블명 ADD(컬럼명 자료형(용량));
ALTER TABLE tbl_my_user
ADD(USER_GENDER char(1));

ALTER TABLE tbl_my_user
ADD(USER_HOBBY varchar2(100));

-- 컬럼 삭제
ALTER TABLE tbl_my_user
DROP COLUMN user_gender;

-- 데이터 삽입 INSERT -> DML
INSERT INTO TBL_MY_USER
VALUES('짱구', 5, 'M', '엑션가면놀이');

INSERT INTO TBL_MY_USER
values('철수', 5, '공부하기');

-- TRUNCATE -> DDL
TRUNCATE TABLE tbl_my_user;

-- DELETE -> DML
DELETE FROM tbl_my_user;

-- 테이블 삭제 DROP TABLE 테이블명
DROP TABLE tbl_my_user;

SELECT 	*
FROM 	tbl_my_user;

-- [실습] 자동차 테이블 생성 TBL_CAR
-- 자동차 번호	NUMBER 숫자
-- 자동차 이름	NAME 문자(1000)
-- 자동차 브랜드	BRAND 문자(1000)
-- 출시 날짜 RELEASEDATE 날짜
-- 색상 COLOR 문자(1000)
-- 가격 PRICE 숫자

CREATE TABLE TBL_CAR(
	CAR_NUMBER	NUMBER CONSTRAINT PK_CAR PRIMARY KEY
  , CAR_NAME	VARCHAR2(1000)
  , CAR_BRAND	VARCHAR2(1000)
  , CAR_RELEASEDATE	DATE
  , CAR_COLOR	VARCHAR2(1000)
  , CAR_PRICE	NUMBER
);

-- 제약조건 추가
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건의 이름(PK_테이블명) PRIMARY KEY(컬럼명)
ALTER TABLE tbl_car
ADD CONSTRAINT PK_CAR
PRIMARY KEY(CAR_NUMBER);
-- ALTER TABLE tbl_car : tbl_car 테이블을 수정한다
-- ADD : 추가하다
-- CONSTRAINT : 제약조건
-- PK_CAR PRIMARY KEY(CAR_NUMBER) : PK_CAR 이름으로 PRIMARY KEY 라는(PK) 제약조건을 CAR_NUMBER 컬럼에

-- 제약조건 삭제
ALTER TABLE tbl_car
DROP CONSTRAINT pk_car;

-- 테이블 삭제
DROP TABLE tbl_animal;

SELECT 	*
FROM 	tbl_car;

--DROP TABLE tbl_member;
--DROP TABLE tbl_student;

-- 동물 테이블 TBL_ANIMAL
-- 고유 번호 NUMBER
-- 종류 KIND
-- 나이 AGE
-- 먹이 FEED

-- 1. 테이블 조회 후 TBL_ANIMAL 테이블의 제약조건 및 관계도 확인
-- 2. 제약조건 추가 테이블 생성 후 추가(PK)
-- 3. 컬럼 추가 성별(GENDER 문자(1))
-- 4. 컬럼 이름 수정(고유번호) NUMBER -> ID로 변경
-- 5. 컬럼 삭제(먹이)
-- 6. 컬럼 수정(종류컬럼을 자료형 NUMBER로 설정)
CREATE TABLE TBL_ANIMAL(
	ANI_NUMBER	NUMBER
  ,	ANI_KIND	VARCHAR(1000)
  , ANI_AGE		NUMBER
  , ANI_FEED	VARCHAR(1000)
);

ALTER TABLE tbl_animal
ADD CONSTRAINT PK_ANIMAL
PRIMARY key(ANI_ID);

ALTER TABLE tbl_animal
ADD(ANI_GENDER char(1));

-- pk가 적용되어 있어도 컬럼 명이 수정되면 같이 수정된다
ALTER TABLE tbl_animal
RENAME column ANI_NUMBER TO ANI_ID;

ALTER TABLE tbl_animal
DROP COLUMN ANI_FEED;

ALTER TABLE tbl_animal
MODIFY(ANI_KIND number);

SELECT 	*
FROM 	tbl_animal;

ALTER TABLE tbl_animal
DROP CONSTRAINT pk_ani;


-- RENAME CONSTRAINT는 오라클에서 지원하지 않는다
--ALTER TABLE tbl_animal
--RENAME pk_ani CONSTRAINT PK_ANMAL_ID
--PRIMARY key(ani_id);

-- ANIMAL 테이블에 데이터 추가 -> DML INSERT
-- DML 명령어 : SELECT, UPDATE, INSERT, DELETE
-- DDL 명령어 : CREATE, ALETER, DROP, TRUNCATE

INSERT INTO tbl_animal
values(1, 1, 5, 'F');

--INSERT INTO tbl_animal
--values(NULL, 2, 3, 'M');  -- ANIMAL_ID가 PK라서 NULL을 허용하지 않음

--INSERT INTO tbl_animal
--values(1, 2, 3, 'M');  -- ANIMNAL_ID가 PK라서 중복을 허용하지 않음

SELECT 	*
FROM 	tbl_animal;

DROP TABLE tbl_animal;
DROP TABLE tbl_car;

-- FK 설정
-- 학교 테이블 학생 테이블
CREATE TABLE tbl_school(
	school_number	NUMBER CONSTRAINT pk_school PRIMARY KEY
  , school_name		varchar(1000)
);

SELECT 	*
FROM 	tbl_school;

-- 학생테이블
CREATE TABLE tbl_student(
	student_number	NUMBER
  ,	student_name	varchar(1000)
  , student_age		NUMBER
  , school_number	number
  ,	CONSTRAINT pk_student PRIMARY KEY(student_number)
  , CONSTRAINT fk_student FOREIGN key(school_number) REFERENCES tbl_school(school_number)
);

DROP TABLE tbl_student;

SELECT 	*
FROM	tbl_school;

SELECT 	*
FROM 	tbl_student;

-- 상위 테이블의 값부터 채워준다
INSERT INTO TBL_SCHOOL
--VALUES(1, 'DBMS 고등학교');
--VALUES(2, 'JAVA 고등학교');
VALUES(3, 'PYTHON 고등학교');

-- 하위 테이블의 값을 채워준다
INSERT INTO tbl_student
--values(1, '김철수', 17, 1);
--values(2, '신유리', 17, 1);
--values(3, '신짱구', 18, 2);
values(4, '최영', 19, 3);
--values(1, '김철수', 17, 5);
-- 오류 발생! FK 인 SCHOOL_NUMBER에 상위 테이블에 존재하지 않는 값을 저장하려 하면 오류 발생

-- 제약조건 UK(Unique) : 고유한 값이지만 NULL을 허용한다
-- 학생 테이블 STU
CREATE TABLE tbl_stu(
	stu_number	NUMBER
  , stu_name	varchar(1000)
  , stu_major	varchar(100)
  , stu_id		NUMBER
  , stu_gender	char(1) DEFAULT 'M'
  						CONSTRAINT stu_gender_nn NOT NULL
  						CONSTRAINT check_gen check(stu_gender = 'M' OR stu_gender = 'W')
  , CONSTRAINT pk_stu PRIMARY key(stu_number)
  , CONSTRAINT uk_stu UNIQUE(stu_id)
);


-- stu_gender	char(1) DEFAULT 'M' NOT NULL check(stu_gender = 'M' OR stu_gender = 'W')
-- DEFAULT 'M' : 데이터가 들어오지 않으면 무조건 'M'이 기본값으로 들어오게 하겠다
-- NOT NULL : 디폴트값을 M로 설정했으나 NULL값을 강제로 넣는 것을 막기 위해 사용하는 제약조건
-- CHECK(STU_GENDER = 'M' OR STU_GENDER = 'W') : 이 컬럼의 값은 M 또는 W만 들어오도록 하는 제약조건

DROP TABLE tbl_stu;

SELECT 	*
FROM	tbl_stu;

INSERT INTO tbl_stu(stu_number, stu_name, stu_major, stu_id)
values(1, '짱구', NULL, '1111');

UPDATE	tbl_stu
SET		STU_ID = '111'
WHERE 	stu_name = '짱구';

INSERT INTO tbl_stu
--values(2, '철수', '컴공', '222', 'M');
values(3, '유리', '컴공', 333, 'W');

-- 조합키
-- PK를 2개의 컬럼으로 조합하여 설정한 것을 의미
CREATE TABLE tbl_flower(
	flower_name		varchar(1000)
  , flower_color	varchar(1000)
  , flower_price	NUMBER
  , CONSTRAINT pk_flower PRIMARY key(flower_name, flower_color)
);

INSERT INTO tbl_flower
VALUES('튤립', '노랑', 9000);

INSERT INTO tbl_flower
values('튤립', '빨강', 9000);

INSERT INTO tbl_flower
values('튤립', '파랑', 9000);

INSERT INTO tbl_flower
VALUES('해바라기', '노랑', 9000);

INSERT INTO tbl_flower
values('해바라기', '빨강', 9000);

INSERT INTO tbl_flower
values('해바라기', '파랑', 9000);

SELECT 	*
FROM 	tbl_flower;

CREATE TABLE TBL_USER(
	USER_ID			VARCHAR(1000)
  , USER_NAME		VARCHAR(1000) CONSTRAINT USER_NAME_NN NOT NULL
  , USER_ADDRESS	VARCHAR(1000) CONSTRAINT USER_ADDRESS_NN NOT NULL
  , USER_EMAIL		VARCHAR(100)
  , USER_BRITH		DATE
  , CONSTRAINT USER_ID_PK PRIMARY KEY(USER_ID)
  , CONSTRAINT USER_EMAIL_UK UNIQUE(USER_EMAIL)
);

SELECT 	*
FROM 	tbl_user;

ALTER TABLE tbl_user
DROP CONSTRAINT user_email_nn;

DROP TABLE tbl_user;

--	TBL_USER
--	USER_NUMBER(PK)	NUMBER
--	USER_NAME	VARCAHR(100)  N/N
--	USER_AGE	NUMBER
--	USER_PHONE(UK)	VARCHAR(1000) N/N
--	USER_ADDRESS	VARCHAR(1000)
CREATE TABLE TBL_USER(
	USER_NUMBER		NUMBER
  , USER_NAME		VARCHAR2(100) CONSTRAINT USER_NAME_NN NOT NULL
  , USER_AGE		NUMBER
  , USER_PHONE		VARCHAR2(1000) CONSTRAINT USER_PHONE_NN NOT NULL
  , UERR_ADDRESS	VARCHAR2(1000)
  , CONSTRAINT USER_NUMBER_PK PRIMARY KEY(USER_NUMBER)
  , CONSTRAINT USER_PHONE_UL UNIQUE(USER_PHONE)
);

SELECT 	*
FROM 	tbl_user;

INSERT INTO tbl_user
VALUES(1, '길진수', 27, '010-0000-0000', '경기도');

DELETE from tbl_user;

DROP TABLE tbl_user;

--	TBL_BOOK
--	BOOK_NUMBER(PK)	NUMBER
--	BOOK_NAME	VARCHAR(100) N/N
--	BOOK_GENRE	CHAR(1)		N/N
--	USER_NUMBER(FL)	NUMBER
CREATE TABLE TBL_BOOK(
	BOOK_NUMBER	NUMBER
  , BOOK_NAME	VARCHAR2(1000) CONSTRAINT BOOK_NAME_NN NOT NULL
  , BOOK_GENRE	VARCHAR2(100)  CONSTRAINT BOOK_GENRE_NN NOT NULL
  							   CONSTRAINT BOOK_GENRE_CK CHECK(BOOk_GENRE = '인문학'
  							  							   OR BOOK_GENRE = 'IT'
  							  							   OR BOOK_GENRE = '추리')
  , USER_NUMBER	NUMBER
  , CONSTRAINT BOOK_NUMBER_PK PRIMARY KEY(BOOK_NUMBER)
  , CONSTRAINT USER_NUMBER_FK FOREIGN KEY(USER_NUMBER) REFERENCES TBL_USER(USER_NUMBER)
);

SELECT 	*
FROM	tbl_book;


TRUNCATE TABLE tbl_book;

DROP TABLE tbl_book;

CREATE TABLE TBL_USER2(
	USER2_NUMBER	NUMBER
  , USER2_NAME		VARCHAR2(1000)
  , USER2_AGE		NUMBER
  , CONSTRAINT USER2_NUMBER_PK PRIMARY KEY(USER2_NUMBER)
);

SELECT 	*
FROM	tbl_user2;

CREATE SEQUENCE HR.SEQ_USER2;

INSERT INTO tbl_user2
--VALUES(SEQ_USER2.NEXTVAL, '짱구', 5);
--VALUES(SEQ_USER2.NEXTVAL, '철수', 5);
VALUES(SEQ_USER2.NEXTVAL, '짱아', 4);