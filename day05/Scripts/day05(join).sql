-- 내부조인

-- 도서 테이블과 도서 가격 테이블
--CREATE 	TABLE tbl_books()
--	book_id		NUMBER
--  ,	book_title	varchar2(1000)
--  , book_author	varchar2(100)
--  , CONSTRAINT book_pk PRIMARY KEY(book_id)
--;

CREATE TABLE TBL_BOOKS(
   BOOK_ID NUMBER,
   BOOK_TITLE VARCHAR2(1000),
   BOOK_AUTHOR VARCHAR2(100),
   CONSTRAINT BOOK_PK PRIMARY KEY(BOOK_ID)
);

CREATE TABLE tbl_bookprice(
	bp_id		NUMBER
  , bp_price	NUMBER
  , CONSTRAINT bp_pk PRIMARY key(bp_id)
);

DROP TABLE tbl_bookprice;
-- 값 추가
INSERT INTO tbl_books
--values(1, '위대한 개츠비', 'F.스콧 피츠재럴드');
--values(2, '해리포터와 마법사의 돌', 'J.K. 롤링');
--values(3, '1984', '조지오웰');
--values(4, '오만과 편견', '제인 오스틴');
--values(5, '데미안', '헤르만헤세');
--VALUES(6, '모모', '미하엘 엔더');

INSERT INTO tbl_bookprice
--values(1, 15000);
--VALUES(2, 18000);
--values(3, 14000);
--values(4, 17000);
--VALUES(5, 18000);
--values(6, 20000);
--values(7, 20000);

-- 2개의 테이블 내부조인
SELECT 	A.book_id
	  , A.book_title
	  , A.book_author
	  , B.bp_id
	  , B.bp_price
FROM	tbl_books A INNER JOIN tbl_bookprice B
ON		A.book_id = B.bp_id;

DROP TABLE tbl_books;
DROP TABLE tbl_bookprice;

-- 도서관
-- 도서 테이블, 회원 테이블, 렌탈 테이블
CREATE 	TABLE tbl_books(
	book_id		NUMBER
  ,	book_title	varchar2(1000)
  , book_author	varchar2(100)
  , CONSTRAINT book_pk PRIMARY KEY(book_id)
);

SELECT 	*
FROM 	tbl_books
;

CREATE TABLE tbl_member(
	mem_id		NUMBER
  , mem_name	varchar2(100)
  , mem_phone	varchar2(100)
  , mem_email	varchar2(100)
  , CONSTRAINT member_pk PRIMARY key(mem_id)
);

SELECT 	*
FROM 	tbl_member
;

CREATE TABLE tbl_rental(
	ren_id	NUMBER
  , mem_id	NUMBER
  , book_id	NUMBER
  , ren_rentaldate	DATE
  , ren_returndate	DATE
  , CONSTRAINT pk_rental PRIMARY key(ren_id)
  , CONSTRAINT fk_rental FOREIGN KEY(mem_id) REFERENCES tbl_member(mem_id)
  , CONSTRAINT fk_rental_book FOREIGN key(book_id) REFERENCES tbl_books(book_id)
);

SELECT 	*
FROM 	tbl_rental
;

INSERT INTO tbl_books
--values(1, '위대한 개츠비', 'F.스콧 피츠재럴드');
--values(2, '해리포터와 마법사의 돌', 'J.K. 롤링');
--values(3, '1984', '조지오웰');
--values(4, '오만과 편견', '제인 오스틴');
--values(5, '데미안', '헤르만헤세');

INSERT INTO TBL_MEMBER
--VALUES(1, '짱구', '123-456-7890', 'aaa@koreait.com');
--values(2, '유리', '987-654-3210', 'bbb@koreait.com');
--values(3, '철수', '555-123-4567', 'ccc@koreait.com');
--values(4, '훈이', '777-888-9999', 'ddd@koreait.com');
--values(5, '맹구', '555-777-3333', 'eee@koreait.com');

INSERT INTO TBL_RENTAL
--VALUES(1, 1, 3, TO_DATE('2023-12-11', 'YYYY-MM-DD'), TO_DATE('2023-12-18', 'YYYY-MM-DD'));
--VALUES(2, 2, 1, TO_DATE('2023-12-11', 'YYYY-MM-DD'), TO_DATE('2023-12-18', 'YYYY-MM-DD'));
--VALUES(3, 3, 2, TO_DATE('2023-12-13', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'));
--VALUES(4, 4, 4, TO_DATE('2023-12-20', 'YYYY-MM-DD'), TO_DATE('2023-12-27', 'YYYY-MM-DD'));
--VALUES(5, 5, 5, TO_DATE('2023-12-22', 'YYYY-MM-DD'), TO_DATE('2023-12-29', 'YYYY-MM-DD'));

-- 등가조인 : 두 개 이상의 테이블을 조인한 뒤, 특정 컬럼의 값이 서로 같은 행만 결과로 반환

-- 대여 정보와 책의 저자를 가져오는 등가조인
-- 1) 행의 개수를 먼저 파악하여 선행 테이블, 후행 테이블 설정
SELECT 	count(*)
FROM	TBL_BOOKS
;

SELECT 	count(*)
FROM	tbl_rental
;

-- 2) JOIN 사용하여 두 개의 테이블 조회
SELECT	TR.ren_rentaldate
	  , TR.REN_RETURNDATE 
	  , TB.book_author
	  , tr.BOOK_ID
	  , tb.book_id
