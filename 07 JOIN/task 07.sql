/* 1. �������� ���������� � �������� � ���������� ����������� � ������ �������. */
SELECT REGION_NAME, COUNT(*)
    FROM EMPLOYEES E
        JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
        JOIN LOCATIONS L ON (D.LOCATION_ID = L.LOCATION_ID)
        JOIN COUNTRIES C ON (L.COUNTRY_ID = C.COUNTRY_ID)
        JOIN REGIONS R ON (C.REGION_ID = R.REGION_ID)
GROUP BY R.REGION_NAME;
/* ��������� ������� �������, ����� ������� � ������� */
SELECT R.REGION_NAME, COUNT(EMPLOYEE_ID)
FROM REGIONS R
    JOIN COUNTRIES C ON (R.REGION_ID = C.REGION_ID)
    JOIN LOCATIONS L ON (C.COUNTRY_ID = L.COUNTRY_ID)
    JOIN DEPARTMENTS D ON (L.LOCATION_ID = D.LOCATION_ID)
    JOIN EMPLOYEES E ON (D.DEPARTMENT_ID = E.DEPARTMENT_ID)
GROUP BY R.REGION_NAME;

/* 2. �������� ��������� ���������� � ������ ����������: ���, �������, id ������������, job_id, �����, �������� ������, �������� ������� */
SELECT E.FIRST_NAME, E.LAST_NAME, E.DEPARTMENT_ID, E.JOB_ID, L.STREET_ADDRESS, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E
    JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
    JOIN LOCATIONS L ON (D.LOCATION_ID = L.LOCATION_ID)
    JOIN COUNTRIES C ON (L.COUNTRY_ID = C.COUNTRY_ID)
    JOIN REGIONS R ON (C.REGION_ID = R.REGION_ID);

/* 3. �������� ���������� �� ������ ����������, ������� � ���������� ������ 6 �����������,
      � ����� �������� ���������� �����������, ������� �� �����������. */
SELECT MAN.FIRST_NAME, COUNT(*)
FROM EMPLOYEES EMP JOIN EMPLOYEES MAN ON (EMP.MANAGER_ID = MAN.EMPLOYEE_ID)
GROUP BY MAN.FIRST_NAME
HAVING COUNT(*) > 6;
/* ����������� ������ �� ����� - �������� ����������;
   ���� � ALIAS-��� EMP � MAN, ����� ��������, ��� � ����� ������� �� ���� ����������,
        � � ������ - ���������� - ������;
   ���������� �� �����������, ��� � ��� �� ��������.
   � �������� - ���� ����. */
SELECT E1.MANAGER_ID, E2.FIRST_NAME, COUNT(*)
    FROM EMPLOYEES E1
    JOIN EMPLOYEES E2 ON (E1.MANAGER_ID = E2.EMPLOYEE_ID)
GROUP BY E2.FIRST_NAME, E1.MANAGER_ID
HAVING COUNT(*) > 6
ORDER BY MANAGER_ID, COUNT(*);

/* 4. �������� ���������� � �������� ���� ������������� � � ���������� ����������, ���� 
      � ������������ �������� ����� ��� 30 �����������. 
      ����������� USING ��� ����������� �� id ������������. */
SELECT D.DEPARTMENT_NAME, COUNT(*)
FROM EMPLOYEES E
JOIN DEPARTMENTS D USING (DEPARTMENT_ID)
GROUP BY D.DEPARTMENT_NAME
HAVING COUNT(*) > 30;

/* 5. �������� �������� ���� �������������, � ������� ��� �� ������ ����������. */
SELECT D.DEPARTMENT_NAME
FROM EMPLOYEES E
RIGHT JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
WHERE E.EMPLOYEE_ID IS NULL;

/* 6. �������� ��� ���������� � �����������, ��������� ������� ���������� �� ������ � 2005 ����, 
      �� ��� ���� ���� ��������� ���������� �� ������ ������ 2005 ����. */
/* ����� SELECT LIST-� � ������ ������� ���������. ����� ���������.
   ������� �����, ����� �����������, ��� ��� ������� � ������������� �������� 
   ������ ���� � EMPLOYEES.HIRE_DATE */
SELECT EMP.*
FROM EMPLOYEES EMP
JOIN EMPLOYEES MAN ON (EMP.MANAGER_ID = MAN.EMPLOYEE_ID)
WHERE (TO_CHAR(MAN.HIRE_DATE, 'YYYY') = '2005')
      AND
      (EMP.HIRE_DATE < TO_DATE('01.01.2005', 'DD.MM.YYYY'));
      
/* 7. �������� �������� ������ � �������� ������� ���� ������, ��������� 
      NATURAL JOINING. */
SELECT COUNTRY_NAME, REGION_NAME
FROM COUNTRIES 
NATURAL JOIN REGIONS;

/* 8. �������� �����, ������� � �������� �����������, ������� �������� ������, 
      ��� ����������� �������� �� �� ������������� + 1000. */
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES E
JOIN JOBS J ON (E.JOB_ID = J.JOB_ID AND SALARY < MIN_SALARY + 1000);
/* � ������� ������� � ��������� �������� ����� � ������� �����������, � ���
   �������, ��� ��� ����� �������. ���, �����, ���� �����, ������� ������� ���. */
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES E
JOIN JOBS J ON (E.JOB_ID = J.JOB_ID)
WHERE SALARY < (MIN_SALARY + 1000);

/* 9. �������� ���������� ����� � ������� �����������, �������� �����, � �������
      ��� ��������. 
      ����� �������� ���������� � �����������, � ������� ������� ��� ����������. 
      � ����� �������� ��� ������, � ������� ��� ����������� ��������. */
/* ������ �� ���� ������ �������, � ��������� LEFT, RIGHT, FULL JOINING ��� 
   ����� OUTER � output �� ����������. */
SELECT DISTINCT FIRST_NAME, LAST_NAME, COUNTRY_NAME
FROM EMPLOYEES E
    FULL JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
    FULL JOIN LOCATIONS L   ON (D.LOCATION_ID = L.LOCATION_ID)
    FULL JOIN COUNTRIES C   ON (L.COUNTRY_ID = C.COUNTRY_ID);

/* 10. �������� ����� � ������� ���� �����������, � ����� �������� �����,
       ������� �� �������� ��� ����������� ���������� �� ����� ��������
       ��� �����-���� ������. */
SELECT FIRST_NAME, LAST_NAME, COUNTRY_NAME
FROM EMPLOYEES 
CROSS JOIN COUNTRIES;

/* 11. ������ ������ �1, ��������� Oracle Join Syntax.
       (�������� ���������� � �������� � ���������� ����������� � ������ �������.) */
SELECT R.REGION_NAME, COUNT(*)
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE (E.DEPARTMENT_ID = D.DEPARTMENT_ID) AND
      (D.LOCATION_ID = L.LOCATION_ID) AND
      (L.COUNTRY_ID = C.COUNTRY_ID) AND
      (C.REGION_ID = R.REGION_ID)
GROUP BY R.REGION_NAME;

/* 12. ������ ������ �5, ��������� Oracle Join Syntax.
       (�������� �������� ���� �������������, � ������� ��� �� ������ ����������.) */
SELECT D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE (E.DEPARTMENT_ID (+) = D.DEPARTMENT_ID) AND E.EMPLOYEE_ID IS NULL;