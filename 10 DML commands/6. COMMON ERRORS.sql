-- Common errors that occur when using commands:
-- 1. Syntax errors:
SELECT * FROM EMPLOYEES
WHEER EMPLOYEE_ID = 200; -- неправильное написание оператора;
-- ORA-00933: SQL COMMAND NOT PROPERLY ENDED
-- ORA-00933: SQL-КОМАНДА НЕ ЗАВЕРШЕНА ДОЛЖНЫМ ОБРАЗОМ

SELECT * FROM EMPLOYEES
WHERE HIRE_DATE = '05-06-18';
-- ORA-01843: NOT A VALID MONTH
-- ORA-01843: НЕДОПУСТИМЫЙ МЕСЯЦ
/* По многим причинам плохая запись:
        > Синтаксическая ошибка, нельзя писать месяц, как 06;
        > Даже если бы было верно, скрипт начинает зависеть от изменения NLS параметров;
        > Полагаясь на автоматическую конвертацию, мы также не задействуем индекс, установленный на HIRE_DATE => работает медленнее; */

INSERT INTO EMPL VALUES(5, 6);                -- такой таблицы не существует;
-- ORA-00942: TABLE OR VIEW DOES NOT EXIST
-- ORA-00942: ТАБЛИЦА ИЛИ ПРЕДСТАВЛЕНИЕ НЕ СУЩЕСТВУЕТ
INSERT INTO COUNTRIES (REGION_IP) VALUES (5); -- такого столбца не существует;
-- ORA-00904: "REGION_IP": INVALID IDENTIFIER
-- ORA-00904: "REGION_IP": НЕДЕЙСТВИТЕЛЬНЫЙ ИДЕНТИФИКАТОР
INSERT INTO COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
VALUES ('DEWFW', 'FEFWA', 1);  
/* Пример выше не для запуска.
   Иногда, даже если все названия таблиц и столбцов написаны верно, 
   Oracle может выдать ошибку: "Данной таблицы не существует."
    -> Это может означать также, что у Вас нет прав доступа к этой таблице. */
/* В случае примера выше: может быть, что у Вас есть право на SELECT, но нет
   права на изменение информации. Тогда даже при правильном написании будет
   возвращаться ошибка "Данной таблицы не существует." */
   
INSERT INTO COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
VALUES ('AC', 'ABRACADABRA', 5);
-- ERROR REPORT - ORA-02291: INTEGRITY CONSTRAINT (HR.COUNTR_RE_FK) VIOLATED - PARENT KEY NOT FOUND 
-- ОТЧЁТ ОБ ОШИБКЕ - ORA-02291: ОГРАНИЧЕНИЕ ЦЕЛОСТНОСТИ (HR.COUNTRY_RE_FK) НАРУШЕНО - НЕ НАЙДЕН РОДИТЕЛЬСКИЙ КЛЮЧ
