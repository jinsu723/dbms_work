-- 집합

-- 결과 6개 행
SELECT	*
FROM 	emp
WHERE 	deptno = 30;

-- 결과 3개 행
SELECT 	*
FROM 	EMP
WHERE 	deptno = 10;

-- emp 테이블에서 deptno가 30 또는 10인 테이블 조회
-- 두 테이블을 union(합집합)으로 연결한다
SELECT 	*
FROM 	emp
WHERE	deptno = 30
UNION	all
SELECT 	*
FROM 	emp
WHERE 	deptno = 10
;

-- emp 테이블에서 sal 1000 이상 2000 이하, 1500이상 3000이하의 결과를 같이 조회
SELECT 	*
FROM	emp
WHERE 	sal BETWEEN 1000 AND 2000
UNION
SELECT 	*
FROM 	emp
WHERE 	sal	BETWEEN 1500 AND 3000
;

SELECT * FROM emp;
SELECT * FROM dept;

-- 오류 : 열의 수가 다르면 union을 사용할 수 없다
SELECT 	*
FROM 	emp
UNION
SELECT	*
from	dept
;

-- 오류 : 열의 타입이 다르면 union 을 사용할 수 없다
SELECT 	empno
	  , deptno
	  , job
FROM	emp
UNION
SELECT	*
FROM 	dept
;

-- 열의 수와 타입이 일치한다면 union이 가능하다
SELECT	sal
	  , ename
	  , job
FROM	emp
UNION
SELECT	*
FROM	dept
;

-- 위쪽 쿼리에 별칭을 주면 결과 테이블의 옆 이름으로 사용된다
SELECT 	deptno 숫자
	  , dname 문자
	  , loc 문자
FROM	dept
UNION
SELECT	sal
	  , ename
	  , job
FROM	emp
;

-- union이 두 테이블 합치고 order by가 실행되므로
-- 합쳐지기 이전의 컬럼이나 소속을 이용해도 정렬되지 않는다
SELECT	empno 번호
	  , ename 이름
	  , job 직장
FROM	emp e
UNION
SELECT	*
FROM 	dept d
ORDER BY 이름
--ORDER BY ename  -- 별칭을 만들어줬기 때문에 별칭을 사용해야 한다
;

SELECT * FROM emp;
SELECT * FROM dept;

-- 교집합
SELECT 	player_name "이름"
	  , team_id "팀"
	  , height "키"
	  , weight "몸무게"
FROM	player
WHERE 	height BETWEEN 185 AND 186
INTERSECT
SELECT 	player_name "이름"
	  , team_id "팀"
	  , height "키"
	  , weight "몸무게"
FROM	player
WHERE 	weight BETWEEN 76 AND 78
;

-- 차집합
SELECT 	player_name "이름"
	  , team_id "팀"
	  , height "키"
	  , weight "몸무게"
FROM	player
WHERE 	height BETWEEN 185 AND 186
MINUS
SELECT 	player_name "이름"
	  , team_id "팀"
	  , height "키"
	  , weight "몸무게"
FROM	player
WHERE 	weight BETWEEN 76 AND 78
;

SELECT * FROM player;

-- 형 변환 함수
-- TO_CHAR()
SELECT 	sysdate
FROM	dual;

SELECT 	to_char(sysdate, 'yyyy/mm/dd')
FROM	dual
;

SELECT 	to_char(sysdate, 'yyyy"년 "mm"월 "dd"일"') "오늘 날짜"
FROM	dual
;

SELECT 	to_char(sysdate, 'YYYY/MM/DD-HH24:MI')
FROM	dual
;

-- to_number()
SELECT 	'1234'
	  , to_number('1234')
FROM	dual
;

SELECT 	'123' + '123'
FROM 	dual
;

-- to_date()
SELECT 	to_date('2300-12-25', 'yyyy-mm-dd')
FROM	dual
;

-- view
-- 회원 정보와 대여정보를 조합
CREATE	VIEW memrental AS 
SELECT	m.mem_id
	  , m.mem_name
	  , r.ren_id
	  , r.ren_rentaldate
	  , r.ren_returndate
FROM	tbl_member m
JOIN	tbl_rental r
ON		m.mem_id = r.mem_id
;

SELECT 	*
FROM 	memrental
;

SELECT sysdate FROM dual;	  
SELECT * FROM tbl_rental;

CREATE VIEW view_player AS
SELECT	player_name "이름"
	  , trunc(birth_date) "생일"
	  , round((sysdate - birth_date) / 365, 0) "나이"
FROM	player
;
-- trunc 함수 : 시간정보를 제거한 날짜값만 유지됨
-- trunc(data [, format]) : 날짜값에서 시간정보(HH:MI:SS)를 제거하고 반환됨

SELECT 	*
FROM 	view_player;

