

-- WHERE 조건절 : 조회 결과 항을 제한하는 조건절
SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE sex_cd = 2 -- = 는 같다라는 뜻이지 대입하겠따는 뜻이 아니다
;

-- PK로 WHERE절 동등조건을 만들면 반드시 단일행이 조회된다./ PK는 1개밖에안돼니까
SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE emp_no = 1000000003
;

-- 비교 연산자
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de >= '19900101'
    AND birth_de <= '19991231'
;

-- BETWEEN 연산자 / 바로 위와 같다
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de BETWEEN '19900101' AND '19991231'
;

-- OR 연산 / 100004인애와 100006인애 둘다 출력 AND는 둘다만족해야출력
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
    or dept_cd = '100006'
;

-- IN 연산자
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd IN ('100004', '100006') -- or 또는 이 됌
;

-- NOT IN 연산자
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd NOT IN ('100004', '100006') -- 100004,100006 둘빼고나머지다
;

-- LIKE 연산자
-- 검색시 사용
-- 와일드 카드 맵핑 (% : 0글자 이상, _ : 단 1글자만;
SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm like '이%' -- '이_' 이름이 2글자인사람 '이__' 이름이 3글자인사람
;

SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm like '%심' -- 끝글자만 심이어야만함
;

SELECT
    emp_no, emp_nm, addr
FROM tb_emp
WHERE addr like '%용인%'
;

-- 성씨가 김씨이면서, 부서가 100003, 100004, 100006번 중에 하나이면서, 
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드를 조회

SELECT
    emp_no, dept_cd, birth_de, emp_nm
FROM tb_emp
WHERE 1=1
    AND emp_nm LIKE '김%'
    AND dept_cd IN ('100003', '100004', '100006')
    AND birth_de BETWEEN '19900101' AND '19991231'
;

-- 부정 일치 비교 연산자
SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE sex_cd != 2 
;

SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE sex_cd ^= 2 
;

SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE sex_cd <> 2 
;

SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE NOT sex_cd = 2 
;

-- 성별코드가 1이 아니면서 성씨가 이씨가 아닌 사람들의
-- 사변, 이름,성별코드를 조회하세요.

SELECT
    emp_no, emp_nm, sex_cd
FROM tb_emp
WHERE 1=1
    AND sex_cd <> 1 
    AND emp_nm <> '이%'
;

-- null값 조회 : 반드시 IS NULL 연산자로 조회
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NULL
;

SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT NULL -- not is null이아닌 is not null
;

-- 연산자 우선순위 : NOT > AND > OR
-- 사원정보 중에 김씨이면서 수원 또는 일산에 사는 사원들의 정보
SELECT
    emp_no, emp_nm, addr
FROM tb_emp
WHERE 1=1
    AND emp_nm like '김%'
    AND (addr like '%수원%' or addr like '%일산%') -- ()없으면 김씨면서 수원사는애 그리고 그냥 일산사는애
;