FROM	tbl_rental TR INNER JOIN tbl_books TB
ON		TR.book_id = TB.book_id
;

-- 대여한 책 이름과 반납 날짜 가져오기
SELECT 	TB.book_title
	  , TR.ren_returndate
FROM	tbl_books tb JOIN tbl_rental tr
ON		tb.book_id = tr.book_id
;

-- 책 번호가 같은 컬럼 전부 조회
SELECT 	*
FROM	tbl_books tb JOIN tbl_rental tr
ON		tb.book_id = tr.book_id
;

-- 회원의 이름과 대여한 책의 제목을 가져오는 등가조인
SELECT 	tb.book_title
	  , tm.mem_name
FROM	tbl_books tb INNER JOIN tbl_member tm
ON		tb.book_id = tm.mem_id
;

SELECT 	tb.book_title
	  , tb.book_id
	  , tm.mem_name
	  , tm.mem_id
FROM	TBL_RENTAL tr
JOIN	tbl_member tm ON tr.mem_id = tm.mem_id
JOIN 	tbl_books tb ON tr.book_id = tr.book_id
;

-- 비등가조인 : 두 테이블 간의 조건이 같음이 아닌 병위 조건 등을 사용하는 방식

-- 책 대여일-반납일 사이에 특정 날짜가 포함되어 있는지 확인
SELECT 	tm.mem_name
	  , tb.book_title
	  , tr.ren_rentaldate
	  , tr.ren_returndate
FROM	tbl_rental tr
JOIN	tbl_books tb ON tr.book_id = tb.book_id
JOIN	tbl_member tm ON tr.mem_id = tm.mem_id
WHERE 	to_date('2023-12-25', 'yyyy-mm-dd') 
		BETWEEN tr.ren_rentaldate AND tr.ren_returndate
;

-- 대여기간에 따라 책의 대여 상태
-- 7일 이하 단기대여, 7일 이상 장기대여
SELECT 	tb.book_title
	  , tm.mem_name
	  , tr.ren_rentaldate
	  , tr.ren_returndate
--	  , CASE
--	  		WHEN ren_returndate - ren_rentaldate <= 7 THEN '단기대여'
--	  		ELSE '장기대여'
--	    END	AS rental_type
	  , CASE
	    	WHEN tr.ren_returndate < sysdate THEN '반납완료'
	    	ELSE '대여중'
	    END rental_type
FROM	tbl_rental tr
JOIN	tbl_books tb ON tr.book_id = tb.BOOK_ID
JOIN 	tbl_member tm ON tr.mem_id = tm.mem_id
;

-- SQL 실행 순서
-- FROM -> ON -> JOIN > WHERE -> GROU BY -> HAVING -> SELECT -> ORDER BY
-- FROM : 테이블이나 뷰의 데이터 가져오기
-- ON : JOIN절의 조건 평가
-- JOIN : 지정된 조건에 따라 두 개 이상의 테이블을 조인
-- WHERE : 조인 결과에서 조건에 맞는 행을 필터링
-- GROUP BY : 데이터 그룹화(집계함수로 주로 사용)
-- HAVING : GROUP BY로 그룹화된 데이터에 대해 조건 적용
-- SELECT : 조회할 컬럼을 선택(집계함수, 별칭)
-- ORDER BY : 최종 결과를 정렬(ASC, DESC)

-- 외부조인
CREATE TABLE tbl_bookprice(
	bp_id		NUMBER
  , bp_price	NUMBER
  , CONSTRAINT bp_pk PRIMARY key(bp_id)
);

INSERT INTO TBL_BOOKPRiCE
--VALUES(1, 15000);
--VALUES(2, 18000);
--VALUES(3, 14000);
--VALUES(4, 17000);

-- 1) 왼쪽 외부조인(LEFT OUTER JOIN)
-- BOOKS 테이블 기준 왼쪽 외부조인을 수행하고 BOOKPRICE 테이블의 데이터를 포함(왼쪽 테이블의 데이터가 없더도 결과에 포함)
SELECT	tb.book_id
	  , tb.book_title
	  , tb.book_author
	  , tp.bp_id
	  , tp.bp_price
FROM	tbl_books tb
LEFT 	JOIN tbl_bookprice tp
ON		tb.book_id = tp.bp_id;

-- 2) 오른쪽 외부조인(rignt outer join)
-- bookpirce 기준으로 오른쪽 외부조인을 수행하고  books 테이블의 데이터를 포함
SELECT	tb.book_id
	  , tb.book_title
	  , tb.book_author
	  , tp.bp_id
	  , tp.bp_price
FROM	tbl_books tb
right 	JOIN tbl_bookprice tp
ON		tb.book_id = tp.bp_id;

INSERT INTO tbl_books
VALUES(10, 'DBMS', 'DB');

INSERT INTO tbl_bookprice
--VALUES(5, 20000);
--values(6, 16000);
values(7, 20000);

SELECT 	tb.book_id
	  , tb.book_title
	  , tb.book_author
	  , tp.bp_id
	  , tp.bp_price
FROM	tbl_books tb
FULL	JOIN tbl_bookprice tp
ON		tb.book_id = tp.bp_id
;

SELECT * FROM tbl_books;
SELECT * FROM tbl_member;
SELECT * FROM tbl_rental;
SELECT * FROM tbl_bookprice;