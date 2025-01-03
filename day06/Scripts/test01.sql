/* 1. JOBS 테이블에서 JOB_ID로 직원들의 JOB_TITLE, EMAIL, 성, 이름 조회 */

SELECT	j.job_id
	  , job_title
	  , email
	  , last_name "성"
	  , first_name "이름"
FROM	jobs j
JOIN	employees E
ON		J.JOB_ID = e.JOB_ID;

/* 2. EMPLOYEES 테이블에서 HIREDATE가 2003~2004년까지인 사원의 정보와 부서명 검색 */

SELECT	e.*
	  , d.department_name
FROM	departments d
JOIN	employees e
ON		d.department_id = e.department_id
	AND		hire_date BETWEEN TO_date('2003-01-01') AND to_date('2004-12-31');

/* 3. EMP 테이블에서 ENAME에 L이 있는 사원들의 DNAME과 LOC 검색 */

SELECT 	ename
	  , dname
	  , loc
FROM	emp e
JOIN	dept d
ON 		e.deptno = d.DEPTNO
WHERE 	e.ename like '%L%';

/* 4. SCHEDULE 테이블에서 경기 일정이 20120501 ~ 20120502 사이에 있는 경기장 전체 정보 조회 */

SELECT 	st.*
	  , sc.sche_date
FROM	stadium st
JOIN	SCHEDULE sc
ON		st.STADIUM_ID = sc.STADIUM_ID
WHERE 	sc.SCHE_DATE BETWEEN to_date('20120501') AND to_date('20120502')
;

/* 5. 축구 선수들 중에서 각 팀 별로 키가 가장 큰 선수들의 전체 정보 조회 */
/* 위 문제를 JOIN없이 풀기
 * (A,B) IN (C, D) : A = C AND B = D */

SELECT  *
FROM    player p
WHERE	(team_id, height) IN (SELECT	team_id, max(HEIGHT)
							  FROM		player
							  GROUP BY	team_id)
;

/* 6. EMP 테이블의 SAL을 이용, SALGRADE 테이블을 참고하여 모든 사원의 정보를 GRADE를 포함하여 조회 */

SELECT 	ename
	  , CASE
	  		WHEN sal BETWEEN 700 AND 1200 THEN '1'
	  		WHEN sal BETWEEN 1201 AND 1400 THEN '2'
	  		WHEN sal BETWEEN 1401 AND 2000 THEN '3'
	  		WHEN sal BETWEEN 2001 AND 3000 THEN '4'
	  		ELSE '5'
	  END "급여수준"
FROM 	emp
;

SELECT 	*
FROM 	emp e
JOIN	salgrade s
ON 		e.SAL >= s.losal AND e.sal <= s.HISAL
;

/* 7. EMP 테이블에서 각 사원의 매니저 이름 조회 */

SELECT 	*
FROM 	EMP
;

SELECT 	e1.empno "사원 번호"
	  , e1.ename "사원 이름"
	  , e2.mgr "매니저 번호"
	  , e2.ename "매니저 이름"
FROM	emp e1
JOIN	emp e2
ON 		e1.empno = e2.mgr
;

/* 8. 축구 선수들 중에서 각 팀 별로 키가 가장 큰 선수들의 전체 정보 조회 */

SELECT  p.*
	  , e."최대키"
FROM    PLAYER p
JOIN	(SELECT	team_id
	  		  , max(height) "최대키"
		 FROM 	player
		 GROUP BY team_id) e
ON		e.team_id = p.TEAM_ID AND e."최대키" = p.height
ORDER BY p.team_id
;

SELECT 	cols.table_name
	  , cols.column_name
	  , cols.constraint_name
FROM	all_constraints cons
JOIN	all_cons_columns cols
ON		cons.constraint_name = cols.constraint_name
WHERE 	cons.constraint_type = 'R' AND cols.TABLE_name = 'EMPLOYEES'
;

SELECT	cols.table_name
	  , cols.column_name
	  , cols.constraint_name
FROM	ALL_constraints cons
JOIN	all_cons_columns cols
ON		cons.constraint_name = cols.constraint_name
WHERE 	cons.constraint_type = 'P' AND cols.table_name = 'EMPLOYEES'
;