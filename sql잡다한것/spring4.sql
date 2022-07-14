
SELECT SYSDATE FROM dual;

CREATE SEQUENCE seq_tbl_score;
CREATE TABLE tbl_score (
    stu_num NUMBER(10)
    , stu_name VARCHAR2(20) NOT NULL
    , kor NUMBER(3) NOT NULL
    , eng NUMBER(3) NOT NULL
    , math NUMBER(3) NOT NULL
    , total NUMBER(3)
    , average NUMBER(5,2)
    , grade CHAR(1)
    , CONSTRAINT pk_tbl_score PRIMARY KEY (stu_num)
);

SELECT *
from tbl_score
;

----------------------------------------------------------

CREATE SEQUENCE seq_board;

DROP TABLE board;
CREATE TABLE board (
    board_no NUMBER(10),
    writer VARCHAR2(20) NOT NULL,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(2000),
    view_cnt NUMBER(10) DEFAULT 0,
    reg_date DATE DEFAULT SYSDATE,
    CONSTRAINT pk_board PRIMARY KEY (board_no)
);

SELECT *
from board
;