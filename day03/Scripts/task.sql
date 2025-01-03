CREATE TABLE TBL_STUDENT1(
	STUDENT_NUMBER	NUMBER
  , STUDENT_NAME	VARCHAR2(1000)		CONSTRAINT STUDENT_NAME_NN NOT NULL
  , STUDENT_AGE		NUMBER			CONSTRAINT STUDENT_AGE_NN NOT NULL
  , STUDENT_PHONE	VARCHAR2(1000)	CONSTRAINT STUDENT_PHONE_NN NOT NULL
  , STUDNET_ADDRESS	VARCHAR2(1000)	CONSTRAINT STUDENT_ADDRESS_NN NOT NULL
  , CONSTRAINT STUDENT_NUMBER_PK PRIMARY KEY(STUDENT_NUMBER)
  , CONSTRAINT STUDENT_PHONE_UK  UNIQUE(STUDENT_PHONE)
);

SELECT 	*
FROM	tbl_student1;

INSERT INTO tbl_student1
--VALUES(1, '길진수', 27, '010-1111-1111', '경기도');
--values(2, '길길길', 90, '010-2222-2222', '서울');
--VALUES(3, '진진진', 10, '010-3333-3333', '화성');
--VALUES(4, '수수수', 25, '010-4444-4444', '미국');
VALUES(5, '세뮤얼', 1, '010-5555-5555', '베트남');

CREATE TABLE TBL_MAJOR(
	MAJOR_MNUMBER	VARCHAR2(1000)
  , MAJOR_NAME		VARCHAR2(1000)	CONSTRAINT MAJOR_NAME_NN NOT NULL
  , MAJOR_THECHER	VARCHAR2(1000)		CONSTRAINT MAJOR_TEACHER_NN NOT NULL
  , MAJOR_START		DATE			CONSTRAINT MAJOR_START_NN NOT NULL
  , MAJOR_TIME		VARCHAR2(1000)	CONSTRAINT MAJOR_TIME_NN NOT NULL CHECK(MAJOR_TIME = '오전 9시'
  																		 OR MAJOR_TIME = '오후 19시')
  , CONSTRAINT MAJOR_MNUMBER_PK PRIMARY KEY(MAJOR_MNUMBER)
);

SELECT 	*
FROM	tbl_major;

INSERT INTO tbl_major
--VALUES(1, 'java', '참새', '2024-11-21', '오전 9시');
--VALUES(2, 'dbms', '정규쌤', '2024-11-21', '오전 9시');
--VALUES(3, 'web', '신짱구', '2023-11-21', '오후 19시');
--VALUES(4, 'java', '신짱구', '2023-11-30', '오후 19시');
VALUES(5, 'web', '참새', '2030-4-30', '오전 9시');

CREATE TABLE TBL_SCORE(
	SCORE_SNUMBER	VARCHAR2(1000)
  , STUDENT_NUMBER	NUMBER
  , MAJOR_MNUMBER	VARCHAR2(1000)
  , SCORE_GRADE		CHAR(1)	CONSTRAINT SCORE_GRADE_NN NOT NULL
  							CONSTRAINT SCORE_GRADE_CK CHECK(SCORE_GRADE = 'A'
  														 OR SCORE_GRADE = 'B'
  														 OR SCORE_GRADE = 'C'
  														 OR SCORE_GRADE = 'F')
  , CONSTRAINT STUDENT_NUMBER_FK FOREIGN KEY(STUDENT_NUMBER) REFERENCES TBL_STUDENT1
  , CONSTRAINT MAJOR_NUMBER_FK FOREIGN KEY(MAJOR_MNUMBER) REFERENCES TBL_MAJOR
  , CONSTRAINT SCORE_PK PRIMARY KEY(SCORE_SNUMBER, STUDENT_NUMBER, MAJOR_MNUMBER)
);

SELECT	*
FROM 	tbl_score;

INSERT INTO tbl_score
--VALUES(1, 1, 1, 'A');
--VALUES(2, 2, 4, 'B');
--VALUES(3, 3, 3, 'F');
--VALUES(4, 4, 2, 'C');
VALUES(5, 5, 2, 'B');

DROP table tbl_student1;
DROP TABLE tbl_major;
DROP TABLE tbl_score;




