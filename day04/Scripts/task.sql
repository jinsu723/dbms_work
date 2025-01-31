/* PLAYER 테이블에서 WEIGHT가 70이상이고 80이하인 선수 검색 */
SELECT 	player_name
	  , weight
FROM	player
WHERE	weight BETWEEN 70 AND 80
;

/* PLAYER 테이블에서 TEAM_ID가 'K03'이고 HEIGHT가 180 미만인 선수 검색 */
SELECT	player_name
	  , team_id
	  , height
FROM	player
WHERE 	team_id = 'K03' AND height < 180
;

/* PLAYER 테이블에서 TEAM_ID가 'K06'이고 NICKNAME이 '제리'인 선수 검색 */
SELECT 	player_name
	  , team_id
	  , nickname
FROM	player
WHERE 	team_id = 'K06' AND nickname = '제리'
;

/* PLAYER 테이블에서 HEIGHT가 170이상이고 WEIGHT가 80이상인 선수 이름 검색 */
SELECT 	player_name
	  , height
	  , weight
FROM	player
WHERE 	height >= 170 AND weight >= 80
;

/* STADIUM 테이블에서 SEAT_COUNT가 30000초과이고 41000이하인 경기장 검색 */
SELECT 	stadium_name
	  , seat_count
FROM	stadium
WHERE 	seat_count > 30000 AND seat_count <= 41000
;

/* PLAYER 테이블에서 TEAM_ID가 'K02'이거나 'K07'이고 포지션은 'MF'인 선수 검색 */
SELECT 	player_name
	  , team_id
	  , position
FROM 	player
WHERE 	(team_id = 'K02' OR team_id = 'K07') AND POSITION = 'MF'
;

/* PLAYER 테이블에서 POSITION이 NULL인 선수 검색 */
SELECT 	player_name
	  , POSITION
FROM	player
WHERE 	POSITION IS NULL
;

/* PLAYER 테이블에서 NICKNAME이 NULL인 선수를 '없음'으로 변경하여 조회하기 */
SELECT 	NVL(nickname, '없음')
FROM	player
;

/* PLAYER 테이블에서 NATION이 등록되어 있으면 '등록', 아니면 '미등록'으로 검색 */
SELECT 	player_name
	  , NVL2(nation, '등록', '미등록')
FROM	player
;

/* PLAYER 테이블에서 POSITION이 NULL인 선수를 '미정'으로 변경 후 검색 */
SELECT 	player_name
	  , nvl(POSITION, '미정')
FROM	player
;

-----------------------------------------------------------------------------------------
/* PlAYER 테이블에서 포지션 종류 검색 */
SELECT  POSITION
FROM	player
GROUP BY position
;

/* PLAYER 테이블에서 평균 몸무게가 80이상인 선수들의 평균 키가 180초과인 포지션 검색 */
SELECT 	POSITION
	  , avg(height) "평균 키"
FROM	player
WHERE 	weight >= 80
GROUP BY POSITION
HAVING avg(height) > 180
;

/* EMPLOYEES 테이블에서 JOB_ID별 평균 SALARY가 10000미만인 JOB_ID 검색 JOB_ID는 알파벳 순으로 정렬(오름차순) */
SELECT 	job_id
	  , avg(salary)
FROM	employees
GROUP BY job_id
HAVING	avg(salary) < 10000
ORDER BY job_id
;

/* PLAYER_ID가 2007로 시작하는 선수들 중 POSITION별 평균 키를 조회 */
SELECT 	POSITION
	  , avg(height)
FROM	(SELECT	position
			  , height
		 FROM	player
		 WHERE	player_id like '2007%') P1
GROUP BY position
;

/* 선수들 중 포지션이 DF인 선수들의 평균 키를 TEAM_ID 별로 조회하고 평균 키 오름차순으로 정렬하기 */
SELECT 	team_id
	  , round(avg(height), 2) "평균키"
FROM	player
WHERE 	POSITION = 'DF'
GROUP BY team_id
ORDER BY "평균키"
;

/* 포지션이 MF인 선수들의 입단연도 별 평균 몸무게, 평균 키를 구한다.
 * 칼럼명은 입단연도, 평균 몸무게, 평균 키 로 표시한다.
 * 입단연도를 오름차순으로 정렬한다.
 * 단, 평균 몸무게는 70 이상 그리고 평균 키는 160 이상인 입단연도만 조회 */
SELECT 	join_yyyy
	  , avg(weight)
	  , avg(height)
FROM	(SELECT join_yyyy
			  , weight
			  , height
		 FROM	player
		 WHERE	POSITION = 'MF') P1
GROUP BY join_yyyy
HAVING	avg(weight) >= 70 AND avg(height) >= 160
ORDER BY join_yyyy
;

/* PLAYER 테이블에서 TEAM_ID가 'K01'인 선수 중 POSITION이
 * 'GK'인 선수를 조회하기 SUB쿼리 사용하기 */
SELECT 	player_name
	  , team_id
	  , POSITION
FROM	(SELECT	team_id
			  , player_name
			  , position
		 FROM	PLAYER
		 WHERE	team_id = 'K01') P
WHERE 	POSITION = 'GK'
;

/* PLAYER 테이블에서 평균 몸무게보다 더 많이 나가는 선수들 검색 (조건에 서브쿼리 사용) */
SELECT 	*
FROM	player
WHERE 	weight > (SELECT	avg(WEIGHT)
				  FROM		player)
;

/* PLAYER 테이블에서 정남일 선수가 소속된 팀의 선수들 조회*/
SELECT 	*
FROM	player
WHERE 	team_id = (SELECT	TEAM_ID
				   FROM		player
				   WHERE	player_name = '정남일')
;

/* PLAYER 테이블에서 평균 키보다 작은 선수 조회*/
SELECT 	*
FROM	player
WHERE 	height < (SELECT	avg(height)
				  FROM		player)
;

/*SCHEDULE 테이블에서 경기 일정이 
 * 20120501 ~ 20120502 사이에 있는 경기장 전체 정보 조회*/
SELECT 	*
FROM 	stadium
WHERE 	stadium_id IN (SELECT	STADIUM_ID
					   FROM		SCHEDULE
					   WHERE	sche_date = '20120501' OR sche_date = '20120502')
;

/*
 * EMPLOYEE 테이블
 * 핸드폰번호가 515로 시작하는 사원들의
 * JOB_ID별 SALARY 평균을 구한다.
 * 조회 컬럼은 부서, 평균 급여 로 표시한다.
 * 평균 급여가 높은 순으로 정렬한다.
 */

SELECT	department_id
	  , (SELECT	round(avg(salary), 2)
	  	 FROM	employees E2
	  	 WHERE 	E2.job_id = E.job_id AND phone_number LIKE '515%'
	  	) "job_id 별 평균"
FROM	employees E
GROUP BY department_id, job_id
ORDER BY "job_id 별 평균" desc
;
/* COMMISSION_PCT 별 평균 급여를 조회한다.
 * COMMISSION_PCT 를 오름차순으로 정렬하며 
 * HAVING절을 사용하여 NULL은 제외한다.*/
SELECT 	commission_pct
	  , avg(salary)
FROM	employees
GROUP BY commission_pct
HAVING	commission_pct IS NOT NULL
ORDER BY avg(salary)
;