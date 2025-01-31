CREATE SEQUENCE seq_users;

CREATE TABLE TBL_USERS(
   user_number NUMBER,
   user_id varchar2(100) NOT null,
   user_pw varchar2(100) NOT NULL,
   user_name varchar2(100) NOT NULL,
   user_phone varchar2(100) NOT NULL UNIQUE,
   CONSTRAINT pk_users PRIMARY key(user_number)
);

INSERT INTO tbl_users
VALUES
--(1, 'QQQ', '1233', '길진수', '010-0000-0000');
(2, 'WWW', '2222', '진수길', '010-1234-5678');


CREATE SEQUENCE seq_book;

CREATE TABLE TBL_BOOK(
   book_number NUMBER,
   book_title varchar2(100) NOT null,
   book_author varchar2(100) NOT null,
   book_rent VARCHAR2(5) DEFAULT 'false' NOT NULL CHECK (book_rent = 'false' OR book_rent = 'true'),
   user_number NUMBER ,
   CONSTRAINT pk_book PRIMARY key(book_number),
   CONSTRAINT fk_user FOREIGN key(user_number) REFERENCES tbl_users(user_number)
   );
  
DROP TABLE tbl_book;
DROP TABLE tbl_users;

   
SELECT * FROM TBL_USERS;
SELECT * FROM TBL_BOOK;

INSERT INTO tbl_book
VALUES
--(1, 'aaa', 'AAA', 'true', 1);
--(2, 'bbb', 'BBB', 'false', null);
--(3, 'ccc', 'CCC', '', 2);
--(4, 'ddd', 'DDD', NULL, 2);
--(5, 'eee', 'EEE', '안녕', 1);
(6, 'aaa', 'AAA', 'false', null);

SELECT	book_number
	  , book_title
	  , book_author
	  , book_rent
FROM	tbl_book
WHERE 	book_title = 'aaa'
;