-- 1. Получите список всех сотрудников с именем David
SELECT *
FROM HR.EMPLOYEES
WHERE FIRST_NAME LIKE '%David%';

-- 2. Получите список всех сотрудников, у которых job_id равен FI_ACCOUNT
SELECT *
FROM HR.EMPLOYEES
WHERE JOB_ID LIKE '%FI_ACCOUNT%';
    
-- 3. Выведите информацию о имени, фамилии, з/п и номере департамента для сотрудников из 50го департамента с зарплатой, большей 4000.
SELECT 
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    DEPARTMENT_ID
FROM HR.EMPLOYEES
WHERE 
    DEPARTMENT_ID = 50
    AND SALARY > 4000;
    
--4. Получите список всех сотрудников, которые работают или в 20м, или в 30м департаменте
SELECT *
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID IN (20, 30);
    
-- 5. Получите список всех сотрудников, у которых вторая и последняя буква в имени равна 'a'.
SELECT *
FROM HR.EMPLOYEES
WHERE FIRST_NAME LIKE '_a%a';
    
-- 6. Получите список всех сотрудников из 50го и из 80го департамента, у которых есть бонус(комиссионные). Отсортируйте строки по email (возрастающий порядок), используя его порядковый номер
SELECT *
FROM HR.EMPLOYEES
WHERE 
    DEPARTMENT_ID IN (50, 80)
    AND COMMISSION_PCT IS NOT NULL
ORDER BY EMAIL;
    
-- 7. Получите список всех сотрудников, у которых в имени содержатся минимум 2 буквы 'n'
SELECT *
FROM HR.EMPLOYEES
WHERE 
    FIRST_NAME LIKE '%n%n%' 
    OR FIRST_NAME  LIKE '%N%n%';
    
-- 8. Получить список всех сотрудников, у которых длина имени больше 4 букв. Отсортируйте строки по номеру департамента (убывающий порядок) так, чтобы значения “null” были в самом конце
SELECT *
FROM HR.EMPLOYEES
WHERE FIRST_NAME LIKE '_____%'
ORDER BY DEPARTMENT_ID DESC NULLS LAST;
    
-- 9. Получите список всех сотрудников, у которых зарплата находится в промежутке от 3000 до 7000 (включительно), нет бонуса (комиссионных) и job_id среди следующих вариантов: PU_CLERK, ST_MAN, ST_CLERK
SELECT *
FROM HR.EMPLOYEES
WHERE 
    SALARY BETWEEN 3000 AND 7000 
    AND COMMISSION_PCT IS NULL
    AND JOB_ID IN ('PU_CLERK', 'ST_MAN', 'ST_CLERK');
    
-- 10. Получите список всех сотрудников у которых в имени содержится символ '%'
SELECT *
FROM HR.EMPLOYEES
WHERE FIRST_NAME LIKE '%\%%' ESCAPE '\';
    
-- 11. Выведите информацию о job_id, имене и з/п для работников, рабочий id которых больше или равен 120 и job_id не равен IT_PROG. Отсортируйте строки по job_id (возрастающий порядок) и именам (убывающий порядок)
SELECT 
    JOB_ID,
    FIRST_NAME,
    SALARY
FROM HR.EMPLOYEES
WHERE 
    EMPLOYEE_ID >= 120
    OR JOB_ID NOT LIKE 'IT_PROG'
ORDER BY 
    JOB_ID, 
    FIRST_NAME DESC;