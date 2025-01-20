-- 1. Выведите всю информацию о сотрудниках, с самым длинным именем.
SELECT *
FROM HR.EMPLOYEES e
WHERE LENGTH(e.FIRST_NAME) = (
    SELECT MAX(LENGTH(e.FIRST_NAME))
        FROM HR.EMPLOYEES e
);

--2. Выведите всю информацию о сотрудниках, с зарплатой большей средней зарплаты всех сотрудников.
SELECT *
FROM HR.EMPLOYEES e
WHERE e.SALARY > (
    SELECT AVG(e.SALARY)
        FROM HR.EMPLOYEES e
);

-- 3. Получить город/города, где сотрудники в сумме зарабатывают меньше всего.
SELECT l.CITY
FROM HR.EMPLOYEES e
JOIN HR.DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN HR.LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID
GROUP BY l.CITY
HAVING SUM(e.SALARY) = (
    SELECT MIN(SUM(e.SALARY))
    FROM HR.EMPLOYEES e
    JOIN HR.DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
    JOIN HR.LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID
    GROUP BY l.CITY
);

-- 4. Выведите всю информацию о сотрудниках, у которых менеджер получает зарплату больше 15000.
SELECT *
FROM HR.EMPLOYEES e;
WHERE e.MANAGER_ID IN (
    SELECT EMPLOYEE_ID
    FROM HR.EMPLOYEES
    WHERE SALARY > 15000
);

-- 5. Выведите всю информацию о департаментах, в которых нет ни одного сотрудника.
SELECT *
FROM HR.DEPARTMENTS d
WHERE d.DEPARTMENT_ID NOT IN (
    SELECT DISTINCT e.DEPARTMENT_ID
    FROM HR.EMPLOYEES e
    WHERE DEPARTMENT_ID IS NOT NULL
);

-- 6. Выведите всю информацию о сотрудниках, которые не являются менеджерами.
SELECT *
FROM HR.EMPLOYEES e
WHERE e.EMPLOYEE_ID NOT IN (
    SELECT DISTINCT MANAGER_ID 
    FROM HR.EMPLOYEES 
    WHERE MANAGER_ID IS NOT NULL
);

-- 7. Выведите всю информацию о менеджерах, которые имеют в подчинении больше 6ти сотрудников.
SELECT *
FROM HR.EMPLOYEES e
WHERE (
    SELECT COUNT(*)
    FROM HR.EMPLOYEES 
    WHERE MANAGER_ID = e.EMPLOYEE_ID 
) > 6;

-- 8. Выведите всю информацию о сотрудниках, которые работают в департаменте с названием IT .
SELECT *
FROM HR.EMPLOYEES e
WHERE e.DEPARTMENT_ID IN (
    SELECT d.DEPARTMENT_ID
    FROM HR.DEPARTMENTS d
    WHERE UPPER(d.DEPARTMENT_NAME) = 'IT'
);

-- 9. Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в 2005ом году, но при это сами работники устроились на работу до 2005 года.
SELECT *
FROM HR.EMPLOYEES e
WHERE e.MANAGER_ID IN (
    SELECT EMPLOYEE_ID
    FROM EMPLOYEES
    WHERE TO_CHAR(hire_date, 'YYYY') = '2005'
    )
AND e.HIRE_DATE < TO_DATE('01-01-05', 'DD-MM-YY');

-- 10. Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в январе любого года, и длина job_title этих сотрудников больше 15ти символов.
SELECT *
FROM HR.EMPLOYEES e
WHERE e.MANAGER_ID IN (
    SELECT EMPLOYEE_ID
    FROM EMPLOYEES
    WHERE TO_CHAR(hire_date, 'MM') = '01'
)
AND e.JOB_ID IN (
    SELECT JOB_ID
    FROM HR.JOBS j
    WHERE LENGTH(JOB_TITLE) > 15
);