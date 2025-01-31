-- 2번 : 연산자

-- 연산자 피연산자 자리에 어떤 타입의 값이 오는지
-- 연산자가 어떻게 동작하는지
-- 연산의 결과가 어떤 타입의 값인지 아는 것이 중요하다!!!

-- 자료형 : 문자형(CHAR, VARCHAR2), 숫자형(NUMBER), 날짜(DATE, TIMESTAMP)

-- ) 연결 연산자
-- a || b : a와 b를 연결해준다

-- dual 테이블 : 다른 테이블을 참조할 필요 없이 값을 확인하고 싶을 때 사용할 수 있는 테이블(오라클에서 지원)
SELECT	10, 20, 10 || 20
FROM	dual;

SELECT 	'a', 'b', 'a' || 'b'
FROM 	dual;

-- employees 테이블에서 이름과 성을 붙여서 이름이라느 별칭으로 조회
SELECT 	FIRST_NAME
      , last_name
      , first_name || ' ' || last_name 이름
from	employees;

-- 날짜타입 값 확인
SELECT  hire_date || '안녕'
FROM 	employees;

-- [실습] 사원의 이름과 메일주소 출력하기
-- 이 때 이름은 first_name 과 last_name이 띄어쓰기로 이어져서 이름이라는 컬럼명으로 쓰고
-- 메일 주소는 사원메일주소@koreait.com으로 메일 주소라는 컬럼명으로 되어있다
SELECT 	first_name || ' ' || last_name 이름
	  , email || '@koreait.com' "메일 주소"
FROM 	employees;

-- 2) 산술연산자
SELECT 	employee_id
	  , employee_id + 10
	  , employee_id - 10
	  , employee_id * 10
	  , employee_id / 2
FROM	EMPLOYEES;

-- 날짜 타입과 산술연산
-- 날짜와 숫자 => 결과 날짜 타입
SELECT 	hire_date
	  , hire_date + 10
	  , hire_date - 10
FROM	employees;

-- 날짜와 날짜
SELECT 	SYSDATE 
FROM	dual;

SELECT 	hire_date
	  , sysdate
	  , hire_date - SYSDATE
from	employees;

-- 날짜 + 날짜 => 오류발생
--SELECT 	hire_date
--	  , SYSDATE 
--	  , hire_date + sysdate
--FROM	employees;

-- 날짜와 숫자의 연산에서 기본적으로 숫자는 일수를 의미하기 때문에 시간, 분 단위로 연산하고 싶다면
-- 일(24h)로 환산해야 한다
SELECT 	sysdate
	  , sysdate - 0.5
	  , sysdate + 0.5
FROM	dual
-- sysdate - 12/24 -- 12시간
-- sysdate + 1/24 -- 1시간
-- sysdate - 30/60/24  -- 30분

-- 4) 관계연산자

-- 직원의 이름, 성, 급여를 조회한다
-- 급여가 10000이상인 직원들 조회
SELECT	first_name 이름
	  , last_name 성
	  , salary 급여
FROM	employees
WHERE	salary >= 10000
ORDER BY 급여;

-- 직원 이름, 성을 조회한다
-- 단, 이름이 Peter 인 직원만 골라서 조회한다
SELECT 	first_name
	  , LAST_name
FROM	employees
WHERE 	first_name = 'Peter';
-- Peter는 문자타입이므로 반드시 ''로 감싸줘야하며 P는 소문자로 작성하면 안된다
-- 데이터의 대소문자는 정확하게 구분을 한다

-- 5) 논리연산자
-- AND, OR, NOT
-- 피연산자 자리에 조건이 온다, 여러 개의 조건을 연결할 때 사용한다

-- employees 테이블에서 부서가 영업부터(80)이면서 급여가 10000이상인 직원들의
-- 이름, 성, 급여, 부서id를 급여 오름차순으로 조회하기
SELECT 	first_name		"이름"
	  , last_name		"성"
	  , salary			"급여"
	  , department_id	"부서id"
FROM	employees
WHERE 	department_id = 80 AND salary >= 10000
ORDER BY salary;

-- 6) SQL 연산자
-- BETWEEN a AND b : a이상 b이하인 조건 => 범위 내에 포함되면 됨

-- employees 테이블에서 salary가 10000이상 12000이하인 직원의
-- first_name, last_name, salary를 salary 오름차순으로 조회
SELECT 	first_name
	  , last_name
	  , salary
FROM	employees
WHERE 	salary BETWEEN 10000 AND 12000
ORDER BY salary;

-- IN(a, b, c) : a이거나 b이거나 c인 조건 => a, b, c 중 하나라도 포함되면 됨
SELECT 	first_name
	  , last_name
	  , salary
FROM	employees
WHERE 	salary IN(10000, 11000, 12000)
ORDER BY salary;

-- Like : 문자 조건, 패턴을 만들 때 사용한다
-- % : ~아무거나, _ : 자리수
SELECT 	first_name
FROM	employees
WHERE 	first_name LIKE '____e';  -- 앞에 4자리

SELECT 	first_name
FROM	employees
WHERE 	first_name LIKE '%e';  -- 앞에 뭐가 있든 상관없음
-- %e% : e를 포함하는 문자 조건
-- %en% : en을 포함하는 문자 조건
-- %e%n% : e와 n을 포함하는 문자 조건
-- %e_n% : e와 n 사이에 한 글자가 더 있는 문자를 의미

-- IS NULL/IS NOT NULL
-- NULL : 데이터가 없음을 의미
-- NULL은 연산하면 결과가 NULL이다

SELECT	NULL + 10
FROM	dual;

-- employees 테이블에서 commission_pct를 출력하기
SELECT 	first_name
	  , last_name
	  , commission_pct
FROM	employees
WHERE 	commission_pct IS NULL;
--WHERE	commission_pct = NULL;  -- 아무런 결과가 나오지 않는다  NULL값을 확인할 때는 =(관계연산자)가 아니니 IS NULL로 확인한다

SELECT 	first_name
	  , last_name
	  , commission_pct
FROM	employees
WHERE 	commission_pct IS NOT NULL;

-- 직원의 이름, 봉급, 인상 봉금, 감축 봉급을 조회하기
-- 이름은 성과 이름을 함께 띄어쓰기로 연결되어있다
-- 인상 봉급은 기존 봉급의 10% 증가되었고(1.1)
-- 감축 봉급은 기존 봉급의 10% 감소되었다(0.9)
-- 결과를 기존 봉급 오름차순으로 정렬하여 조회한다
SELECT 	first_name || ' ' || last_name 이름
	  , salary * 1.1	"인상 봉급"
	  , salary * 0.9	"감축 봉급"
	  , salary			"기존 봉급"
FROM	employees
ORDER BY salary;