

-- # 단일행 서브쿼리
-- 서브쿼리의 조회 결과가 1건 이하인 경우

-- 부서코드가 100004번인 부서의 사원정보 조회

SELECT 
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
;

-- 사원이름이 이나라인 사람이 속해 있는 부서의 사원정보 조회 / 단일행 서브쿼리
SELECT 
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '이나라')
;

-- 사원이름이 이관심인 사람이 속해 있는 부서의 사원정보 조회
-- 단일행 비교연산자(=, <>, >, >=, <, <=)는 단일행 서브쿼리만 비교해야 함.
SELECT 
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '이관심') -- 행이 1개나와야함
;

-- 20200525에 받은 급여가 회사전체의 20200525일
-- 전체 평균 급여보다 높은 사원들의 정보(사번, 이름, 급여지급일, 받은급여액수) 조회
SELECT
    A.emp_no, A.emp_nm, B.pay_de, B.pay_amt
FROM tb_emp A
JOIN tb_sal_his B -- join하면 새로운 테이블이 생성
ON A.emp_no = B.emp_no
WHERE B.pay_de = '20200525' -- and는 두가지를 모두 부합해야됀다
    AND B.pay_amt >= ( -- 비연관 서브 쿼리 / 메인쿼리인 A,나 B를 가지고있지않아서
                        SELECT AVG(pay_amt)
                        FROM tb_sal_his
                        WHERE pay_de = '20200525'
                     )
ORDER BY A.emp_no, B.pay_de
;

-- 회사 전체 20200525 급여평균
SELECT AVG(pay_amt)
FROM tb_sal_his
WHERE pay_de = '20200525'
;


-- # 다중행 서브쿼리
-- 서브쿼리의 조회 건수가 0건 이상인 것
-- ## 다중행 연산자
-- 1. IN : 메인쿼리의 비교조건이 서브쿼리 결과중에 하나라도 일치하면 참
--    ex )  salary IN (200, 300, 400)
--            250 ->  200, 300, 400 중에 없으므로 false
-- 2. ANY, SOME : 메인쿼리의 비교조건이 서브쿼리의 검색결과 중 하나 이상 일치하면 참
--    ex )  salary > ANY (200, 300, 400)
--            250 ->  200보다 크므로 true
-- 3. ALL : 메인쿼리의 비교조건이 서브쿼리의 검색결과와 모두 일치하면 참
--    ex )  salary > ALL (200, 300, 400)
--            250 ->  200보다는 크지만 300, 400보다는 크지 않으므로 false
-- 4. EXISTS : 메인쿼리의 비교조건이 서브쿼리의 결과 중 만족하는 값이 하나라도 존재하면 참


-- 한국데이터베이스진흥원에서 발급한 자격증을 가지고 있는
-- 사원의 사원번호와 사원이름과 해당 사원의 한국데이터베이스진흥원에서 
-- 발급한 자격증 개수를 조회

SELECT certi_cd 
FROM tb_certi 
WHERE issue_insti_nm = '한국데이터베이스진흥원'
;
-- IN
SELECT 
    A.emp_no, A.emp_nm, COUNT(B.certi_cd) "자격증 개수"
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
WHERE B.certi_cd IN ( -- IN앞에있는것과 ()안에있는것을 비교 하나라도 일치하면 참
                        SELECT C.certi_cd 
                        FROM tb_certi C -- B하고  C하고비교함
                        WHERE issue_insti_nm = '한국데이터베이스진흥원'
                    )
GROUP BY A.emp_no, A.emp_nm
ORDER BY A.emp_no
;
-- ANY
SELECT 
    A.emp_no, A.emp_nm, COUNT(B.certi_cd) "자격증 개수"
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
WHERE B.certi_cd = ANY ( -- 메인쿼리의 비교조건이 서브쿼리의 검색결과 중 하나 이상 일치하면 참
                        SELECT certi_cd 
                        FROM tb_certi 
                        WHERE issue_insti_nm = '한국데이터베이스진흥원'
                    )
GROUP BY A.emp_no, A.emp_nm
ORDER BY A.emp_no
;

-- EXISTS문 : 메인쿼리의 비교조건이 서브쿼리의 결과 중 만족하는 값이 하나라도 존재하면 참
-- 주소가 강남인 직원들이 근무하고 있는 부서정보를 조회 (부서코드, 부서명)
SELECT emp_no, emp_nm, addr, dept_cd 
FROM tb_emp 
WHERE addr LIKE '%강남%'
;

SELECT dept_cd, dept_nm
FROM tb_dept
WHERE dept_cd IN ('100009', '100010')
;

SELECT dept_cd, dept_nm
FROM tb_dept 
WHERE dept_cd IN (
                    SELECT dept_cd 
                    FROM tb_emp 
                    WHERE addr LIKE '%강남%'
                )
;

SELECT 
    1
FROM tb_emp
WHERE addr LIKE '%강난%'
;


SELECT A.dept_cd, A.dept_nm
FROM tb_dept A
WHERE EXISTS ( -- 결과가 무언가 1개라도 떳을때 true
                    SELECT 1 -- 보통 여기에는 아무거만쓴다 참이면돼니까
                    FROM tb_emp  B
                    WHERE addr LIKE '%강남%' -- 이 두조건을 만족하는게 핵심
                        AND A.dept_cd = B.dept_cd   
                )
;

-- # 다중 칼럼 서브쿼리
--  : 서브쿼리의 조회 컬럼이 2개 이상인 서브쿼리

-- 부서원이 2명 이상인 부서 중에서 각 부서의 
-- 가장 연장자의 사변과 이름 생년월일과 부서코드를 조회

SELECT 
    A.emp_no, A.emp_nm, A.birth_de, A.dept_cd, B.dept_nm
FROM tb_emp A                       
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
WHERE (A.dept_cd, A.birth_de) IN (
                        SELECT
                            dept_cd, MIN(birth_de) -- where에서 컬럼2개 여기도 컬럼2개
                        FROM tb_emp
                        GROUP BY dept_cd
                        HAVING COUNT(*) >= 2
                    ) 
ORDER BY A.emp_no
;


-- 인라인 뷰 서브쿼리 (FROM절에 쓰는 서브쿼리)

-- 각 사원의 사변과 이름과 평균 급여정보를 조회하고 싶다./ 그룹화해서 줄이고 조인한다
SELECT
    A.emp_no, A.emp_nm, B.pay_avg
FROM tb_emp A, ( -- 사원의 급여가월마다쭉잇으니 사원의수만큼만 조회한다
                SELECT
                    emp_no, AVG(pay_amt) AS pay_avg -- emp_no가있어야 where할수잇음
                FROM tb_sal_his
                GROUP BY emp_no
                    ) B
WHERE A.emp_no = B.emp_no
ORDER BY A.emp_no
;


-- 스칼라 서브쿼리 (SELECT절에 쓰는 서브쿼리)

-- 사원의 사번, 사원명, 부서명, 생년월일, 성별코드를 조회
SELECT 
    A.emp_no
    , A.emp_nm
    , (SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm
    , A.birth_de
    , A.sex_cd
FROM tb_emp A
;