--------------------------------------------------------------------------------------------------------
--	TBL_PERSON
--	======================================
--	PERSON_NUMBER(PK)	NUMBER
--	PERSON_NAME(NN)		VARCHAR2(1000)
--	PERSON_ADDRESS(NN)	VARCHAR2(1000)
--	PERSON_PHONE(UK/NN)	VARCHAR2(1000)
--	PERSON_EMAIL		VARCHAR2(1000)
CREATE TABLE TBL_PERSON(
	PERSON_NUMBER	NUMBER
  , PERSON_NAME		VARCHAR2(1000) CONSTRAINT PERSON_NAME_NN NOT NULL
  , PERSON_ADDRESS	VARCHAR2(1000) CONSTRAINT PERSON_ADDRESS_NN NOT NULL
  , PERSON_PHONE	VARCHAR2(1000) CONSTRAINT PERSON_PHONE_NN NOT NULL
  , PERSON_EMAIL	VARCHAR2(1000)
  , CONSTRAINT PERSON_NUMBER_PK PRIMARY KEY(PERSON_NUMBER)
  , CONSTRAINT PERSON_PHONE_UL UNIQUE(PERSON_PHONE)
);

INSERT INTO tbl_person
--VALUES(1, '길진수', '시흥시', '010-1111-1111', null);
--VALUES(2, '진수길', '목성', '010-2222-2222', null);
--VALUES(3, '수길진', '코리아', '010-3333-3333', null);
--VALUES(4, '야호', '서울', '010-4444-4444', null);
VALUES(5, '치킨', '강원도', '010-5555-5555', null);

--	TBL_PET
--	======================================
--	PET_NUMBER(PK)		NUMBER
--	PET_NAME(NN)		VARCHAR2(1000)
--	PET_GENDER(CK/NN)	CHAR(1)
--	TYPE_KIND(FK/NN)	NUMBER
--	PERSON_NUMBER(FK/NN)	VARCHAR2(1000)
CREATE TABLE TBL_PET(
	PET_NUMBER	NUMBER
  , PER_NAME	VARCHAR2(1000) CONSTRAINT PET_NAME_NN NOT NULL
  , PET_GENDER	CHAR(1)	CONSTRAINT PET_GENDER NOT NULL
  											  CHECK(PET_GENDER = 'M'
  											  	 OR PET_GENDER = 'W')
  , TYPE_KIND	NUMBER	CONSTRAINT TYPE_KIND_NN NOT NULL
  , PERSON_NUMBER NUMBER CONSTRAINT PERSON_NUMBER NOT NULL
  , CONSTRAINT PET_NUMBER_PK PRIMARY KEY(PET_NUMBER)
  , CONSTRAINT TYPE_KIND_FK FOREIGN KEY(TYPE_KIND) REFERENCES TBL_TYPE(TYPE_KIND)
  , CONSTRAINT PERSON_NUMBER_FK FOREIGN KEY(PERSON_NUMBER) REFERENCES TBL_PERSON(PERSON_NUMBER)
);

INSERT INTO tbl_pet
VALUES(1, '아토', 'W', 1, 1);
--	TBL_TYPE
--	======================================
--	TYPE_TYPE(NN)		VARCHAR2(1000)
--	TYPE_KIND(PK)		NUMBER
	
CREATE TABLE TBL_TYPE(
	TYPE_TYPE	VARCHAR2(1000)	CONSTRAINT TYPE_TYPE NOT NULL
  , TYPE_KIND	NUMBER
  , CONSTRAINT TYPE_KIND_PK PRIMARY KEY(TYPE_KIND)
);

DROP TABLE TBL_PERSON;
DROP TABLE TBL_PET;

-- ====================================================================================================================
--3. 아래와 같은 테이블이 있을 때 3차 정규화까지 각 단계별로 테이블을 만들고 값을 삽입 후 조회 쿼리문 결과를 확인하세요.
--
--- 기본 테이블명은 아래와 같고 테이블 추가하면서 값 넣을 땐 테이블명 달라져도 됨


-- 직원 테이블 생성 (1차 정규화를 적용하지 않은 형태로 유지)
CREATE TABLE Employees1 (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    BirthDate DATE,
    DepartmentInfo VARCHAR2(255),
    Salary NUMBER
);

-- 데이터 삽입
INSERT INTO Employees1 (EmployeeID, Name, BirthDate, DepartmentInfo, Salary)
VALUES (1, '스티븐', TO_DATE('2010-12-31', 'YYYY-MM-DD'), '영업부, 서울시.. 01234', 300);

INSERT INTO Employees1 (EmployeeID, Name, BirthDate, DepartmentInfo, Salary)
VALUES (2, '마리', TO_DATE('2011-10-01', 'YYYY-MM-DD'), '영업부, 서울시.. 01234', 250);

