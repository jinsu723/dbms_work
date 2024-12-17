-- 테이블 생성(DDL)
CREATE TABLE TBL_MEMBER(
	MEMBER_ID NUMBER,
	MEMBER_NAME VARCHAR2(100),
	MEMBER_AGE NUMBER(3)
);

SELECT 	*
FROM 	TBL_MEMBER;

-- 데이터 추가 insert into
INSERT INTO TBL_MEMBER
values(1, '길진수', 27);

INSERT INTO tbl_member
values(2, '신짱구', 5);

INSERT INTO TBL_MEMBER
values(3, '신짱아', 3);

insert INTO TBL_MEMBER(member_id, member_name)
values(4, '유리');

INSERT INTO tbl_member(member_age)
values(5);

-- 데이터 수정 update
UPDATE	tbl_member
SET		member_age = 5;

UPDATE 	TBL_MEMBER
SET 	member_age = 20
WHERE	member_name = '길진수';

UPDATE 	tbl_member
SET 	member_age = 2
WHERE 	member_id = 3;

-- 삭제 : delete
DELETE FROM tbl_member
WHERE member_age = 5;

DELETE FROM tbl_member;

-- 학생 테이블 생성
--CREATE TABLE 테이블명(
--	컬럼명 데이터타입-문자(VARCHAR2, CHAR), 숫자(NUMBER), 날짜(DATE)
--);

CREATE TABLE TBL_STUDENT(
	STUDENT_NUMBER NUMBER,
	STUDENT_NAME VARCHAR2(1000),
	STUDENT_MATH NUMBER,
	STUDENT_ENG NUMBER,
	STUDENT_KOR NUMBER,
	STUDENT_GRADE VARCHAR2(100)
);

-- 테이블 삭제 : DROP TABLE 테이블명
--DROP TABLE TBL_STUDENT;

SELECT 	*
FROM 	tbl_student;

/* 학생 테이블에 데이터 추가
 * 학생번호 이름 수학 영어 국어
 * 1	 김철수 90 90  90
 * 2	 홍길동 70 25  55
 * 3     이유리 89 91  77
 * 4     김웅이 48 100 100
 * 5     신짱구 50 10  NULL
 */

INSERT INTO TBL_STUDENT(
				student_number
			  , student_name
			  , student_math
			  , student_eng
			  , student_kor
			  )
values(1, '김철수', 90, 90, 90);

INSERT INTO TBL_STUDENT(
				student_number
			  , student_name
			  , student_math
			  , student_eng
			  , student_kor
			  )
values(2, '홍길동', 70, 25, 55);

INSERT INTO TBL_STUDENT(
				student_number
			  , student_name
			  , student_math
			  , student_eng
			  , student_kor
			  )
values(3, '이유리', 89, 91, 77);

INSERT INTO TBL_STUDENT(
				student_number
			  , student_name
			  , student_math
			  , student_eng
			  , student_kor
			  )
values(4, '김웅이', 48, 100, 90);

INSERT INTO TBL_STUDENT(
				student_number
			  , student_name
			  , student_math
			  , student_eng
			  )
values(5, '신짱구', 50, 10);

SELECT 	*
FROM 	tbl_student;

-- 전체 학생의 이름과 평균점수 조회하기(별칭도 추가)
SELECT 	student_name	이름
	  , (student_math + student_eng + student_kor) / 3	"평균 점수"
FROM	tbl_student;

-- NVL(컬럼명, 기본값) : NULL값을 특정 값으로 변경
-- NVL은 기존 타입의 값이 있기 때문에 타입을 변경하게 되면 하나의 컬럼에 타입이 2개가 되므로 오류가 발생한다
SELECT	student_name	이름
	  , NVL(student_kor, 0)	국어점수
	  , NVL(student_grade, '미정')	학점
FROM	tbl_student;

-- NVL2(컬러명, 값1, 값2) : NULL 여부에 따라 NULL이 아니면 값1, NULL이면 값2
-- 하나의 컬럼에는 하나의 타입의 값만 들어갈 수 있다. 따라서 NULL인 값과 NULL이 아닌 값이 모두 문자이므로 가능하다
-- 값2에는 숫자가 들어갈 수 있다 숫자를 문자열로 출력하면 되기 때문에
-- 값1에 숫자, 값2에 문자는 안된다
-- 숫자가 문자를 담을 수 없기 때문에
SELECT 	student_name	이름
	  , NVL2(student_kor, '점수있음', '점수없음')	국어점수
FROM	tbl_student;

-- NULLIF(컬럼명, 값1) : 특정값과 같으면 NULL로 변경
SELECT 	student_name	이름
	  , nullif(student_kor, 100)
FROM	tbl_student;

-- NULLIF(컬럼1, 컬럼2) : 두 컬럼의 값이 같으면 NULL로 변경, 값이 다르면 기존 값 출력
SELECT 	student_name	이름
	  , NULLIF(student_math, student_eng)
FROM	tbl_student;

-- COALESCE(값1, 값2, 값3) : NULL이 아닌 첫 번째 값을 반환 오른쪽에서 왼쪽으로 센다
SELECT 	student_name	이름
	  , coalesce(
	  		student_kor
	  	  , student_eng
	  	  , student_math
	  	  , 0
	  	) "첫 번째 점수"
FROM	tbl_student;

-- 수정 UPDATE
UPDATE  tbl_student
SET 	STUDENT_KOR = 0
WHERE 	student_kor IS NULL

UPDATE	tbl_student
SET 	student_kor = NVL(student_kor, 0);

-- 전체 학생의 이름과 평균점수 조회하기(별칭도 추가)
SELECT 	student_name	이름
	  , (student_math + student_eng + student_kor) / 3	"평균 점수"
FROM	tbl_student;

-- 학생의 평균점수를 구하고 학점 수정하기
-- A : 90점이상
-- B : 80점 이상 90점 미만
-- C : 50점 이상 80점 미만
-- F : 50점 미만

-- ROUND(값, 자리수) : ROUND 함수는 소수점을 반올림하여 특정 소수점 까지만 표현할 수 있다
-- ROUND(평균점수 구하는 공식 >= 90)
UPDATE 	tbl_student
SET 	student_grade = 'A'
WHERE 	round((student_math + student_eng + student_kor) / 3, 2) >= 90;

UPDATE 	tbl_student
SET 	student_grade = 'B'
WHERE 	round((student_math + student_eng + student_kor) / 3, 2) < 90 
AND 	round((student_math + student_eng + student_kor) / 3, 2) >= 80;

UPDATE 	tbl_student
SET 	student_grade = 'C'
WHERE 	round((student_math + student_eng + student_kor) / 3, 2) < 80
AND		round((student_math + student_eng + student_kor) / 3, 2) >= 50;

UPDATE 	tbl_student
SET 	student_grade = 'F'
WHERE 	round((student_math + student_eng + student_kor) / 3, 2) < 50;

-- Q1. 학생의 수학, 영어, 국어 점수 중 한 과목이라도 50점 미만이 아니고
-- 학점이 B이상인 학생만 학생번호, 이름, 학점으로 별칭 붙여서 출력하기
SELECT 	student_number	번호
	  , student_name	이름
	  , student_grade	학점
FROM	tbl_student
WHERE 	(not(student_math < 50 OR student_eng < 50 OR student_kor < 50))
AND		student_grade >= 'B'

-- Q2. 학생의 수학, 영어, 국어 점수 중 한 과목이라도 30점 미만이면 테이블에서 삭제하기
DELETE FROM tbl_student
WHERE student_math < 30 OR student_eng < 30 OR student_kor < 30;

SELECT 	*
FROM 	tbl_student;