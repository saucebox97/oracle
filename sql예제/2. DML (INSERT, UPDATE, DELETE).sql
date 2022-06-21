

-- DML : 데이터 조작어
-- SELECT, INSERT, UPDATE, DELETE / R 조회/ C U D 갱신

INSERT INTO board
    (bno, title, content, writer, reg_date)
VALUES
    (1, '제목이야~', '랄랄라', '둘리', SYSDATE + 1);
    
-- NN 제약조건 위반 삽입 실패
INSERT INTO board
    (bno, content, writer)
VALUES
    (2, '하하호호~~', '둘리');

-- PK의 UNIQUE 제약조건 위반
INSERT INTO board
    (bno, title, writer)
VALUES
    (1, '하하호호~~', '마이콜');

INSERT INTO board
    (bno, title, writer)
VALUES
    (2, '하하호호~~', '쨱쨱이');
    
-- 컬럼을 명시하지 않았을 경우 반드시 모든 컬럼의 값을 순서대로 채워야 함
INSERT INTO board
    
VALUES
    (3, '제목제목~', '짹쨱이', '내용내용', SYSDATE + 30);
    
-- 데이터 수정
UPDATE board
SET title = '수정된 제목이야'
WHERE bno = 3;

UPDATE board
SET writer = '수정맨'
    , content = '메롱메롱메롱 fix'
WHERE bno = 2;

-- WHERE절 생략시 전체가 수정된다.
UPDATE board
SET writer = '나쁜놈';
    
    
-- 데이터 삭제
DELETE FROM board
WHERE bno = 1;


-- 전체 데이터 삭제
-- 1. WHERE절을 생략한 DKLETK절 (롤백 가능, 수동커밋 가능, 로그남기기 가능)
DELETE FROM board;
    
-- 2. TRUNCATE TABLE 
-- (롤백 불가능, 자동커밋, 로그를 남길 수 없음, 테이블 생성 초기상태로 복귀)
TRUNCATE TABLE board;

-- 3. DROP TABLE
-- (롤백 불가능, 자동커밋, 로그를 남길 수 없음, 테이블 구조 완전 삭제됨)
DROP TABLE board;
-- COMMIT이 일어난 시점부터 다음의 COMMIT전까지의 작업이 하나의 트랜잭션
COMMIT; -- 하는순간 못되돌림 /트랜잭션이 안끝남 / 확정이안됨
ROLLBACK;

SELECT * FROM board;