INSERT INTO Employees1 (EmployeeID, Name, BirthDate, DepartmentInfo, Salary)
VALUES (3, '찰스', TO_DATE('2003-05-01', 'YYYY-MM-DD'), '사업부, 경기도...02345', 200);

INSERT INTO Employees1 (EmployeeID, Name, BirthDate, DepartmentInfo, Salary)
VALUES (4, '마리아', TO_DATE('1995-08-15', 'YYYY-MM-DD'), '인사부, 서울시.. 01234', 280);

INSERT INTO Employees1 (EmployeeID, Name, BirthDate, DepartmentInfo, Salary)
VALUES (5, '제임스', TO_DATE('1988-03-22', 'YYYY-MM-DD'), '영업부, 서울시.. 01234', 320);

INSERT INTO Employees1 (EmployeeID, Name, BirthDate, DepartmentInfo, Salary)
VALUES (6, '안나', TO_DATE('2000-12-10', 'YYYY-MM-DD'), '영업부, 서울시.. 01234', 270);

SELECT 	*
FROM 	employees1;

--직원번호	이름		생일						부서번호	부서	주소			우편번호	급여
--===========================================================================
--1		스티븐	2010-12-31 00:00:00.000	1		영업부 서울시.. 	01234	300
--2		마리		2011-10-01 00:00:00.000	2		영업부 서울시.. 	01234	250
--3		찰스		2003-05-01 00:00:00.000	3		사업부 경기도..		02345	200
--4		마리아	1995-08-15 00:00:00.000	4		인사부 서울시.. 	01234	280
--5		제임스	1988-03-22 00:00:00.000	5		영업부 서울시.. 	01234	320
--6		안나		2000-12-10 00:00:00.000	6		영업부 서울시.. 	01234	270

CREATE table EMPLOYEES2(
    EmployeeID			NUMBER PRIMARY KEY
  , Name				VARCHAR2(50)
  , BirthDate			DATE
  , DepartmentNumber	NUMBER
  , DepartmentName		VARCHAR2(255)
  , Address				VARCHAR2(1000)
  , AddressNumber		NUMBER
  , Salary				NUMBER
);

-- 데이터 삽입
INSERT INTO Employees2
VALUES (1, '스티븐', TO_DATE('2010-12-31', 'YYYY-MM-DD'), 1, '영업부', '서울시..', 01234, 300);

INSERT INTO Employees2
VALUES (2, '마리', TO_DATE('2011-10-01', 'YYYY-MM-DD'), 2, '영업부', '서울시..', 01234, 250);

INSERT INTO Employees2
VALUES (3, '찰스', TO_DATE('2003-05-01', 'YYYY-MM-DD'), 3, '사업부', '경기도...', 02345, 200);

INSERT INTO Employees2
VALUES (4, '마리아', TO_DATE('1995-08-15', 'YYYY-MM-DD'), 4, '인사부', '서울시..',  01234, 280);

INSERT INTO Employees2
VALUES (5, '제임스', TO_DATE('1988-03-22', 'YYYY-MM-DD'), 5, '영업부', '서울시..',  01234, 320);

INSERT INTO Employees2
VALUES (6, '안나', TO_DATE('2000-12-10', 'YYYY-MM-DD'), 6, '영업부', '서울시..',  01234, 270);

SELECT 	*
FROM 	employees2;


--2차 정규화_부서테이블
--부서번호(PK)	부서	 주소			우편번호
--================================
--1			영업부 서울시.. 	01234
--2			사업부 경기도..		02345
--3			인사부 서울시.. 	01234
CREATE TABLE departments1(
    DepartmentNumber	NUMBER	PRIMARY KEY
  , DepartmentName		VARCHAR2(255)
  , Address				VARCHAR2(1000)
  , AddressNumber		NUMBER
);

SELECT 	*
FROM 	departments1;

-- 데이터 삽입
INSERT INTO departments1
VALUES (1, '영업부', '서울시..', 01234);

INSERT INTO departments1
VALUES (2, '사업부', '경기도...', 02345);

INSERT INTO departments1
VALUES (3, '인사부', '서울시..',  01234);


--2차 정규화_직원테이블
--직원번호(PK)	이름		생일						부서번호(FK)	급여
--===================================================================
--1			스티븐	2010-12-31 00:00:00.000	1			300
--2			마리		2011-10-01 00:00:00.000	1			250
--3			찰스		2003-05-01 00:00:00.000	2			200
--4			마리아	1995-08-15 00:00:00.000	3			280
--5			제임스	1988-03-22 00:00:00.000	1			320
--6			안나		2000-12-10 00:00:00.000	1			270


