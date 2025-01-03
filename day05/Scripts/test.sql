-- 내부조인

-- 도서 테이블과 도서 가격 테이블
CREATE TABLE TBL_BOOKS1(
   BOOK_ID NUMBER,
   BOOK_TITLE VARCHAR2(1000),
   BOOK_AUTHOR VARCHAR2(100),
   CONSTRAINT BOOK_PK1 PRIMARY KEY(BOOK_ID)
);

CREATE TABLE tbl_bookprice1(
	bp_id		NUMBER
  , bp_price	NUMBER
  , CONSTRAINT bp_pk1 PRIMARY key(bp_id)
);

-- 값 추가
INSERT INTO tbl_books1
--values(1, '위대한 개츠비', 'F.스콧 피츠재럴드');
--values(2, '해리포터와 마법사의 돌', 'J.K. 롤링');
--values(3, '1984', '조지오웰');
--values(4, '오만과 편견', '제인 오스틴');
--values(5, '데미안', '헤르만헤세');
--VALUES(6, '모모', '미하엘 엔더');

INSERT INTO tbl_bookprice1
--values(1, 15000);
--VALUES(2, 18000);
--values(3, 14000);
--values(4, 17000);
--VALUES(5, 18000);
--values(6, 20000);
--values(7, 20000);

-- book_id와 bp_id가 동일한 제목 작가 가격 출력하기
SELECT	book_id
	  , book_title
	  , book_author
	  , bp_id
	  , bp_price
FROM	tbl_books1
JOIN	tbl_bookprice1
ON		book_id = bp_id
;

SELECT * FROM tbl_books1;
SELECT * FROM tbl_bookprice1;