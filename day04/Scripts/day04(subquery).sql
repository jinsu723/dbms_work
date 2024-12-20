
-- 연관 서브쿼리
-- 최대 급여를 받는 직원 조회
SELECT	EMPLOYEE_ID, FIRST_NAME, SALARY
FROM	EMPLOYEES
WHERE	SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES)
;

SELECT MAX(SALARY) FROM EMPLOYEES;


SELECT 	employee_id
	  , first_name
	  , salary
	  , department_id
FROM	employees
WHERE 	salary > (SELECT avg(salary) FROM employees)
;
-- 비연관 서브쿼리
-- 각 직원의 급여가 부서별 평균 급여보다 높은 직원 조회
SELECT 	employee_id
	  , first_name
	  , salary
	  , department_id
FROM	employees E
WHERE 	salary > (SELECT	avg(salary)
				  FROM		employees
				  WHERE		department_id = E.department_id
				  )
ORDER BY E.department_id
;

-- 부서별 평균
SELECT 	department_id
	  , avg(salary)
FROM	employees
GROUP BY department_id
ORDER BY department_id
;

-- 단일행 서브쿼리(서브쿼리의 결과가 하나의 행만 반환)
-- 가장 오래된 입사일을 가진 직원의 사원번호, 이름, 입사일 조회 102번
SELECT 	*
FROM 	employees
ORDER BY hire_date ASC
;

SELECT 	employee_id
	  , first_name
	  , hire_date
FROM	employees
WHERE 	hire_date = (SELECT min(HIRE_DATE)
					 FROM	employees
					 )
;

-- 다중행 서브쿼리
-- 특정 부서에 속한 직원 조회
SELECT 	employee_id
	  , first_name
	  , department_id
FROM	employees e
WHERE 	department_id IN (
		SELECT	department_id
		FROM	departments d
		WHERE	department_name = 'IT'
						  )
;

-- EXISTS 연산자 : 서브쿼리의 결과가 존재하는지 여부를 확인할 때 사용
-- 부서별 평균 급여보다 높은 직원 수
SELECT E.DEPARTMENT_ID, COUNT(*) "직원수"
FROM 	EMPLOYEES E
WHERE EXISTS(
   SELECT	1
   FROM		EMPLOYEES E2
   WHERE	E2.DEPARTMENT_ID = E.DEPARTMENT_ID
      AND E.SALARY > (
         SELECT	AVG(SALARY)
         FROM	EMPLOYEES
         WHERE	E.DEPARTMENT_ID = E2.DEPARTMENT_ID
      )
   )
GROUP BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, AVG(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; -- 4150

SELECT DEPARTMENT_ID, SALARY FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30;

SELECT 	*
FROM 	employees
;

-- 전체 평균 급여와 부서별 평균 급여 구하기
SELECT 	avg(salary)  -- 1개 행
FROM	employees
;

SELECT	department_id  -- 12개 행
	  , avg(salary)
FROM	employees
GROUP BY department_id
;

-- 메인쿼리의 결과 행의 수보다 서브쿼리의 행의 수가 많으면 안된다
--SELECT 	avg(salary)
--	  , (SELECT	*
--	  	FROM 	employees)
--FROM	employees
--;
-- 오류 발생 : 서브쿼리의 행의 수가 메인쿼리보다 많음

SELECT 	department_id "부서명"
	  , avg(salary) "부서별 평균 급여"
	  , (SELECT avg(salary)
	  	FROM employees) "전체 평균 급여"
FROM	employees
GROUP BY department_id
;

-- 각 직원의 사원번호, 이름, 급여와 해당 부서의 평균 급여 조회
SELECT	department_id
--	  , employee_id
--	  , first_name
--	  , salary
	  , (SELECT	round(avg(salary), 2)
	  	 FROM	employees E2
	  	 WHERE 	E2.department_id = E.department_id
	  	) "해당 부서의 평균 급여"
FROM	employees E
GROUP BY department_id
ORDER BY department_id
;
-- SELECT절 : 계산된 값 또는 추가정보를 열로 표시!!

-- FROM 절 서브쿼리
-- 부서별 평균 급여를 계산한 후, 평균 급여보다 높은 직원 조회하기
SELECT	E.employee_id
	  , E.first_name
	  , E.salary
	  , T."평균"
FROM	employees E
		JOIN(
			SELECT	department_id
				  ,	round(avg(salary), 2) "평균"
			FROM	employees
			GROUP BY department_id
			) T
		ON	E.department_id = T.department_id
WHERE 	E.salary > T."평균"
;
-- FROM 절 :  데이터 소스역할, 주로 집계 데이터를 연결할 때 사용!!

-- WHERE 절 서브쿼리
-- 급여가 전체 평균 급여 이상인 직원 조회
SELECT 	employee_id
	  , first_name
	  , salary
FROM	employees
WHERE	salary >= (SELECT	avg(salary)
				   FROM		employees)
;
-- WHERE 절 : 필터 조건으로 사용하여 데이터를 제한

-- [실습] 평균 급여보다 낮은 사원들의 급여를 20%인상한 결과 테이블을 조회하라
SELECT 	employee_id
	  , first_name
	  , salary "기존 급여"
	  , salary * 1.2 "20% 인상 급여"
FROM	employees
WHERE 	salary < (SELECT	avg(salary)
				  FROM		employees
				  )
;

-- 1) 평균 급여
SELECT 	avg(salary)  -- 6,461.831
FROM	employees E
;

-- 2) 전체 쿼리 생각
SELECT 	employee_id
	  , first_name
	  , salary * 1.2
FROM	employees
;

SELECT employee_id
	  , first_name
	  , salary * 1.2
FROM	employees
WHERE 	salary < (SELECT	avg(salary)
				  FROM		employees
				  )
;

-- ROWNUM
SELECT 	ROWNUM
	  , E.* 
FROM 	employees E
;

SELECT 	rownum
	  , salary
FROM	employees
;

-- employess 테이블에서 salary를 내림차순으로 정렬한 후 rownum을 붙여서 조회하기
SELECT 	rownum
	  , E.*
FROM	employees E
ORDER BY salary DESC
;

SELECT 	rownum
	  , E2.*
FROM	(SELECT	*
		 FROM	EMPLOYEES
		 ORDER BY salary desc) E2
;

SELECT 	rownum
	  , E2.*
FROM	(SELECT	*
		 FROM	EMPLOYEES
		 ORDER BY salary desc) E2
WHERE	rownum BETWEEN 1 AND 5
;

-- 연봉 상위 6 ~ 10위까지 조회
SELECT 	rownum
	  , E2.*
FROM	(SELECT	*
		 FROM	EMPLOYEES
		 ORDER BY salary desc) E2
WHERE	rownum BETWEEN 1 AND 10
;

SELECT 	rownum
	  , E3.*
FROM	(SELECT	rownum "rn"
			  , E2.*
		 FROM	(SELECT	*
			 	 FROM	EMPLOYEES E
		 		 ORDER BY salary DESC) E2) E3
WHERE "rn" between 6 AND 10
;