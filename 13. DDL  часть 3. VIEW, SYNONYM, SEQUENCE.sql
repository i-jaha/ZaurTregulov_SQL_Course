-- 1. Создать таблицу emp1000 с помощью subquery так, чтобы она после создания содержала значения следующих столбцов из таблицы employees: first_name, last_name, salary, department_id.
CREATE TABLE emp1000 AS (
    SELECT first_name, last_name, salary, department_id
    FROM HR.EMPLOYEES
);

SELECT *
FROM emp1000;

-- 2. Создать view v1000 на основе select-а, который объединяет таблицы emp1000 и departments по столбцу department_id. View должен содержать следующие столбцы: first_name, last_name, salary, department_name, city .
CREATE FORCE VIEW v1000 AS (
    SELECT 
        e.first_name, 
        e.last_name, 
        e.salary, 
        d.department_name,
        city
    FROM emp1000 e
    JOIN HR.DEPARTMENTS d ON e.department_id = d.department_id
);

SELECT *
FROM v1000;

-- 3. Добавьте в таблицу emp1000 столбец city .
ALTER TABLE emp1000 
ADD city VARCHAR2(30);

-- 4. Откомпилируйте view v1000.
ALTER VIEW v1000 COMPILE;

SELECT *
FROM v1000;


-- 5. Создайте синоним syn1000 для v1000.
CREATE SYNONYM syn1000 
FOR v1000; 

SELECT *
FROM syn1000;

-- 6. Удалите v1000.
DROP VIEW v1000;

-- 7. Удалите syn1000.
DROP SYNONYM syn1000;

-- 8. Удалите emp1000.
DROP TABLE emp1000;

-- 9. Создайте последовательность seq1000, которая начинается с 12, увеличивается на 4, имеет максимальное значение 200 и цикличность.
CREATE SEQUENCE seq1000
START WITH 12
INCREMENT BY 4
MAXVALUE 200
CYCLE;

SELECT seq1000.nextval
FROM dual;

-- 10. Измените эту последовательность. Удалите максимальное значение и цикличность.
ALTER SEQUENCE seq1000
NOMAXVALUE
NOCYCLE;

-- 11. Добавьте 2 строки в таблицу employees, используя минимально возможное количество столбцов. Воспользуйтесь последовательностью seq1000 при добавлении значений в столбец employee_id.
INSERT INTO HR.EMPLOYEES (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (seq1000.nextval, INITCAP('Morris'), UPPER('JMorris'), TO_DATE('01019999', 'DDMMYYYY'), 'IT_PROG');

INSERT INTO HR.EMPLOYEES (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (seq1000.nextval, INITCAP('Ostrander'), UPPER('EOstrander'), SYSDATE, 'IT_PROG');

-- 12. Совершите commit.
COMMIT;