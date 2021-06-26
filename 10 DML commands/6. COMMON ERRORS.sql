-- Common errors that occur when using commands:
-- 1. Syntax errors:
SELECT * FROM EMPLOYEES
WHEER EMPLOYEE_ID = 200; -- ������������ ��������� ���������;
-- ORA-00933: SQL COMMAND NOT PROPERLY ENDED
-- ORA-00933: SQL-������� �� ��������� ������� �������

SELECT * FROM EMPLOYEES
WHERE HIRE_DATE = '05-06-18';
-- ORA-01843: NOT A VALID MONTH
-- ORA-01843: ������������ �����
/* �� ������ �������� ������ ������:
        > �������������� ������, ������ ������ �����, ��� 06;
        > ���� ���� �� ���� �����, ������ �������� �������� �� ��������� NLS ����������;
        > ��������� �� �������������� �����������, �� ����� �� ����������� ������, ������������� �� HIRE_DATE => �������� ���������; */

INSERT INTO EMPL VALUES(5, 6);                -- ����� ������� �� ����������;
-- ORA-00942: TABLE OR VIEW DOES NOT EXIST
-- ORA-00942: ������� ��� ������������� �� ����������
INSERT INTO COUNTRIES (REGION_IP) VALUES (5); -- ������ ������� �� ����������;
-- ORA-00904: "REGION_IP": INVALID IDENTIFIER
-- ORA-00904: "REGION_IP": ���������������� �������������
INSERT INTO COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
VALUES ('DEWFW', 'FEFWA', 1);  
/* ������ ���� �� ��� �������.
   ������, ���� ���� ��� �������� ������ � �������� �������� �����, 
   Oracle ����� ������ ������: "������ ������� �� ����������."
    -> ��� ����� �������� �����, ��� � ��� ��� ���� ������� � ���� �������. */
/* � ������ ������� ����: ����� ����, ��� � ��� ���� ����� �� SELECT, �� ���
   ����� �� ��������� ����������. ����� ���� ��� ���������� ��������� �����
   ������������ ������ "������ ������� �� ����������." */
   
INSERT INTO COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
VALUES ('AC', 'ABRACADABRA', 5);
-- ERROR REPORT - ORA-02291: INTEGRITY CONSTRAINT (HR.COUNTR_RE_FK) VIOLATED - PARENT KEY NOT FOUND 
-- ��ר� �� ������ - ORA-02291: ����������� ����������� (HR.COUNTRY_RE_FK) �������� - �� ������ ������������ ����
