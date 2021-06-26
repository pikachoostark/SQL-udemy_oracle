SELECT * FROM EMPLOYEES
WHERE INSTR(UPPER(FIRST_NAME), 'B', 1, 1) != 0;

SELECT * FROM EMPLOYEES
WHERE INSTR(UPPER(FIRST_NAME), 'A', 1, 2) != 0;

SELECT SUBSTR(DEPARTMENT_NAME, 1, INSTR(DEPARTMENT_NAME, ' ') - 1)
FROM DEPARTMENTS WHERE INSTR(DEPARTMENT_NAME, ' ') != 0;

SELECT SUBSTR(FIRST_NAME, 2, LENGTH(FIRST_NAME) - 2)
FROM EMPLOYEES;

/* В решении вместо цифр 4 стоит INSTR(JOB_ID, '_') + 1, что, пожалуй, грамотнее */
SELECT * FROM EMPLOYEES
WHERE SUBSTR(JOB_ID, 4) != 'CLERK' AND LENGTH(SUBSTR(JOB_ID, 4)) >= 3;

SELECT * FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'DD') = '01';

SELECT * FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2008';

SELECT TO_CHAR(SYSDATE + 1, '"Tomorrow is" DdTHSP "day of" Month') FROM DUAL;

/* Забавно. В решении модификатор fm стоит перед dd и это тоже верно, но два 
таких модификатора уже ломают output. */
SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'ddth "of" fmMonth"," YYYY') 
FROM EMPLOYEES;

/* В решении не нравится всё:
        SALARY + SALARY * 0.20 вместо SALARY * 1.2; (ладно, курс также для тех, кто плох в математике;
        '$999,999.00' вместо 'fm$99,999.00 (зачем ещё одна 9? ладно fm не просили.) */
SELECT FIRST_NAME, TO_CHAR(SALARY*1.2, 'fm$99,999.00') FROM EMPLOYEES;

SELECT SYSDATE                      NOW,
       SYSDATE + 1 / (24 * 60 * 60) PLUS_SEC,
       SYSDATE + 1 / (24 * 60)      PLUS_MIN,
       SYSDATE + 1 / 24             PLUS_HOUR,
       SYSDATE + 1                  PLUS_DAY,
       ADD_MONTHS(SYSDATE, 1)       PLUS_MON,
       ADD_MONTHS(SYSDATE, 12)      PLUS_YEAR
FROM DUAL;
/* Без комментариев. */
SELECT TO_CHAR(SYSDATE,'DD-MM-RR HH24:MI:SS')                                                                                                                           AS CUR_DATE,
       SUBSTR(TO_CHAR(SYSDATE, 'DD-MM-RR HH24:MI:SS'), 1, 15) || TO_CHAR(MOD((TO_NUMBER(TO_CHAR(SYSDATE, 'SS')) + 1), 60), 'fm09')                                      AS PLUS_SEC,
       SUBSTR(TO_CHAR(SYSDATE, 'DD-MM-RR HH24:MI:SS'), 1, 12) || TO_CHAR(MOD((TO_NUMBER(TO_CHAR(SYSDATE, 'MI')) + 1), 60), 'fm09') || ':' || TO_CHAR(SYSDATE, 'SS')     AS PLUS_MIN,
       SUBSTR(TO_CHAR(SYSDATE, 'DD-MM-RR HH24:MI:SS'), 1, 9) || TO_CHAR(MOD((TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) + 1), 24), 'fm09') || TO_CHAR(SYSDATE, '":"MI":"SS')   AS PLUS_HOUR,
       TO_CHAR(SYSDATE + 1, 'DD-MM-RR HH24:MI:SS')                                                                                                                      AS PLUS_DAY,
       TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'DD-MM-RR HH24:MI:SS')                                                                                                           AS PLUS_MON,
       TO_CHAR(ADD_MONTHS(SYSDATE, 12), 'DD-MM-RR HH24:MI:SS')                                                                                                          AS PLUS_YEAR
FROM DUAL;

SELECT FIRST_NAME, SALARY, SALARY+TO_NUMBER('$12,345.55', '$99,999.99') NEW_SALARY FROM EMPLOYEES;

SELECT FIRST_NAME, HIRE_DATE, 
       MONTHS_BETWEEN(TO_DATE('SEP, 18:45:00 18 2009', 'MON, HH24:MI:SS DD YYYY'), HIRE_DATE) AS MON_BETWEEN
FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY, TO_CHAR((SALARY * (1 + NVL(COMMISSION_PCT, 0))), '$99,999.00') AS FULL_SALARY
FROM EMPLOYEES;

SELECT FIRST_NAME, LAST_NAME, 
       NVL2(NULLIF(LENGTH(FIRST_NAME), LENGTH(LAST_NAME)), 
            'different length', 'same length') COMPARISON
FROM EMPLOYEES;

SELECT FIRST_NAME, COMMISSION_PCT, NVL2(COMMISSION_PCT, 'Yes', 'No') BONUSES
FROM EMPLOYEES;

SELECT FIRST_NAME, COALESCE(COMMISSION_PCT, MANAGER_ID, SALARY)
FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY, 
CASE
WHEN SALARY < 5000 THEN 'Low level'
WHEN SALARY < 10000 THEN 'Normal level'
ELSE 'High level'
END SALARY_LEVEL
FROM EMPLOYEES;

SELECT COUNTRY_NAME, 
DECODE(REGION_ID, 1, 'Europe',
                  2, 'Americas',
                  3, 'Asia',
                  4, 'Middle East and Africa') AS REGION_NAME
FROM COUNTRIES;

SELECT COUNTRY_NAME,
CASE REGION_ID
WHEN 1 THEN 'Europe'
WHEN 2 THEN 'Americas'
WHEN 3 THEN 'Asia'
WHEN 4 THEN 'Middle East and Africa'
END AS REGION_NAME
FROM COUNTRIES;

SELECT FIRST_NAME,
CASE
WHEN SALARY < 10000 AND COMMISSION_PCT IS NULL THEN 'BAD'
WHEN (SALARY BETWEEN 10000 AND 15000) OR COMMISSION_PCT IS NOT NULL THEN 'NORMAL'
WHEN SALARY >= 15000 THEN 'GOOD'
END AS LIFE_CONDITIONS
FROM EMPLOYEES;