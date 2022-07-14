CREATE TABLE score (
    stu_num NUMBER(10),
    stu_name VARCHAR2(20) NOT NULL,
    kor NUMBER(3) NOT NULL,
    eng NUMBER(3) NOT NULL,
    math NUMBER(3) NOT NULL,
    total NUMBER(3),
    average NUMBER(5,2),
    CONSTRAINT pk_score PRIMARY KEY (stu_num)
);

-- ���ӵ� ���� ���� // 1���� 1�� ����
CREATE SEQUENCE seq_score;

SELECT * FROM score; -- commit�� �ؾ��Ѵ�

INSERT INTO score VALUES (seq_score.nextval,  'ȫ�浿', 90, 90, 90, 270, 90);
INSERT INTO score VALUES (seq_score.nextval,  '��ö��', 80, 80, 80, 240, 80);
INSERT INTO score VALUES (seq_score.nextval,  '�ڿ���', 100, 100, 100, 300, 100);
COMMIT;

SELECT AVG(average) AS avg_cls
FROM score;
-----------------------------------------------------------------
DROP TABLE bmi;

CREATE TABLE bmi (
    per_num NUMBER(10),
    per_name VARCHAR2(10) NOT NULL, -- NOT NULL�� �ϸ� �����͸� �����ǳ־����
    height NUMBER(4,1) NOT NULL, -- �� 4�ڸ� �Ҽ��� 1�ڸ�
    weight NUMBER(4,1) NOT NULL,
    bmi NUMBER(3,1),
    min NUMBER(3,1),
    max NUMBER(3,1),
    result VARCHAR2(10),
    target NUMBER(4,1),
    CONSTRAINT pk_bmi PRIMARY KEY (per_num)
);

CREATE SEQUENCE seq_bmi;

DROP SEQUENCE seq_bmi;

SELECT * FROM bmi;

INSERT INTO bmi VALUES (seq_bmi.nextval, 'ȫ�浿', 175, 60, 19.5, 56.7, 70.4,'����', 0);

COMMIT;




