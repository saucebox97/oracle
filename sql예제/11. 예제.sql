

CREATE TABLE 품질평가항목_101 (
    평가항목ID CHAR(7)
    , 평가항목명 VARCHAR2(50)
    , CONSTRAINT 품질평가항목_101_PK PRIMARY KEY (평가항목ID)
);

CREATE TABLE 평가대상상품_101 (
    상품ID CHAR(7)
    , 상품명 VARCHAR2(50)
    , CONSTRAINT 평가대상상품_101_PK PRIMARY KEY (상품ID)
);

CREATE TABLE 평가결과_101 (
    상품ID CHAR(7)
    , 평가회차 NUMBER
    , 평가항목ID CHAR(7)
    , 평가등급 CHAR(1)
    , 평가일자 CHAR(8)
    , CONSTRAINT 평가결과_101_PK PRIMARY KEY (상품ID, 평가회차, 평가항목ID)
);

INSERT INTO 품질평가항목_101 VALUES ('101', '강의자료');
INSERT INTO 품질평가항목_101 VALUES ('102', '기관시설');

INSERT INTO 평가대상상품_101 VALUES ('101', '자바수업');
INSERT INTO 평가대상상품_101 VALUES ('102', '파이썬수업');

INSERT INTO 평가결과_101 VALUES ('101', 1, '101', 'S', '20220629');
INSERT INTO 평가결과_101 VALUES ('101', 2, '101', 'A', '20220629');
INSERT INTO 평가결과_101 VALUES ('101', 3, '101', 'B', '20220629');

INSERT INTO 평가결과_101 VALUES ('101', 1, '102', 'B', '20220629');
INSERT INTO 평가결과_101 VALUES ('101', 2, '102', 'A', '20220629');
INSERT INTO 평가결과_101 VALUES ('101', 3, '102', 'S', '20220629');

INSERT INTO 평가결과_101 VALUES ('102', 1, '101', 'S', '20220629');
INSERT INTO 평가결과_101 VALUES ('102', 2, '101', 'A', '20220629');
INSERT INTO 평가결과_101 VALUES ('102', 3, '101', 'B', '20220629');

INSERT INTO 평가결과_101 VALUES ('102', 1, '102', 'B', '20220629');
INSERT INTO 평가결과_101 VALUES ('102', 2, '102', 'A', '20220629');
INSERT INTO 평가결과_101 VALUES ('102', 3, '102', 'S', '20220629');
INSERT INTO 평가결과_101 VALUES ('102', 4, '102', 'C', '20220629');

COMMIT;



SELECT
    B.상품ID, B.상품명, C.평가항목ID, C.평가항목명, A.평기회차, A.평가등급, A.평가일자
FROM 평가결과_101 A, 평가대상상품_101 B, 품질평가항목_101 C
WHERE A.상품ID = B.상품ID
    AND A.평가항목ID = C.평가항목ID
    AND A.평가항목ID = (
                            SELECT MAX(X.평가회차)
                            FROM 평가결과_101 X
                            WHERE X.상품ID = B.상품ID
                            AND X.평가항목ID = C.평가항목ID
                        )
;



-- 테이블 복사
CREATE TABLE tb_emp_copy
AS
SELECT emp_no, emp_nm, addr
FROM tb_emp;

SELECT * FROM tb_emp_copy;

-- 뷰 생성
CREATE VIEW tb_emp_view
AS
SELECT emp_no, emp_nm, addr, dept_cd
FROM tb_emp;

SELECT * FROM tb_emp_view;

DELETE FROM tb_emp_view
WHERE emp_nm = '김회장'
;






CREATE TABLE PERSON (
    ssn CHAR(14) PRIMARY KEY
    , person_name VARCHAR2(50) NOT NULL
    , age NUMBER NOT NULL
);

SELECT * FROM person;

DELETE FROM PERSON
WHERE age = '48'
;
commit;



















































