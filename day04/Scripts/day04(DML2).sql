-- FK 관계 맺은 테이블 수정/삭제

CREATE TABLE tbl_phone(
	phone_number			varchar2(100)
  , phone_color				varchar2(100)
  , phone_size				NUMBER
  , phone_price				NUMBER
  , phone_sale				NUMBER
  , phone_production_date	DATE
  , CONSTRAINT phone_number_PK PRIMARY KEY(phone_number)
);

CREATE TABLE tbl_case(
	case_number 	varchar2(100)
  , csse_color		varchar2(100)
  , case_price		NUMBER
  , phone_number	varchar2(100)
  , CONSTRAINT case_number_PK PRIMARY KEY(case_number)
  , CONSTRAINT phone_number_FK FOREIGN KEY(phone_number) REFERENCES tbl_phone(phone_number)
);

SELECT 	*
FROM 	tbl_phone;

SELECT 	*
FROM 	tbl_case;

-- 관계를 맺은 테이블들의 DML
-- 자식 테이블은 부모 테이블의 값을 참조하기 때문에 항상 부모 테이블에 DATA가 먼저 들어가야 한다
-- PHONE 테이블이 부모이므로 PHONE에 먼저 데이터를 넣어야 한다
INSERT INTO tbl_phone
VALUES('a1', 'white', 1, 100, 0, '2024-12-01')
-- date 타입의 컬럼에 문자타입의 값을 'yyyy-mm-dd' 형태로 넣으면 자동으로 DATE 타입으로 변환되어 들어간다

INSERT INTO tbl_phone
--VALUES('a2', 'black', 1, 120, 10, sysdate - 10);
-- 현제 날짜를 기준으로 10일 전 현재시간까지 포함해서 들어간다
VALUES('a3', 'blace', 1, 130, 20, TO_date('2024-05-05'))
-- to_date() 함수를 이용하여 문자열을 직접 date 타입으로 바꿀 수 있다

INSERT INTO tbl_case
--VALUES('A', 'WHITE', 5, 'A1');  -- phone 테이블에는 A1이라는 값이 없기 때문에(데이터 값은 대소문자 구분) 오류 발생
--VALUES('A', 'WHITE', 5, 'a1');
values('B', 'BLACE', 2, 'a2');

-- 부모 테이블의 값을 수정하기
UPDATE	tbl_phone
SET		phone_color = 'blue'
WHERE 	phone_number = 'a1';

-- 부모 테이블의 PK값 수정
-- 자식 테이블에서 참조하고 있는 값이 아니면 수정 가능하지만 참조하고 있는 값인 경우 수정이 불가능하다(오류발생)
UPDATE 	tbl_phone
SET		phone_number = 'a03'
WHERE 	phone_number = 'a3';

-- 부모의 값을 변경할 때 자식에서 참조중이 값을 변경하려고 하면 오류가 발생하므로
-- 자식 테이블을 먼저 수정하여 해당 값을 참조하지 않도록 수정해야한다
-- 1) 자식 테이블에서 참조중인 값을 다른 값으로 변경한다
UPDATE 	tbl_case
SET 	phone_number = 'a03'
WHERE 	CASE_NUMBER  = 'A';

UPDATE	tbl_phone
SET		phone_number = 'a01'
WHERE 	phone_number = 'a1';

UPDATE	tbl_case
SET 	phone_number = 'a01'
WHERE 	case_number = 'A';

SELECT 	*
FROM 	tbl_phone;
SELECT 	*
FROM 	tbl_case;

-- 2) 자식 테이블에서 참조중인 값을 NULL로 변경한다(정말 급한게 아니라면 비추천)
UPDATE	tbl_case
SET		phone_number = NULL
WHERE 	case_number = 'B';

UPDATE	tbl_phone
SET 	phone_number = 'a02'
WHERE 	phone_number = 'a2';

UPDATE	tbl_case
SET 	phone_number = 'a02'
WHERE 	CASE_number = 'B';

SELECT 	*
FROM 	tbl_phone;
SELECT 	*
FROM 	tbl_case;

-- 부모 테이블에서 데이터 삭제하기
-- 자식 테이블에서 참조중인 값들을 먼저 처리해야 한다
DELETE	FROM	tbl_phone
WHERE 	phone_number = 'a02';  -- 자식 테이블에서 참조중인 값이라 삭제 불가능

-- 1) 자식 테이블의 값을 먼저 삭제 후 부모 테이블의 값을 삭제한다(참조중인 행 자체를 삭제)
DELETE 	FROM tbl_case
WHERE 	phone_number = 'a02'

DELETE 	FROM tbl_phone
WHERE 	phone_number = 'a02';

-- 2) 자식 테이블에서 참조중인 값을 수정 후 부모 테이블의 값을 삭제한다
UPDATE 	tbl_case
SET 	phone_number = NULL
WHERE 	CASE_number = 'A';

DELETE 	FROM tbl_phone
WHERE 	phone_number = 'a01';

-- drop table tbl_phone cascade constraint : 자식이 참조중이어도 강제로 테이블 날리기 가능

SELECT 	*
FROM 	tbl_phone;
SELECT 	*
FROM 	tbl_case;