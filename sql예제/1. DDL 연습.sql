-- DDL : ������ ���Ǿ�
-- CREATE, ALTER, DROP, RENAME, TRUNCATE

DROP TABLE board; -- ���̺��� ����
-- DEFAULT�� �ƹ� ���� �Է����� �ʾƵ� NULL ���� �ƴ϶� ������ ���� �⺻������ �ڵ� �Էµǵ��� �ϴ� ��������
-- CREATE TABLE : ���̺��� ���� / CLOB
CREATE TABLE board (
    bno NUMBER (10) -- UNIQUE�� �ߺ�����
    , title VARCHAR2 (200) NOT NULL -- NOT NULL ���𰡾�����
    , writer VARCHAR2 (20) NOT NULL -- UNIQUE���� 1����̱ۿ���������
    , content CLOB -- ���� �� ���ڿ������͸� ������ �� �ִ� ������ Ÿ��
    , reg_date DATE DEFAULT SYSDATE -- �ڵ����� ����ð��̵�
    , view_count NUMBER(10) DEFAULT 0 -- ��ȸ�� 0���ͽ���
);

-- ALTER : �����ͺ��̽��� ������ ����

-- PK ���� / �ߺ�������
ALTER TABLE board 
ADD CONSTRAINT pk_board_bno -- ���������� �߰��Ѵ�
PRIMARY KEY (bno);

-- ������ �߰�
INSERT INTO board
    (bno, title, writer, content)
VALUES
    (1, '�ȴ�?', '�ٲٱ��', '�����Ͼ����� ������');
    
INSERT INTO board
    (bno, title, writer)
VALUES
    (2, '���ִ� ����', '����ȣȣ');
    
COMMIT; -- ���������� COMMIT�� ������������ ����� ���̺� �ݿ����� �ʴ´�.



SELECT * FROM board;



-- �������� ����
-- �Խù��� ����� ����
--    1  :  M

-- ��� ���̺� ����
CREATE TABLE REPLY (
    rno NUMBER(10)
    , r_content VARCHAR2(400)
    , r_writer VARCHAR2(40) NOT NULL
    , bno NUMBER(10)
    , CONSTRAINT pk_reply_rno PRIMARY KEY (rno) -- PK ����
);

-- �ܷ�Ű ���� (FORKEIGN KEY) : ���̺� ���� ��ü ���� ����
ALTER TABLE reply
ADD CONSTRAINT fk_reply_bno
FOREIGN KEY (bno)
REFERENCES board (bno);

-- Į�� ����
-- Į�� �߰�
ALTER TABLE reply
ADD (r_reg_date DATE DEFAULT SYSDATE);

SELECT * FROM reply;

-- �÷� ����
ALTER TABLE board
DROP COLUMN view_count;

-- �÷� ����
ALTER TABLE board
MODIFY (title VARCHAR2(500));

SELECT * FROM board;

-- ���̺� ����
DROP TABLE reply; -- ���̺� ����(����) ���� 
TRUNCATE TABLE board; -- ���̺� ����(������) ��ü ���� - �ѹ�Ұ�











