-- 1. Выведите в одном репорте информацию о суммах з/п групп, объединённых по id менеджера, по job_id, по id департамента. Репорт должен содержать 4 столбца: id менеджера, job_id, id департамента, суммированная з/п.
SELECT 
    MANAGER_ID,
    TO_CHAR(NULL) AS JOB_ID,
    TO_NUMBER(NULL) AS DEPARTMENT_ID,
    SUM(SALARY)
FROM HR.EMPLOYEES
GROUP BY MANAGER_ID
                UNION
SELECT 
    TO_NUMBER(NULL) AS MANAGER_ID,
    JOB_ID,
    TO_NUMBER(NULL) AS DEPARTMENT_ID,
    SUM(SALARY)
FROM HR.EMPLOYEES
GROUP BY JOB_ID
                UNION
SELECT 
    TO_NUMBER(NULL) AS MANAGER_ID,
    TO_CHAR(NULL) AS JOB_ID,
    DEPARTMENT_ID,
    SUM(SALARY)
FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 2. Выведите id тех департаментов, где работает менеджер № 100 и не работают менеджеры № 145, 201.
SELECT DEPARTMENT_ID
FROM HR.EMPLOYEES e
WHERE e.MANAGER_ID = 100  
                MINUS
SELECT DEPARTMENT_ID
FROM HR.EMPLOYEES e
WHERE e.MANAGER_ID IN (145, 201);

-- 3. Используя SET операторы и не используя логические операторы, выведите уникальную информацию о именах, фамилиях и з/п сотрудников, второй символ в именах которых буква «а», и фамилия содержит букву «s» вне зависимости от регистра. Отсортируйте результат по з/п по убыванию.
SELECT 
    FIRST_NAME,
    LAST_NAME,
    SALARY
FROM HR.EMPLOYEES
WHERE FIRST_NAME LIKE '_a%'
    INTERSECT
SELECT 
    FIRST_NAME,
    LAST_NAME,
    SALARY
FROM HR.EMPLOYEES
WHERE UPPER(LAST_NAME) LIKE '%S%'
ORDER BY SALARY DESC;

-- 4. Используя SET операторы и не используя логические операторы, выведите информацию о id локаций, почтовом коде и городе для локаций, которые находятся в Италии или Германии. А также для локаций, почтовый код которых содержит цифру «9».
SELECT 
    LOCATION_ID,
    POSTAL_CODE,
    CITY
FROM HR.LOCATIONS
WHERE COUNTRY_ID = (
    SELECT COUNTRY_ID
    FROM HR.COUNTRIES
    WHERE COUNTRY_NAME IN ('Italy', 'Germany')
)
                UNION
SELECT 
    LOCATION_ID,
    POSTAL_CODE,
    CITY
FROM HR.LOCATIONS
WHERE POSTAL_CODE LIKE '%9%';

-- 5. Используя SET операторы и не используя логические операторы, выведите всю уникальную информацию для стран, длина имён которых больше 8 символов. А также для стран, которые находятся не в европейском регионе. Столбцы аутпута должны называться id, country, region. Аутпут отсортируйте по названию стран по убывающей
SELECT *
FROM HR.COUNTRIES
WHERE LENGTH(COUNTRY_NAME) > 8
                UNION
SELECT *
FROM HR.COUNTRIES
WHERE REGION_ID != (
    SELECT REGION_ID
    FROM HR.REGIONS
    WHERE REGION_NAME LIKE '%Europe%'
)
ORDER BY 2 DESC;