

-- WHERE ������ : ��ȸ ��� ���� �����ϴ� ������
SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE sex_cd = 2 -- = �� ���ٶ�� ������ �����ϰڵ��� ���� �ƴϴ�
;

-- PK�� WHERE�� ���������� ����� �ݵ�� �������� ��ȸ�ȴ�./ PK�� 1���ۿ��ȵŴϱ�
SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE emp_no = 1000000003
;

-- �� ������
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de >= '19900101'
    AND birth_de <= '19991231'
;

-- BETWEEN ������ / �ٷ� ���� ����
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de BETWEEN '19900101' AND '19991231'
;

-- OR ���� / 100004�ξֿ� 100006�ξ� �Ѵ� ��� AND�� �Ѵٸ����ؾ����
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
    or dept_cd = '100006'
;

-- IN ������
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd IN ('100004', '100006') -- or �Ǵ� �� ��
;

-- NOT IN ������
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd NOT IN ('100004', '100006') -- 100004,100006 �ѻ���������
;

-- LIKE ������
-- �˻��� ���
-- ���ϵ� ī�� ���� (% : 0���� �̻�, _ : �� 1���ڸ�;
SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm like '��%' -- '��_' �̸��� 2�����λ�� '��__' �̸��� 3�����λ��
;

SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm like '%��' -- �����ڸ� ���̾�߸���
;

SELECT
    emp_no, emp_nm, addr
FROM tb_emp
WHERE addr like '%����%'
;

-- ������ �达�̸鼭, �μ��� 100003, 100004, 100006�� �߿� �ϳ��̸鼭, 
-- 90������ ����� ���, �̸�, ����, �μ��ڵ带 ��ȸ

SELECT
    emp_no, dept_cd, birth_de, emp_nm
FROM tb_emp
WHERE 1=1
    AND emp_nm LIKE '��%'
    AND dept_cd IN ('100003', '100004', '100006')
    AND birth_de BETWEEN '19900101' AND '19991231'
;

-- ���� ��ġ �� ������
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

-- �����ڵ尡 1�� �ƴϸ鼭 ������ �̾��� �ƴ� �������
-- �纯, �̸�,�����ڵ带 ��ȸ�ϼ���.

SELECT
    emp_no, emp_nm, sex_cd
FROM tb_emp
WHERE 1=1
    AND sex_cd <> 1 
    AND emp_nm <> '��%'
;

-- null�� ��ȸ : �ݵ�� IS NULL �����ڷ� ��ȸ
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NULL
;

SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT NULL -- not is null�̾ƴ� is not null
;

-- ������ �켱���� : NOT > AND > OR
-- ������� �߿� �达�̸鼭 ���� �Ǵ� �ϻ꿡 ��� ������� ����
SELECT
    emp_no, emp_nm, addr
FROM tb_emp
WHERE 1=1
    AND emp_nm like '��%'
    AND (addr like '%����%' or addr like '%�ϻ�%') -- ()������ �达�鼭 ������¾� �׸��� �׳� �ϻ��¾�
;














