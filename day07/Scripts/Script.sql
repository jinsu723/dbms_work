/* 1. JOBS 테이블에서 JOB_ID로 직원들의 JOB_TITLE, EMAIL, 성, 이름 조회 */
SELECT 	*
FROM 	jobs;  -- 19

SELECT	*
FROM 	employees;  -- 107

SELECT 	e.job_id
	  , job_title
	  , email
	  , last_name
	  , first_name
FROM	jobs j
JOIN	employees e
ON		j.job_id = e.job_id
;
/* 2. EMPLOYEES 테이블에서 HIREDATE가 2003~2004년까지인 사원의 정보와 부서명 검색 */
SELECT 	*
FROM 	employees;  -- 107

SELECT 	*
FROM 	DEPARTMENTS d ;  -- 27

SELECT 	e.*
	  , d.department_name
FROM	departments d
JOIN	employees e
ON		e.HIRE_DATE BETWEEN '20030101' AND '20041231'
;
/* 3. EMP 테이블에서 ENAME에 L이 있는 사원들의 DNAME과 LOC 검색 */
SELECT * FROM user_tab_privs_recd;

SELECT * FROM emp;
SELECT * FROM dept;

SELECT 	ename
	  , dname
	  , loc
FROM	emp e
JOIN	dept d
ON		e.deptno = d.deptno
WHERE 	e.ename LIKE '%L%'
;

/* 4. SCHEDULE 테이블에서 경기 일정이 20120501 ~ 20120502 사이에 있는 경기장 전체 정보 조회 */
SELECT * FROM SCHEDULE;
SELECT * FROM stadium;

SELECT	sc.sche_date "경기일정"
	  , st.*
FROM 	SCHEDULE sc
JOIN 	stadium st
ON		sc.stadium_id = st.stadium_id
WHERE 	sc.sche_date BETWEEN '20120501' AND '20120502'
;

/* 5. 축구 선수들 중에서 각 팀 별로 키가 가장 큰 선수들의 전체 정보 조회 */
/* 위 문제를 JOIN없이 풀기
 * (A,B) IN (C, D) : A = C AND B = D */
SELECT * FROM player;

SELECT	*
FROM 	player
WHERE 	(team_id, height) IN (SELECT	team_id
									  , max(height)
							  FROM		PLAYER
							  GROUP BY team_id)
;

/* 6. EMP 테이블의 SAL을 이용, SALGRADE 테이블을 참고하여 모든 사원의 정보를 GRADE를 포함하여 조회 */
SELECT * FROM emp;
SELECT * FROM salgrade;

SELECT	e.*
	  , CASE 
	  		WHEN e.sal BETWEEN 700 AND 1200 THEN '1'
	  		WHEN e.sal BETWEEN 1200 AND 1400 THEN '2'
	  		WHEN e.sal BETWEEN 1401 AND 2000 THEN '3'
	  		WHEN e.sal BETWEEN 2001 AND 3000 THEN '4'
	  		ELSE '5'
	  END "급여수순"
FROM 	emp e
;
	  

/* 7. EMP 테이블에서 각 사원의 매니저 이름 조회 */
SELECT * FROM emp;

SELECT	e1.ename "사원이름"
	  , e2.ename "매니저이름"
FROM	emp e1
JOIN 	emp e2
ON		e1.empno = e2.mgr
;

/* 8. 축구 선수들 중에서 각 팀 별로 키가 가장 큰 선수들의 전체 정보 조회 */
CREATE VIEW view_team_hiest_height as
SELECT	p1.team_id
	  , PLAYER_Id
	  , player_name
	  , E_PLAYER_NAME
	  , nickname
	  , join_yyyy
	  , back_no
	  , nation
	  , birth_date
	  , solar
	  , height
	  , weight
FROM 	player p1
JOIN	(SELECT	team_id
			  , max(height) "키ㅁ"
		 FROM	player
		 GROUP BY team_id) p2
ON		p1.team_id = p2.team_id AND p1.height = p2."키ㅁ"
;

SELECT * FROM view_team_hiest_height;

DROP VIEW view_team_hiest_height;