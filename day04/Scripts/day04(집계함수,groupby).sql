-- 집계함수 : 결과 행 1개
-- 주의사항 : NULL은 포함시키지 않는다
SELECT	*
FROM 	employees;

-- count()
-- 전체 직원 수 확인
SELECT 	count(*)
FROM	employees;

-- 특정 부서 110번의 직원 수 확인
SELECT	DISTINCT department_id
FROM	employees;

SELECT	count(*) AS "110번의 직원 수"
FROM	employees
WHERE 	department_id = 110;

-- SUM()
-- 모든 직원의 급여 총합 계산
--SELECT 	first_name
SELECT	sum(salary)
FROM	employees;

-- 부서별 급여 총합 계산
SELECT 	DISTINCT department_id
			   , salary
FROM	employees;

SELECT 	department_id
	  , sum(salary)
FROM	employees
GROUP BY department_id;

-- AVG()
-- 전체 직원의 평균 급여
SELECT 	AVG(salary)
FROM	employees;

-- 부서별 평균 급여
SELECT 	department_id
	  , avg(salary)
FROM	employees
GROUP BY department_id;

-- MAX(), MIN()
SELECT 	max(salary) "최대"
	  , min(salary) "최소"
FROM	employees;

-- 부서별 최고급여, 최소급여, 평균급여, 총합 조회하기
SELECT 	department_id
	  , max(salary)
	  , min(salary)
	  , sum(salary)
FROM	employees
GROUP BY department_id
ORDER BY department_id;

SELECT 	*
FROM	employees;

SELECT 	count(NVL(commission_pct, 0)) "NULL 포함해서 세어보기"
	  , count(commission_pct) "NULL 빼고 세어보기"
FROM	employees;

-- GROUP BY, HAVING
-- 평균 급여가 5000이상인 부서
SELECT	department_id
	  , avg(salary)
FROM	employees
GROUP BY department_id
HAVING	avg(salary) >= 5000
;

-- 부서별 급여 총합이 50000보다 작은 부서들만 내림차순으로 정렬
SELECT 	department_id
	  , sum(salary) "급여 총합"
FROM 	employees
GROUP BY department_id
HAVING sum(salary) < 50000
ORDER BY "급여 총합" desc
;

-- group by : ~별
-- group by 컬럼명 having 조건식
-- where 절은 집계함수 불가, having 절은 집계함수 가능

CREATE TABLE tbl_stu( 
   stu_id NUMBER PRIMARY KEY,
   stu_name varchar2(100) NOT NULL,
   stu_phone varchar2(100),
   stu_age NUMBER,
   stu_dept varchar2(100) 
);

SELECT	*
FROM	tbl_stu;

INSERT INTO tbl_stu
--VALUES (1, '조승우', '010-8901-8888', 30, '교육학과');
--VALUES (2, '이동욱', '010-9012-9999', 30, '컴퓨터 공학과');
--VALUES (3, '김소현', '010-9876-1234', 20, '방송연예과');
--VALUES (4, '김남길', '010-5050-1222', 26, '컴퓨터 공학과');
--VALUES (5, '강하늘', '010-5111-5151', 22, '방송연예과');
--VALUES (6, '공유', '010-5050-5151', 30, '컴퓨터 공학과');
--VALUES (7, '이종혁', '010-1213-2222', 34, '방송연예과');
--VALUES (8, '박은빈', '010-1213-2222', 20, '방송연예과');

SELECT	*
FROM	tbl_stu;

-- 1) 학과 종류 검색
SELECT 	DISTINCT stu_dept "학과 명"
FROM	TBL_STU;

-- 2) 각 학과별 학생수 조회
SELECT	stu_dept "학과 명"
	  , count(*) "학생 수"
FROM	tbl_stu
GROUP BY stu_dept
;

-- 3) 각 학과별 평균나이 조회
SELECT 	stu_dept "학과 명"
	  , round(avg(stu_age), 2) "평균 연령"
FROM	tbl_stu
GROUP BY stu_dept
;

-- 4) 학과별로 30세 이상인 학생 조회
SELECT  stu_dept
	  , stu_name
	  , stu_age
FROM	tbl_stu
WHERE 	stu_age >= 30
;

-- 윈도우 함수OVER()
SELECT 	stu_dept
	  , stu_name
	  , stu_age
	  , stu_phone
	  , count(*) OVER (PARTITION BY stu_dept) "학생 수"
FROM 	tbl_stu
WHERE	stu_age >= 30
;

-- 서브쿼리 : 학과별 학생 정보를 출력하면서 그룹화된 정보 유지
SELECT 	t.stu_dept
	  , t.stu_name
	  , t.stu_age
	  , t.stu_phone
	  , s."학생 수"
FROM	tbl_stu t
JOIN(
	SELECT	STU_DEPT
  , count(*) "학생 수"
	FROM	tbl_stu
	WHERE 	stu_age >= 30
	GROUP BY stu_dept
	) s ON t.stu_dept = s.stu_dept
WHERE	t.stu_age >= 30
ORDER BY t.stu_dept
;

-- 5) 학생 이름이 김으로 시작하거나 이로 시작하는 학생들의 학과별 수 조회
SELECT 	stu_dept "학과 명"
	  , count(*) "학생 수"
FROM	tbl_stu
WHERE 	stu_name like '김%' OR stu_name like '이%'
GROUP BY stu_dept
;

-- 6) 컴퓨터 공학과의 학생 중 25살 이상인 학생 수 조회
SELECT 	stu_dept "학과 명"
	  , count(*) "25살 이상인 학생 수"
FROM	tbl_stu
WHERE 	stu_dept = '컴퓨터 공학과' AND stu_age >= 25
GROUP BY stu_dept
;