DROP VIEW view_player;

SELECT 	SYSDATE 
	  , trunc(sysdate, 'yyyy')
FROM	dual;

SELECT 	이름, 나이
FROM	view_player
;

--CREATE VIEW view_player as
SELECT 	p.*
	  , round((sysdate - birth_date) / 365, 0) AS "AGE"
FROM	player p
;

SELECT * FROM view_player;

--INSERT INTO view_player
--VALUES('1', '2', '3', '4', '5', '6', '7', 8, '9', sysdate, '11', 12, 13, 14);

SELECT * FROM player;

-- employees 테이블에서 사원 이름과 그 메니저 이름이 있는 view 만들기
SELECT * FROM employees;

-- self join
SELECT	e1.employee_id
	  , e1.FIRST_name || ' ' || e1.last_name "사원 이름"
	  , e2.first_name || ' ' || e2.last_name "메니저 이름"
FROM	employees e1
JOIN	employees e2
ON		e1.manager_id = e2.employee_id
;

SELECT 	e1.FIRST_name || ' ' || e1.last_name "사원 이름"
FROM	employees e1
;

SELECT 	manager_id
	  , e.first_name || ' ' || e.last_name "사원 이름"
FROM	employees e
;

SELECT 	e.employee_id
	  , e.first_name || ' ' || e.last_name "사원 이름"
	  , e1.manager_id
FROM	employees e
JOIN	employees e1
ON		e1.employee_id = e.manager_id
;

-- 셀프조인 : employees 테이블 내에서 직원과 해당 직원의 메니저를 같은 테이블 매칭
SELECT 	e1.employee_id "사원테이블"
	  , e2.employee_id "매니저테이블"
	  , e1.first_name || ' ' || e1.last_name "사원이름"
	  , e2.manager_id
	  , e2.first_name || ' ' || e2.LAST_name "매니저이름"
FROM	employees e1
JOIN	employees e2
ON		e1.manager_id = e2.manager_id
;
-- e1 : 사원, e2 : 매니저
-- on e1.manager_id = e2.employee_id
-- e1 사원의 manager_id가 e2 매니저 employee_id 와 일치할 때

SELECT 	first_name
	  , manager_id
FROM	employees
WHERE 	manager_id = 100
;

DROP VIEW view_player;
DROP VIEW view_employees;

CREATE VIEW view_employees AS
SELECT	e1.employee_id
	  , e1.FIRST_NAME || ' ' || e1.LAST_NAME 사원이름 
	  , e2.MANAGER_ID
	  , e2.FIRST_NAME || ' ' || e2.LAST_NAME 매니저이름
	  , e1.job_id
	  , e1.department_id
FROM	EMPLOYEES e1
JOIN	EMPLOYEES e2
ON		E1.MANAGER_ID = E2.EMPLOYEE_ID
;

SELECT * FROM VIEW_EMPLOYEES ve
;

-- view_employees의 department_id를 이용해서 department_name이 나오는지 확인하기
SELECT 	ve.employee_id
	  , ve.사원이름
	  , ve.department_id
	  , d.department_name
FROM	view_employees ve
JOIN	departments d
ON		ve.department_id = d.department_id
;

-- pk 설정된 것 확인 쿼리문
SELECT 	cols.table_name
	  , cols.COLUMN_name
	  , cols.constraint_name
FROM	all_constraints cons
JOIN	all_cons_columns cols
ON		cons.constraint_name = cols.constraint_name
WHERE 	cons.constraint_type = 'P'
		AND	cols.table_name = 'EMPLOYEES'
;

SELECT * FROM all_cons_columns COLS;

-- fk 설정된
SELECT	cols.table_name
	  , cols.column_name
	  , cons.constraint_name
FROM	all_constraints cons
JOIN	all_cons_columns cols
ON		cons.constraint_name = cols.constraint_name
WHERE	cons.constraint_type = 'R'
		AND	cols.table_name = 'EMPLOYEES';

SELECT * FROM user_tab_privs_recd;

ALL_constraints
all_cons_columns

SELECT * FROM tbl_books;

INSERT INTO tbl_books
VALUES(11, 'commit', 'tcl');

INSERT INTO tbl_books
VALUES(12, 'rollback', 'tcl');

DELETE FROM tbl_books CASCADE CONSTRAINT ;

SELECT * FROM tbl_rental;

DELETE FROM TBL_RENTAL
WHERE ren_id = 4;

TRUNCATE TABLE tbl_rental;

COMMIT;
ROLLBACK;

SELECT * FROM employees;

SELECT	first_name
	  , salary
	  , CASE
	  		WHEN	salary >= 50000 THEN '높음'
	  		WHEN	salary >= 30000 THEN '중간'
	  		ELSE 	'낮음'
	  	END "급여 수준"
FROM	employees
;