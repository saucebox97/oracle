-- DDL : 데이터 정의어
-- CREATE, ALTER, DROP, RENAME, TRUNCATE

DROP TABLE board; -- 테이블을 제거
-- DEFAULT는 아무 값도 입력하지 않아도 NULL 값이 아니라 설정한 값이 기본값으로 자동 입력되도록 하는 제약조건
-- CREATE TABLE : 테이블을 생성 / CLOB
CREATE TABLE board (
    bno NUMBER (10) -- UNIQUE는 중복배제
    , title VARCHAR2 (200) NOT NULL -- NOT NULL 무언가쓰게함
    , writer VARCHAR2 (20) NOT NULL -- UNIQUE쓰면 1사람이글여러개못씀
    , content CLOB -- 아주 긴 문자열데이터를 저장할 수 있는 데이터 타입
    , reg_date DATE DEFAULT SYSDATE -- 자동으로 현재시간이들어감
    , view_count NUMBER(10) DEFAULT 0 -- 조회수 0부터시작
);

-- ALTER : 데이터베이스의 구조를 변경

-- PK 설정 / 중복허용안함
ALTER TABLE board 
ADD CONSTRAINT pk_board_bno -- 제약조건을 추가한다
PRIMARY KEY (bno);

-- 데이터 추가
INSERT INTO board
    (bno, title, writer, content)
VALUES
    (1, '안뇽?', '꾸꾸까까', '아하하아하하 ㅋㅋㅋ');
    
INSERT INTO board
    (bno, title, writer)
VALUES
    (2, '맛있는 점심', '하하호호');
    
COMMIT; -- 최종적으로 COMMIT을 해주지않으면 결과가 테이블에 반영되지 않는다.



SELECT * FROM board;



-- 연관관계 설정
-- 게시물과 댓글의 관계
--    1  :  M

-- 댓글 테이블 생성
CREATE TABLE REPLY (
    rno NUMBER(10)
    , r_content VARCHAR2(400)
    , r_writer VARCHAR2(40) NOT NULL
    , bno NUMBER(10)
    , CONSTRAINT pk_reply_rno PRIMARY KEY (rno) -- PK 설정
);

-- 외래키 설정 (FORKEIGN KEY) : 테이블 간의 전체 제약 설정
ALTER TABLE reply
ADD CONSTRAINT fk_reply_bno
FOREIGN KEY (bno)
REFERENCES board (bno);

-- 칼럼 변경
-- 칼럼 추가
ALTER TABLE reply
ADD (r_reg_date DATE DEFAULT SYSDATE);

SELECT * FROM reply;

-- 컬럼 제거
ALTER TABLE board
DROP COLUMN view_count;

-- 컬럼 수정
ALTER TABLE board
MODIFY (title VARCHAR2(500));

SELECT * FROM board;

-- 테이블 삭제
DROP TABLE reply; -- 테이블 구조(전부) 삭제 
TRUNCATE TABLE board; -- 테이블 내부(데이터) 전체 삭제 - 롤백불가