CREATE TABLE employees3(
    EmployeeID			NUMBER PRIMARY KEY
  , Name				VARCHAR2(50)
  , BirthDate			DATE
  , DepartmentNumber	NUMBER
  , Salary				NUMBER
  , CONSTRAINT DepartmentNumber_FK FOREIGN KEY(DepartmentNumber) REFERENCES departments1(DepartmentNumber)
);

SELECT 	*
FROM 	employees3;

-- 데이터 삽입

INSERT INTO Employees3
VALUES (1, '스티븐', TO_DATE('2010-12-31', 'YYYY-MM-DD'),1, 300);

INSERT INTO Employees3
VALUES (2, '마리', TO_DATE('2011-10-01', 'YYYY-MM-DD'), 1, 250);

INSERT INTO Employees3
VALUES (3, '찰스', TO_DATE('2003-05-01', 'YYYY-MM-DD'), 2, 200);

INSERT INTO Employees3
VALUES (4, '마리아', TO_DATE('1995-08-15', 'YYYY-MM-DD'), 3, 280);

INSERT INTO Employees3
VALUES (5, '제임스', TO_DATE('1988-03-22', 'YYYY-MM-DD'), 1, 320);

INSERT INTO Employees3
VALUES (6, '안나', TO_DATE('2000-12-10', 'YYYY-MM-DD'), 1, 270);


--3차 정규화_부서주소테이블
--부서번호(PK)	주소		우편번호
--======================================
--1			서울시.. 	01234
--2			경기도..	02345
CREATE TABLE Address(
    AddressPK			NUMBER	PRIMARY KEY
  , Address				VARCHAR2(1000)
  , AddressNumber		NUMBER
);

SELECT 	*
FROM 	Address;

-- 데이터 삽입
INSERT INTO Address
VALUES (1, '서울시..', 01234);

INSERT INTO Address
VALUES (2, '경기도...', 02345);


--3차 정규화_부서테이블
--부서번호(PK)	부서		주소번호(FK)
--======================================
--1			영업부	1
--2			사업부	2
--3			인사부	1
CREATE TABLE Departments2(
    DepartmentNumber	NUMBER	PRIMARY KEY
  , DepartmentName		VARCHAR2(255)
  , AddressPK			NUMBER
  , CONSTRAINT AddressPK_FK FOREIGN KEY(AddressPK) REFERENCES Address(AddressPK)
);

SELECT 	*
FROM 	departments2;

-- 데이터 삽입
INSERT INTO departments2
VALUES (1, '영업부', 1);

INSERT INTO departments2
VALUES (2, '사업부', 2);

INSERT INTO departments2
VALUES (3, '인사부', 1);

--3차 정규화_직원테이블
--직원번호(PK)	이름		생일						부서번호(FK)	급여
--===================================================================
--1			스티븐	2010-12-31 00:00:00.000	1			300
--2			마리		2011-10-01 00:00:00.000	1			250
--3			찰스		2003-05-01 00:00:00.000	2			200
--4			마리아	1995-08-15 00:00:00.000	3			280
--5			제임스	1988-03-22 00:00:00.000	1			320
--6			안나		2000-12-10 00:00:00.000	1			270
CREATE TABLE EMPLOYEES4(
    EmployeeID			NUMBER PRIMARY KEY
  , Name				VARCHAR2(50)
  , BirthDate			DATE
  , DepartmentNumber	NUMBER
  , Salary				NUMBER
  , CONSTRAINT DepartmentNumber_FK1 FOREIGN KEY(DepartmentNumber) REFERENCES departments2(DepartmentNumber)
); 

SELECT 	*
FROM 	employees4;

INSERT INTO Employees4
VALUES (1, '스티븐', TO_DATE('2010-12-31', 'YYYY-MM-DD'),1, 300);

INSERT INTO Employees4
VALUES (2, '마리', TO_DATE('2011-10-01', 'YYYY-MM-DD'), 1, 250);

INSERT INTO Employees4
VALUES (3, '찰스', TO_DATE('2003-05-01', 'YYYY-MM-DD'), 2, 200);

INSERT INTO Employees4
VALUES (4, '마리아', TO_DATE('1995-08-15', 'YYYY-MM-DD'), 3, 280);

INSERT INTO Employees4
VALUES (5, '제임스', TO_DATE('1988-03-22', 'YYYY-MM-DD'), 1, 320);

INSERT INTO Employees4
VALUES (6, '안나', TO_DATE('2000-12-10', 'YYYY-MM-DD'), 1, 270);