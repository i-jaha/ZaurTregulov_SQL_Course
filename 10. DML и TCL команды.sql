-- 1. Перепишите и запустите данный statemenet для создания таблицы locations2, которая будет содержать такие же столбцы, что и locations:


CREATE TABLE locations2 AS (SELECT * FROM HR.LOCATIONS WHERE 1=2);


-- 2. Добавьте в таблицу locations2 2 строки с информацией о id локации, адресе, городе, id страны. Пусть данные строки относятся к стране Италия.


INSERT INTO locations2 (LOCATION_ID, STREET_ADDRESS, CITY, COUNTRY_ID)
SELECT LOCATION_ID, STREET_ADDRESS, CITY, COUNTRY_ID
FROM HR.LOCATIONS
WHERE COUNTRY_ID IN (
    SELECT COUNTRY_ID 
    FROM HR.COUNTRIES 
    WHERE COUNTRY_NAME LIKE '%Italy%'
);

SELECT *
FROM locations2;


-- 3. Совершите commit.


COMMIT;


-- 4. Добавьте в таблицу locations2 ещё 2 строки, не используя перечисления имён столбцов, в которые заносится информация. Пусть данные строки относятся к стране Франция. При написании значений, где возможно, используйте функции.


DESC HR.LOCATIONS;

INSERT INTO locations2 
VALUES (
    TRUNC(DBMS_RANDOM.VALUE * 10000), 
    SUBSTR('84 rue Porte d''Orange', 1, 40),
    SUBSTR('84300', 1, 40),
    SUBSTR('Cavaillon', 1, 30), 
    SUBSTR('Provence-Alpes-Côte d''Azur', 1, 24), 
    UPPER(SUBSTR('France', 1, 2))
);

INSERT INTO locations2 
VALUES (
    TRUNC(DBMS_RANDOM.VALUE * 10000), 
    SUBSTR('17 avenue Ferdinand de Lesseps', 1, 40),
    SUBSTR('06130', 1, 40),
    SUBSTR('Grasse', 1, 30), 
    SUBSTR('Provence-Alpes-Côte d''Azur', 1, 24), 
    UPPER(SUBSTR('France', 1, 2))
);

SELECT *
FROM locations2;


-- 5. Совершите commit.


COMMIT;


-- 6. Добавьте в таблицу locations2 строки из таблицы locations, в которых длина значения столбца state_province больше 9.


INSERT INTO locations2
SELECT *
FROM HR.locations
WHERE LENGTH(STATE_PROVINCE) > 9;

SELECT *
FROM locations2;


-- 7. Совершите commit.


COMMIT;


-- 8. Перепишите и запустите данный statemenet для создания таблицы locations4europe, которая будет содержать такие же столбцы, что и locations:


CREATE TABLE locations4europe AS (SELECT * FROM HR.LOCATIONS WHERE 1=2);

SELECT *
FROM locations4europe;


-- 9. Одним statement-ом добавьте в таблицу locations2 всю информацию для всех строк из таблицы locations, а в таблицу locations4europe добавьте информацию о id локации, адресе, городе, id страны только для тех строк из таблицы locations, где города находятся в Европе.


INSERT ALL
WHEN 1=1 THEN 
    INTO locations2 
    VALUES (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
WHEN COUNTRY_ID IN (
        SELECT COUNTRY_ID 
        FROM HR.COUNTRIES
        WHERE REGION_ID = 1) THEN
    INTO locations4europe (LOCATION_ID, STREET_ADDRESS, CITY, COUNTRY_ID)
    VALUES (LOCATION_ID, STREET_ADDRESS, CITY, COUNTRY_ID)
FROM HR.LOCATIONS;


-- 10. Совершите commit.


COMMIT;


-- 11. В таблице locations2 измените почтовый код на любое значение в тех строках, где сейчас нет информации о почтовом коде.


SELECT *
FROM locations2
WHERE POSTAL_CODE IS NULL;

-- STATE_PROVINCE	 VARCHAR2(25)

UPDATE locations2
SET POSTAL_CODE = TRUNC(DBMS_RANDOM.VALUE * POWER(10, 7))
WHERE POSTAL_CODE IS NULL;

SELECT * FROM locations2;


-- 12. Совершите rollback.


ROLLBACK;


-- 13. В таблице locations2 измените почтовый код в тех строках, где сейчас нет информации о почтовом коде. Новое значение должно быть кодом из таблицы locations для строки с id 2600.


UPDATE locations2
SET POSTAL_CODE = (
        SELECT POSTAL_CODE
        FROM locations2
        WHERE LOCATION_ID = 2600)
WHERE POSTAL_CODE IS NULL;

SELECT * FROM locations2;


-- 14. Совершите commit.


COMMIT;


-- 15. Удалите строки из таблицы locations2, где id страны «IT».


DELETE FROM locations2
WHERE UPPER(COUNTRY_ID) LIKE '%IT%';

SELECT * FROM locations2;


-- 16. Создайте первый savepoint.


SAVEPOINT s1;


-- 17. В таблице locations2 измените адрес в тех строках, где id локации больше 2500. Новое значение должно быть «Sezam st. 18»


UPDATE locations2
SET STREET_ADDRESS = 'Sezam st. 18'
WHERE LOCATION_ID > 2500;

SELECT * FROM locations2;


-- 18. Создайте второй savepoint.


SAVEPOINT s2;


-- 19. Удалите строки из таблицы locations2, где адрес равен «Sezam st. 18».


DELETE FROM locations2
WHERE LOWER(STREET_ADDRESS) LIKE '%sezam st. 18%';

SELECT * FROM locations2;


-- 20. Откатите изменения до первого savepoint.


ROLLBACK TO s1;


-- 21. Совершите commit.


COMMIT;
