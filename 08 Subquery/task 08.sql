SELECT * FROM EMPLOYEES 
WHERE LENGTH(FIRST_NAME) = (SELECT MAX((LENGTH(FIRST_NAME))) FROM EMPLOYEES);

SELECT * FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT L.CITY FROM EMPLOYEES E
    JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
    JOIN LOCATIONS L   ON (D.LOCATION_ID = L.LOCATION_ID)
GROUP BY L.CITY
HAVING SUM(SALARY) = 
                    (SELECT MIN(SUM(SALARY)) FROM EMPLOYEES E
                        JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
                        JOIN LOCATIONS L   ON (D.LOCATION_ID = L.LOCATION_ID)
                    GROUP BY L.CITY);

SELECT * 
FROM EMPLOYEES WHERE MANAGER_ID IN
                    (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE SALARY > 15000);

SELECT DEPARTMENT_NAME
FROM DEPARTMENTS WHERE DEPARTMENT_ID NOT IN (SELECT DISTINCT DEPARTMENT_ID 
                                             FROM EMPLOYEES
                                             WHERE DEPARTMENT_ID IS NOT NULL);

SELECT *
FROM EMPLOYEES WHERE EMPLOYEE_ID NOT IN (SELECT DISTINCT MANAGER_ID
                                         FROM EMPLOYEES
                                         WHERE MANAGER_ID IS NOT NULL);

SELECT *
FROM EMPLOYEES E
WHERE (SELECT COUNT(*) FROM EMPLOYEES
       WHERE MANAGER_ID = E.EMPLOYEE_ID) > 6;
/* Честно говоря, может я слишком устал, но я не понял всей гениальности
   решения. Скорее вего тут не так важно каким способом решать. 
   p.s. Ладно, суть уловил. Берём какого-то employee_id, кидаем его значение в 
        subquery, чтобы посчитать, больше ли у него подчинённых, чем 6. 
        Если больше, то выводим всю информацию.
        Correlated subquery в чистом виде.*/
SELECT * 
FROM EMPLOYEES 
WHERE EMPLOYEE_ID IN (SELECT MANAGER_ID FROM EMPLOYEES
                     GROUP BY MANAGER_ID HAVING COUNT(*) > 6);

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS 
                       WHERE DEPARTMENT_NAME = 'IT');

SELECT *
FROM EMPLOYEES
WHERE (HIRE_DATE < TO_DATE('01.01.2005', 'DD.MM.YYYY'))
      AND
      (MANAGER_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES
                      WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2005'));
SELECT *
FROM EMPLOYEES E
WHERE MANAGER_ID IN (SELECT EMPLOYEE_ID
                     FROM EMPLOYEES
                     WHERE TO_CHAR(HIRE_DATE, 'MM') = '01')
      AND (SELECT LENGTH(JOB_TITLE)
           FROM JOBS
           WHERE JOB_ID = E.JOB_ID) > 15;
/* Опять этот грёбанный correlated subquery. Нужно будет попробовать порешать
   задачи, специально пытаясь применить correlatied subqueries, чтобы их видеть
   научиться. А то пока что не воспринимаю их, пока носом не тыкнут. */
SELECT *
FROM EMPLOYEES
WHERE (JOB_ID IN (SELECT JOB_ID FROM JOBS
                  WHERE LENGTH(JOB_TITLE) > 15))
      AND
      (MANAGER_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES
                      WHERE TO_CHAR(HIRE_DATE, 'MON') = 'JAN'));