

-- # ������ ��������
-- ���������� ��ȸ ����� 1�� ������ ���

-- �μ��ڵ尡 100004���� �μ��� ������� ��ȸ

SELECT 
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
;

-- ����̸��� �̳����� ����� ���� �ִ� �μ��� ������� ��ȸ / ������ ��������
SELECT 
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '�̳���')
;

-- ����̸��� �̰����� ����� ���� �ִ� �μ��� ������� ��ȸ
-- ������ �񱳿�����(=, <>, >, >=, <, <=)�� ������ ���������� ���ؾ� ��.
SELECT 
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '�̰���') -- ���� 1�����;���
;

-- 20200525�� ���� �޿��� ȸ����ü�� 20200525��
-- ��ü ��� �޿����� ���� ������� ����(���, �̸�, �޿�������, �����޿��׼�) ��ȸ
SELECT
    A.emp_no, A.emp_nm, B.pay_de, B.pay_amt
FROM tb_emp A
JOIN tb_sal_his B -- join�ϸ� ���ο� ���̺��� ����
ON A.emp_no = B.emp_no
WHERE B.pay_de = '20200525' -- and�� �ΰ����� ��� �����ؾ߉´�
    AND B.pay_amt >= ( -- �񿬰� ���� ���� / ���������� A,�� B�� �����������ʾƼ�
                        SELECT AVG(pay_amt)
                        FROM tb_sal_his
                        WHERE pay_de = '20200525'
                     )
ORDER BY A.emp_no, B.pay_de
;

-- ȸ�� ��ü 20200525 �޿����
SELECT AVG(pay_amt)
FROM tb_sal_his
WHERE pay_de = '20200525'
;


-- # ������ ��������
-- ���������� ��ȸ �Ǽ��� 0�� �̻��� ��
-- ## ������ ������
-- 1. IN : ���������� �������� �������� ����߿� �ϳ��� ��ġ�ϸ� ��
--    ex )  salary IN (200, 300, 400)
--            250 ->  200, 300, 400 �߿� �����Ƿ� false
-- 2. ANY, SOME : ���������� �������� ���������� �˻���� �� �ϳ� �̻� ��ġ�ϸ� ��
--    ex )  salary > ANY (200, 300, 400)
--            250 ->  200���� ũ�Ƿ� true
-- 3. ALL : ���������� �������� ���������� �˻������ ��� ��ġ�ϸ� ��
--    ex )  salary > ALL (200, 300, 400)
--            250 ->  200���ٴ� ũ���� 300, 400���ٴ� ũ�� �����Ƿ� false
-- 4. EXISTS : ���������� �������� ���������� ��� �� �����ϴ� ���� �ϳ��� �����ϸ� ��


-- �ѱ������ͺ��̽���������� �߱��� �ڰ����� ������ �ִ�
-- ����� �����ȣ�� ����̸��� �ش� ����� �ѱ������ͺ��̽���������� 
-- �߱��� �ڰ��� ������ ��ȸ

SELECT certi_cd 
FROM tb_certi 
WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
;
-- IN
SELECT 
    A.emp_no, A.emp_nm, COUNT(B.certi_cd) "�ڰ��� ����"
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
WHERE B.certi_cd IN ( -- IN�տ��ִ°Ͱ� ()�ȿ��ִ°��� �� �ϳ��� ��ġ�ϸ� ��
                        SELECT C.certi_cd 
                        FROM tb_certi C -- B�ϰ�  C�ϰ����
                        WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
                    )
GROUP BY A.emp_no, A.emp_nm
ORDER BY A.emp_no
;
-- ANY
SELECT 
    A.emp_no, A.emp_nm, COUNT(B.certi_cd) "�ڰ��� ����"
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
WHERE B.certi_cd = ANY ( -- ���������� �������� ���������� �˻���� �� �ϳ� �̻� ��ġ�ϸ� ��
                        SELECT certi_cd 
                        FROM tb_certi 
                        WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
                    )
GROUP BY A.emp_no, A.emp_nm
ORDER BY A.emp_no
;

-- EXISTS�� : ���������� �������� ���������� ��� �� �����ϴ� ���� �ϳ��� �����ϸ� ��
-- �ּҰ� ������ �������� �ٹ��ϰ� �ִ� �μ������� ��ȸ (�μ��ڵ�, �μ���)
SELECT emp_no, emp_nm, addr, dept_cd 
FROM tb_emp 
WHERE addr LIKE '%����%'
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
                    WHERE addr LIKE '%����%'
                )
;

SELECT 
    1
FROM tb_emp
WHERE addr LIKE '%����%'
;


SELECT A.dept_cd, A.dept_nm
FROM tb_dept A
WHERE EXISTS ( -- ����� ���� 1���� ������ true
                    SELECT 1 -- ���� ���⿡�� �ƹ��Ÿ����� ���̸�Ŵϱ�
                    FROM tb_emp  B
                    WHERE addr LIKE '%����%' -- �� �������� �����ϴ°� �ٽ�
                        AND A.dept_cd = B.dept_cd   
                )
;

-- # ���� Į�� ��������
--  : ���������� ��ȸ �÷��� 2�� �̻��� ��������

-- �μ����� 2�� �̻��� �μ� �߿��� �� �μ��� 
-- ���� �������� �纯�� �̸� ������ϰ� �μ��ڵ带 ��ȸ

SELECT 
    A.emp_no, A.emp_nm, A.birth_de, A.dept_cd, B.dept_nm
FROM tb_emp A                       
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
WHERE (A.dept_cd, A.birth_de) IN (
                        SELECT
                            dept_cd, MIN(birth_de) -- where���� �÷�2�� ���⵵ �÷�2��
                        FROM tb_emp
                        GROUP BY dept_cd
                        HAVING COUNT(*) >= 2
                    ) 
ORDER BY A.emp_no
;


-- �ζ��� �� �������� (FROM���� ���� ��������)

-- �� ����� �纯�� �̸��� ��� �޿������� ��ȸ�ϰ� �ʹ�./ �׷�ȭ�ؼ� ���̰� �����Ѵ�
SELECT
    A.emp_no, A.emp_nm, B.pay_avg
FROM tb_emp A, ( -- ����� �޿����������������� ����Ǽ���ŭ�� ��ȸ�Ѵ�
                SELECT
                    emp_no, AVG(pay_amt) AS pay_avg -- emp_no���־�� where�Ҽ�����
                FROM tb_sal_his
                GROUP BY emp_no
                    ) B
WHERE A.emp_no = B.emp_no
ORDER BY A.emp_no
;


-- ��Į�� �������� (SELECT���� ���� ��������)

-- ����� ���, �����, �μ���, �������, �����ڵ带 ��ȸ
SELECT 
    A.emp_no
    , A.emp_nm
    , (SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm
    , A.birth_de
    , A.sex_cd
FROM tb_emp A
;


