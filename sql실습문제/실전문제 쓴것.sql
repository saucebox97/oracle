

CREATE TABLE 일자별매출_93 (
    일자 DATE,
    매출액 NUMBER(10)
);

INSERT INTO 일자별매출_93 VALUES ('2015-11-01', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-02', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-03', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-04', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-05', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-06', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-07', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-08', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-09', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-10', 1000);
COMMIT;

-- 보기 1

SELECT A.일자, SUM(A.매출액) AS 누적매출액
FROM 일자별매출_93 A
GROUP BY A.일자
ORDER BY A.일자;

-- 보기 2

SELECT B.일자, SUM(B.매출액) AS 누적매출액
FROM 일자별매출_93 A
JOIN 일자별매출_93 B 
ON (A.일자 >= B.일자)
GROUP BY B.일자
ORDER BY B.일자;

SELECT A.일자, A.매출액, B.일자, B.매출액
FROM 일자별매출_93 A
JOIN 일자별매출_93 B 
ON (A.일자 >= B.일자)
ORDER BY B.일자;


SELECT * FROM 일자별매출_93;


-- 86번
SELECT * FROM 회원기본정보_86;
SELECT * FROM 회원상세정보_86;

-- 보기 1
SELECT user_id FROM 회원기본정보_86
MINUS
SELECT user_id FROM 회원상세정보_86
;


-- 보기 2
SELECT user_id FROM 회원기본정보_86
UNION ALL
SELECT user_id FROM 회원상세정보_86
;


-- 보기 3
SELECT user_id FROM 회원기본정보_86
INTERSECT
SELECT user_id FROM 회원상세정보_86
;

SELECT A.user_id 
FROM 회원기본정보_86 A 
JOIN 회원상세정보_86 B 
ON A.user_id = B.user_id
;

-- 보기 4
SELECT user_id FROM 회원기본정보_86
INTERSECT
SELECT user_id FROM 회원상세정보_86
;

SELECT user_id FROM 회원기본정보_86
UNION
SELECT user_id FROM 회원상세정보_86
;


-- #91번
DROP TABLE 부서_91; -- 테이블을삭제해줌

-- 테이블 작성
-- 부서테이블
CREATE TABLE 부서_91 (
 부서코드 VARCHAR2(20),
 부서명 VARCHAR2(100),
 상위부서코드 VARCHAR2(20),
 CONSTRAINT pk_부서_91 PRIMARY KEY(부서코드) -- constratint 옆엔 맘대로쓰는것
);

-- fk 선언
ALTER TABLE 부서_91 
ADD CONSTRAINT fk_상위부서코드_91 
FOREIGN KEY (상위부서코드)
REFERENCES 부서_91 (부서코드);

INSERT INTO 부서_91 VALUES(100, '아시아부', NULL);
INSERT INTO 부서_91 VALUES(110, '한국지사', 100);
INSERT INTO 부서_91 VALUES(111, '서울지점', 110);
INSERT INTO 부서_91 VALUES(112, '부산지점', 110);
INSERT INTO 부서_91 VALUES(120, '일본지사', 100);
INSERT INTO 부서_91 VALUES(121, '도쿄지점', 120);
INSERT INTO 부서_91 VALUES(122, '오사카지점', 120);
INSERT INTO 부서_91 VALUES(130, '중국지사', 100);
INSERT INTO 부서_91 VALUES(131, '베이징지점', 130);
INSERT INTO 부서_91 VALUES(132, '상하이지점', 130);
INSERT INTO 부서_91 VALUES(200, '남유럽지부', NULL);
INSERT INTO 부서_91 VALUES(210, '스페인지사', 200);
INSERT INTO 부서_91 VALUES(211, '마드리드지점', 210);
INSERT INTO 부서_91 VALUES(212, '그라나다지점', 210);
INSERT INTO 부서_91 VALUES(220, '포루투갈지사', 200);
INSERT INTO 부서_91 VALUES(221, '리스본지점', 220);
INSERT INTO 부서_91 VALUES(222, '그라나다지점', 220);

COMMIT;

-- 매출 테이블
DROP TABLE 매출_91;
CREATE TABLE 매출_91(
부서코드 VARCHAR2(20),
매출액 NUMBER(20));

INSERT INTO 매출_91 VALUES(111,1000);
INSERT INTO 매출_91 VALUES(112,2000);
INSERT INTO 매출_91 VALUES(121,1500);
INSERT INTO 매출_91 VALUES(122,1000);
INSERT INTO 매출_91 VALUES(131,1500);
INSERT INTO 매출_91 VALUES(132,2000);
INSERT INTO 매출_91 VALUES(211,2000);
INSERT INTO 매출_91 VALUES(212,1500);
INSERT INTO 매출_91 VALUES(221,1000);
INSERT INTO 매출_91 VALUES(222,2000);
COMMIT;

SELECT * FROM 부서_91;
SELECT * FROM 매출_91;

-- 보기 1번
SELECT A.부서코드, A.부서명, A.상위부서코드, B.매출액, LVL
FROM (
    SELECT 부서코드, 부서명, 상위부서코드, LEVEL AS LVL
    FROM 부서_91
    START WITH 부서코드 = '120'
    CONNECT BY PRIOR 상위부서코드 = 부서코드
    UNION
    SELECT 부서코드, 부서명, 상위부서코드, LEVEL AS LVL
    FROM 부서_91
    START WITH 부서코드 = '120'
    CONNECT BY 상위부서코드 = PRIOR 부서코드) A LEFT OUTER JOIN 매출_91 B
ON (A.부서코드 = B.부서코드)
ORDER BY A.부서코드;

-----------------------------------------------------------------
-- 9번 
DROP TABLE T ;
CREATE TABLE T (
C INTEGER PRIMARY KEY, D INTEGER
);
INSERT INTO T VALUES (1 , 1);
INSERT INTO T VALUES (2 , 1);

CREATE TABLE S (
B INTEGER PRIMARY KEY, c INTEGER REFERENCES T(C) ON DELETE CASCADE 
);

INSERT INTO S VALUES (1 , 1);
INSERT INTO S VALUES (2 , 1);

CREATE TABLE R (
A INTEGER PRIMARY KEY, B INTEGER REFERENCES S(B) ON DELETE SET NULL
);

INSERT INTO R VALUES (1 , 1);
INSERT INTO R VALUES (2 , 2);

SELECT *FROM T ;
SELECT *FROM S ;
SELECT *FROM R ;

-- 할때 
DELETE FROM T ;

-- 의 값은 ? 
SELECT *FROM R ;

--------------------------------------------------------------
-- 13번

CREATE TABLE  학생(
학번 CHAR(8) PRIMARY KEY 
, 장학금 INTEGER
);
INSERT INTO 학생 VALUES ('1',1234);
INSERT INTO 학생 VALUES ('2',1344);
INSERT INTO 학생 VALUES ('3',1554);

SELECT * FROM 학생;

SELECT COUNT(*) FROM 학생;
SELECT COUNT(학번) FROM 학생 ; 

----------------------------------------------------------
--17 번 

CREATE TABLE 부서 (
부서번호 CHAR(10) 
,부서명 CHAR(10)
);

ALTER TABLE 부서 ADD CONSTRAINT PK_부서_부서번호 PRIMARY KEY (부서번호);
COMMIT;

CREATE TABLE 직원 (
직원번호 CHAR(10) ,
소속부서 CHAR(10)
);

ALTER TABLE 직원 ADD CONSTRAINT PK_직원_직원번호 PRIMARY KEY (직원번호);
ALTER TABLE 직원 ADD CONSTRAINT FK_직원_소속부서 FOREIGN KEY (소속부서) REFERENCES 부서(부서번호) ON DELETE CASCADE;

INSERT INTO 부서  VALUES ('10' , '영업과');
INSERT INTO 부서  VALUES ('20' , '기획과');

INSERT INTO 직원  VALUES ('1000' , '10');
INSERT INTO 직원  VALUES ('2000' , '20');
INSERT INTO 직원  VALUES ('3000' , '20');
COMMIT; 

SELECT * FROM 부서 ;
SELECT * FROM 직원 ;


SELECT COUNT(직원번호) FROM 직원 ;
SELECT * FROM 직원 ;

DELETE FROM 부서 WHERE 부서번호 = '20';
SELECT * FROM 부서 ;

SELECT COUNT(직원번호) FROM 직원 ;
SELECT * FROM 직원 ;

COMMIT; 

-----------------------------------------------------------------
 -- 22번 
CREATE TABLE 고객 (
    고객ID VARCHAR2(20) NOT NULL 
    , 고객명 VARCHAR(20) NULL 
    , 가입일시 DATE NOT NULL 
);
ALTER TABLE 고객 ADD CONSTRAINT PK_고객ID PRIMARY KEY (고객ID);

CREATE TABLE 주문 (
주문번호 VARCHAR(20) NOT NULL  
, 고객ID VARCHAR(20) NOT NULL
, 주문일시 DATE NOT NULL 
);

ALTER TABLE 주문 ADD CONSTRAINT FK_고객ID FOREIGN KEY (고객ID) REFERENCES 고객(고객ID) ON DELETE SET NULL;

INSERT INTO 고객 VALUES('C001','홍길동','2013-12-12');
INSERT INTO 고객 VALUES('C002','이순신','2013-12-12');

COMMIT;

INSERT INTO 주문 VALUES('0001','C001','2013-12-24');
INSERT INTO 주문 VALUES('0002','C001','2013-12-25');
INSERT INTO 주문 VALUES('0003','C002','2013-12-26');
INSERT INTO 주문 VALUES('0004','C002','2013-12-27');

SELECT * FROM 고객 ; 
SELECT * FROM 주문 ; 
DROP TABLE 고객 ;
DROP TABLE 주문 ;
-- 오류 없이 정상적으로 수행되는 SQL 을 고르시오 
-- 1.번
INSERT INTO 고객 VALUES ('C003','강감찬' , '2014-01-01'); -- 가능
-- 2.번
INSERT INTO 주문 VALUES ('0005', 'C003' , '2013-12-28'); 
-- 고객데이터에 C003 이라는 데이터가 없어서 주문 등록이 안됨
-- 3번 
DELETE FROM 주문 WHERE 주문번호 IN ('0001' ,'0002'); --가능

-- 4번 
DELETE FROM 고객 WHERE 고객ID = 'C002';
-- 주문테이블에 고객ID에 NOT NULL 이 걸려있어서 충돌남    


