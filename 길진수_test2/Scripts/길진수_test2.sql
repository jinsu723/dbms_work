--1) 요구사항 분석
--도서관에서 회원의 정보와 책의 정보가 필요하다
--회원 정보 : 회원번호, 이름, 나이, 핸드폰번호, 주소
--책의 정보 : 도서번호, 책이름, 장르
--- 한명의 회원은 여러권을 책을 대여할 수 있다
--- 테이블 명 : WEB_MEMBER, WEB_BOOK (대여 테이블은 생각하지 않는다
--- 제약조건 : PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK
--- 회원번호 (Member_ID)와 도서번호 (Book_ID)는 각각의 테이블에서 UNIQUE해야
--함.
--- 장르 (Genre)는 '인문학', 'IT', '추리', '경영' 중 하나여야 함.
--- 회원의 나이, 핸드폰번호, 주소는 NULL일 수 있음.

--2) 개념적 설계
-- web_member		web_book
--	회원번호(PK)		도서번호(PK)
--	이름(NN)			책이름(NN)
--	나이				장르(CK)
--	핸드폰번호(UK)		회원번호(FK)
--	주소

--3) 논리적 설계
-- web_member			web_book
--	회원번호(PK)정수형		도서번호(PK) 정수형
--	이름(NN)문자열			책이름(NN) 문자열
--	나이 정수형				장르(CK) 문자열
--	핸드폰번호(UK)문자열		회원번호(FK) 정수형
--	주소 문자열

--4) 물리적 설계
-- web_member						web_book
--	member_id(PK) number			book_id(PK) number
--	member_name(NN)	varchar2(100)	book_name(NN) varchar2(100)
--	member_age number				book_genre(CK) varchar2(100)
--	member_phone(UK) varchar2(100)	member_id(FK) number
--	member_addr varchar2(100)

--5) 구현
CREATE TABLE web_member(
	member_id		NUMBER
  , member_name		varchar2(100) NOT null
  , member_age		varchar2(100)
  , member_phone	varchar2(100)
  , member_addr		varchar2(100)
  , CONSTRAINT member_id_pk PRIMARY key(member_id)
  , CONSTRAINT member_phone unique(member_phone)
);

SELECT * FROM web_member;

CREATE TABLE web_book(
	book_id		NUMBER
  ,	book_name	varchar2(100) NOT NULL
  ,	book_genre	varchar2(100) NOT NULL
							  CHECK (book_genre = 'inmun'
							  	  OR book_genre = 'it'
							  	  OR book_genre = 'chori'
							  	  OR book_genre = 'gyeon')
  ,	member_id	NUMBER
  , CONSTRAINT book_id_pk PRIMARY key(book_id)
  , CONSTRAINT member_id_fk FOREIGN KEY(member_id) REFERENCES web_member(member_id) 
);

SELECT * FROM web_book;

DROP TABLE WEB_BOOK;
DROP TABLE web_member;
--------------------------------------------------------------------------
--2. TBL_TEST_STUDENT 테이블을 생성하고 10명의 학
--생을 추가한 후 테이블을 조회하세요.

CREATE TABLE tbl_test_student(
	stu_id		NUMBER
  , stu_name	varchar2(100) NOT null
  , stu_phone	varchar2(100) NOT null
  , stu_age		NUMBER NOT null
  , stu_major	varchar2(100) NOT NULL
  , CONSTRAINT stu_id_pk PRIMARY KEY(stu_id)
);

INSERT INTO tbl_test_student
VALUES
--(1, '최현욱', '010-1234-5678', 20, '컴퓨터 공학과');
--(2, '고민시', '010-2345-6789', 22, '인공지능학과');
--(3, '신예은', '010-3456-7890', 21, '정보보호학과');
--(4, '이재욱', '010-4567-8901', 23, '컴퓨터 공학과');
--(5, '김소현', '010-5678-9012', 20, '인공지능학과');
--(6, '김지원', '010-6789-0123', 24, '정보보호학과');
--(7, '이도현', '010-7890-1234', 22, '컴퓨터 공학과');
--(8, '여진구', '010-8901-2345', 21, '인공지능학과');
--(9, '차은우', '010-9012-3456', 23, '정보보호학과');
--(10, '박은빈', '010-0123-4567', 20, '컴퓨터 공학과');

SELECT * FROM tbl_test_student;

