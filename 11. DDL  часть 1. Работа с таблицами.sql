-- 1. Создать таблицу friends с помощью subquery так, чтобы она после создания содержала значения следующих столбцов из таблицы employees: employee_id, first_name, last_name для тех строк, где имеются комиссионные. Столбцы в таблице friends должны называться id, name, surname .

CREATE TABLE friends
AS (
    SELECT 	
        EMPLOYEE_ID ID,
        FIRST_NAME NAME,
        LAST_NAME SURNAME
    FROM HR.EMPLOYEES
    WHERE COMMISSION_PCT IS NOT NULL
);


-- 2. Добавить в таблицу friends новый столбец email .

ALTER TABLE friends
ADD EMAIL VARCHAR2(30);


-- 3. Изменить столбец email так, чтобы его значение по умолчанию было «no email».

ALTER TABLE friends
MODIFY EMAIL VARCHAR2(30) DEFAULT 'no email';


-- 4. Проверить добавлением новой строки, работает ли дефолтное значение столбца email.

INSERT INTO friends(ID, NAME, SURNAME)
VALUES (180, INITCAP('vladislava'), INITCAP('hasanova'));


-- 5. Изменить название столбца с id на friends_id .

ALTER TABLE friends
RENAME COLUMN ID TO FRIEND_ID;


-- 6. Удалить таблицу friends.

DROP TABLE friends;


-- 7. Создать таблицу friends2 со следующими столбцами: id, name, surname, email, salary, city, birthday. У столбцов salary и birthday должны быть значения по умолчанию.

CREATE TABLE friends (
    ID INT,
    NAME VARCHAR2(50) NOT NULL,
    SURNAME VARCHAR2(50) NOT NULL,
    EMAIL VARCHAR2(100) UNIQUE,
    SALARY NUMBER(10, 2) DEFAULT 203,
    CITY VARCHAR(100),
    BIRTHDAY DATE DEFAULT TO_DATE('01-01-9999', 'DD-MM-YYYY')
);


-- 8. Добавить 1 строку в таблицу friends со всеми значениями.

INSERT INTO friends (ID, NAME, SURNAME, EMAIL, SALARY, CITY, BIRTHDAY)
VALUES (1, 'Dashiell', 'Steed', 'dashiell.steed@example.com', 500.00, 'Kentucky', DATE '1990-05-15');


-- 9. Добавить 1 строку в таблицу friends со всеми значениями кроме salary и birthday.

INSERT INTO friends (ID, NAME, SURNAME, EMAIL, CITY)
VALUES (2, 'Kelli', 'Irving', 'kelli.irving@example.com', 'Washington');


-- 10. Совершить commit.

COMMIT;


-- 11. Удалить столбец salary.

ALTER TABLE friends
DROP COLUMN SALARY;


-- 12. Сделать столбец email неиспользуемым (unused).

ALTER TABLE friends
SET UNUSED COLUMN EMAIL;


-- 13. Сделать столбец birthday неиспользуемым (unused).

ALTER TABLE friends
SET UNUSED COLUMN BIRTHDAY;


-- 14. Удалить из таблицы friends неиспользуемые столбцы.

ALTER TABLE friends DROP UNUSED COLUMNS;


-- 15. Сделать таблицу friends пригодной только для чтения.

ALTER TABLE friends READ ONLY;


-- 16. Проверить предыдущее действие любой DML командой.

INSERT INTO friends (ID, NAME, SURNAME, EMAIL, CITY)
VALUES (3, 'Lachlan', 'Ellington', 'lachlan.ellington@example.com', 'Stockton');


-- 17. Опустошить таблицу friends.

TRUNCATE TABLE friends;


-- 18. Удалить таблицу friends.

DROP TABLE friends;
