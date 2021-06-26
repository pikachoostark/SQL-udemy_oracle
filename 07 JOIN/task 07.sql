/* 1. Выведите информацию о регионах и количестве сотрудников в каждом регионе. */
SELECT REGION_NAME, COUNT(*)
    FROM EMPLOYEES E
        JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
        JOIN LOCATIONS L ON (D.LOCATION_ID = L.LOCATION_ID)
        JOIN COUNTRIES C ON (L.COUNTRY_ID = C.COUNTRY_ID)
        JOIN REGIONS R ON (C.REGION_ID = R.REGION_ID)
GROUP BY R.REGION_NAME;
/* Абсолютно никакой разницы, кроме подхода к решению */
SELECT R.REGION_NAME, COUNT(EMPLOYEE_ID)
FROM REGIONS R
    JOIN COUNTRIES C ON (R.REGION_ID = C.REGION_ID)
    JOIN LOCATIONS L ON (C.COUNTRY_ID = L.COUNTRY_ID)
    JOIN DEPARTMENTS D ON (L.LOCATION_ID = D.LOCATION_ID)
    JOIN EMPLOYEES E ON (D.DEPARTMENT_ID = E.DEPARTMENT_ID)
GROUP BY R.REGION_NAME;

/* 2. Выведите детальную информацию о каждом сотруднике: имя, фамилию, id департамента, job_id, адрес, название страны, название региона */
SELECT E.FIRST_NAME, E.LAST_NAME, E.DEPARTMENT_ID, E.JOB_ID, L.STREET_ADDRESS, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E
    JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
    JOIN LOCATIONS L ON (D.LOCATION_ID = L.LOCATION_ID)
    JOIN COUNTRIES C ON (L.COUNTRY_ID = C.COUNTRY_ID)
    JOIN REGIONS R ON (C.REGION_ID = R.REGION_ID);

/* 3. Выведите информацию об именах менеджеров, имеющих в подчинении больше 6 сотрудников,
      а также выведите количество сотрудников, которые им подчиняются. */
SELECT MAN.FIRST_NAME, COUNT(*)
FROM EMPLOYEES EMP JOIN EMPLOYEES MAN ON (EMP.MANAGER_ID = MAN.EMPLOYEE_ID)
GROUP BY MAN.FIRST_NAME
HAVING COUNT(*) > 6;
/* Группировка только по имени - наверное правильнее;
   Идея с ALIAS-ами EMP и MAN, чтобы показать, что в одной таблице мы берём работников,
        а в другом - менеджеров - крутая;
   Сортировка не требовалась, это я уже не выдержал.
   В основном - суть одна. */
SELECT E1.MANAGER_ID, E2.FIRST_NAME, COUNT(*)
    FROM EMPLOYEES E1
    JOIN EMPLOYEES E2 ON (E1.MANAGER_ID = E2.EMPLOYEE_ID)
GROUP BY E2.FIRST_NAME, E1.MANAGER_ID
HAVING COUNT(*) > 6
ORDER BY MANAGER_ID, COUNT(*);

/* 4. Выведите информацию о названии всех департаментов и о количестве работников, если 
      в департаменте работает более чем 30 сотрудников. 
      Используйте USING для обьединения по id департамента. */
SELECT D.DEPARTMENT_NAME, COUNT(*)
FROM EMPLOYEES E
JOIN DEPARTMENTS D USING (DEPARTMENT_ID)
GROUP BY D.DEPARTMENT_NAME
HAVING COUNT(*) > 30;

/* 5. Выведите названия всех департаментов, в которых нет ни одного сотрудника. */
SELECT D.DEPARTMENT_NAME
FROM EMPLOYEES E
RIGHT JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
WHERE E.EMPLOYEE_ID IS NULL;

/* 6. Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в 2005 году, 
      но при этом сами работники устроились на работу раньше 2005 года. */
/* Вывод SELECT LIST-а в данном решении необычный. Стоит запомнить.
   Решение верно, вывод отсутствует, так как таблица у преподавателя содержит 
   другие года в EMPLOYEES.HIRE_DATE */
SELECT EMP.*
FROM EMPLOYEES EMP
JOIN EMPLOYEES MAN ON (EMP.MANAGER_ID = MAN.EMPLOYEE_ID)
WHERE (TO_CHAR(MAN.HIRE_DATE, 'YYYY') = '2005')
      AND
      (EMP.HIRE_DATE < TO_DATE('01.01.2005', 'DD.MM.YYYY'));
      
/* 7. Выведите название страны и название региона этой страны, используя 
      NATURAL JOINING. */
SELECT COUNTRY_NAME, REGION_NAME
FROM COUNTRIES 
NATURAL JOIN REGIONS;

/* 8. Выведите имена, фамилии и зарплаты сотрудников, которые получают меньше, 
      чем минимальная зарплата по их специальности + 1000. */
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES E
JOIN JOBS J ON (E.JOB_ID = J.JOB_ID AND SALARY < MIN_SALARY + 1000);
/* В решении условие с зарплатой вводится прямо в условие обсединения, а мне
   кажется, что так менее красиво. Тут, думаю, дело вкуса, большой разницы нет. */
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES E
JOIN JOBS J ON (E.JOB_ID = J.JOB_ID)
WHERE SALARY < (MIN_SALARY + 1000);

/* 9. Выведите уникальные имена и фамилии сотрудников, названия стран, в которых
      они работают. 
      Также выведите информацию о сотрудниках, о странах которых нет информации. 
      А также выведите все страны, в которых нет сотрудников компании. */
/* Только на этой задаче заметил, я использую LEFT, RIGHT, FULL JOINING без 
   слова OUTER и output не изменяется. */
SELECT DISTINCT FIRST_NAME, LAST_NAME, COUNTRY_NAME
FROM EMPLOYEES E
    FULL JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
    FULL JOIN LOCATIONS L   ON (D.LOCATION_ID = L.LOCATION_ID)
    FULL JOIN COUNTRIES C   ON (L.COUNTRY_ID = C.COUNTRY_ID);

/* 10. Выведите имена и фамилии всех сотрудников, а также названия стран,
       которые мы получаем при обьединении работников со всеми странами
       без какой-либо логики. */
SELECT FIRST_NAME, LAST_NAME, COUNTRY_NAME
FROM EMPLOYEES 
CROSS JOIN COUNTRIES;

/* 11. Решите задачу №1, используя Oracle Join Syntax.
       (Выведите информацию о регионах и количестве сотрудников в каждом регионе.) */
SELECT R.REGION_NAME, COUNT(*)
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE (E.DEPARTMENT_ID = D.DEPARTMENT_ID) AND
      (D.LOCATION_ID = L.LOCATION_ID) AND
      (L.COUNTRY_ID = C.COUNTRY_ID) AND
      (C.REGION_ID = R.REGION_ID)
GROUP BY R.REGION_NAME;

/* 12. Решите задачу №5, используя Oracle Join Syntax.
       (Выведите названия всех департаментов, в которых нет ни одного сотрудника.) */
SELECT D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE (E.DEPARTMENT_ID (+) = D.DEPARTMENT_ID) AND E.EMPLOYEE_ID IS NULL;