-------------------------------------------------------------
--3. 2번에서 만든 테이블에서 아래 요구사항대로 쿼리문을
--작성하세요.
--1) 학과를 중복없이 조회하기(select절, from절만 이용해서 조회할 것)
SELECT DISTINCT stu_major
FROM	tbl_test_student;

--2) 학생수가 4명 이상인 학과 조회하기(반드시 IN LINE VIEW 서브쿼
--리 이용)


--3) 학번, 이름, 나이, 자신이 속한 학과의 최대나이를 조회하기(반드시
--SCALAR 서브쿼리 이용)


--4) 학생의 나이가 평균 나이보다 어린(미만인) 학생들만 조회하기(반드
--시 SUB QUERY 서브쿼리 이용)
SELECT	*
FROM	TBL_TEST_STUDENT tts 
WHERE 	stu_age < (SELECT	avg(stu_age) "평균나이"
		 		   FROM		TBL_TEST_STUDENT tts)
;

SELECT * FROM tbl_test_student;

---------------------------------------------------------------
--4. TBL_TEST_SCHOOL 테이블과 TBL_TEST_STU 테
--이블이 아래 엔티티 관계도처럼 관계가 맺어져있다. 
--테이블을 아래 엔티티 관계도를 보고 동일하게 생성 한 뒤 값
--을 추가하고 조회하세요.
--(단, 제약조건은 PK와 FK만 설정할 것)

CREATE TABLE tbl_test_school(
	school_number	NUMBER
  , school_name		varchar2(100)
  , CONSTRAINT school_number_pk PRIMARY KEY(school_number)
);

SELECT * FROM tbl_test_school;

CREATE TABLE tbl_test_stu(
	stu_number		NUMBER
  , stu_name		varchar2(100)
  , stu_age			NUMBER
  , school_number	NUMBER
  , CONSTRAINT stu_number_pk PRIMARY key(stu_number)
  , CONSTRAINT school_number_fk FOREIGN key(school_number) REFERENCES tbl_test_school(school_number)
);

INSERT INTO tbl_test_school
--VALUES(1, 'DNMS 고등학교');
--VALUES(2, 'JAVA 고등학교');
VALUES(3, 'PYTHON 고등학교');

SELECT * FROM tbl_test_school;

INSERT INTO tbl_test_stu
values
--(1,'김철수',17,1);
--(2,'신짱구',17,1);
--(3,'이유리',18,2);
(4,'김영희',19,2);

SELECT * FROM tbl_test_stu;

----------------------------------------------------------------------------------------------
--1) 각 학생의 이름과 그들이 소속된 학교 이름을 조회하기

SELECT 	tts2.stu_name
	  , tts1.school_name
FROM	tbl_test_school tts1
JOIN	tbl_test_stu tts2
ON		tts1.SCHOOL_NUMBER = tts2.SCHOOL_NUMBER 
;

--2) 학교 이름과 그 학교에 속한 학생 수를 조회하기(단, 반드시 left join
--이용할것)

SELECT 	school_name
	  , count(*) "학생 수"
FROM	TBL_TEST_SCHOOL tts1
LEFT JOIN TBL_TEST_STU tts2
ON		tts1.SCHOOL_NUMBER = tts2.SCHOOL_NUMBER 
GROUP BY SCHOOL_NAME;

--3) 학생의 나이가 평균 나이 이상인 학생의 이름과 그들이 소속된 학교
--이름을 조회하기
SELECT  tts1.stu_name
	  , tts2.school_name
FROM	TBL_TEST_STU tts1
JOIN	TBL_TEST_SCHOOL tts2 
ON		tts1.SCHOOL_NUMBER = tts2.SCHOOL_NUMBER 
WHERE 	stu_age >=(SELECT	avg(stu_age)
		 		   FROM	TBL_TEST_STU)
;

----------------------------------------------------------
--7. rownum을 이용하여 TBL_TEST_STUDENT 테이블에
--서 나이가 많은 순서 대로(나이 내림차순으로 정렬) 3~5번째
--학생들만 조회하세요.


SELECT	rownum "3번째에서 5번째"
	  , stu_age
	  , stu_name
FROM	(SELECT	rownum "순번"
	  		  , stu_age
	  		  , stu_name
		 FROM	(SELECT	stu_name
	  		  		  , stu_age
		 		 FROM 	tbl_test_student
		 		 ORDER BY stu_age DESC))
WHERE 	"순번" BETWEEN 3 AND 5
;