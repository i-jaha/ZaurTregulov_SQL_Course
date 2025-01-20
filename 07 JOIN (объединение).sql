-- 1. Выведите информацию о регионах и количестве сотрудников в каждом регионе.
SELECT r.region_name, COUNT(*) 
FROM HR.employees e
JOIN HR.departments d ON e.department_id = d.department_id
JOIN HR.locations l ON d.location_id = l.location_id
JOIN HR.countries c ON l.country_id = c.country_id
JOIN HR.regions r ON c.region_id = r.region_id
GROUP BY r.region_name;

-- 2. Выведите детальную информацию о каждом сотруднике: имя, фамилия, название департамента, job_id, адрес, страна и регион.
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    e.job_id,
    l.street_address,
    c.country_name,
    r.region_name
FROM HR.EMPLOYEES e 
JOIN HR.DEPARTMENTS d ON e.department_id = d.department_id
JOIN HR.LOCATIONS l ON d.location_id = l.location_id
JOIN HR.COUNTRIES c ON l.country_id = c.country_id
JOIN HR.REGIONS r ON c.region_id = r.region_id;
    
-- 3. Выведите информацию о имени менеджеров которые имеют в подчинении больше 6ти сотрудников, а также выведите количество сотрудников, которые им подчиняются.
SELECT
    e2.first_name AS "Manager name",
    COUNT(e1.EMPLOYEE_ID) AS "Employee count"
FROM HR.EMPLOYEES e1
JOIN HR.EMPLOYEES e2 ON e1.MANAGER_ID = e2.EMPLOYEE_ID
GROUP BY e2.EMPLOYEE_ID, e2.first_name
HAVING COUNT(e1.EMPLOYEE_ID) > 6
ORDER BY COUNT(e1.EMPLOYEE_ID);
    
-- 4. Выведите информацию о названии всех департаментов и о количестве работников, если в департаменте работают больше 30ти сотрудников. Используйте технологию «USING» для объединения по id департамента.
SELECT 
    d.DEPARTMENT_NAME,
    COUNT(*)
FROM HR.DEPARTMENTS d
JOIN HR.EMPLOYEES e USING (department_id)
GROUP BY d.DEPARTMENT_NAME
HAVING COUNT(*) > 30;

-- 5. Выведите названия всех департаментов, в которых нет ни одного сотрудника.
SELECT d.DEPARTMENT_NAME
FROM HR.DEPARTMENTS d
LEFT JOIN HR.EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
WHERE e.first_name IS NULL;

-- 6. Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в 2005ом году, но при это сами работники устроились на работу до 2005 года.
SELECT emp.*
FROM HR.employees emp 
JOIN HR.employees man ON (emp.manager_id = man.employee_id)
WHERE 
    TO_CHAR(man.hire_date, 'YYYY') = '2005'
    AND emp.hire_date < TO_DATE('01-01-2005', 'DD-MM-YYYY');

-- 7. Выведите название страны и название региона этой страны, используя natural join.
SELECT 
    country_name,
    region_name
FROM HR.COUNTRIES
NATURAL JOIN HR.REGIONS;

-- 8. Выведите имена, фамилии и з/п сотрудников, которые получают меньше, чем (минимальная з/п по их специальности + 1000).
SELECT 
    e.FIRST_NAME,
    e.LAST_NAME,
    e.SALARY,
    j.MIN_SALARY + 1000 AS MIN_EXP_SALARY
FROM HR.EMPLOYEES e
JOIN HR.JOBS j 
ON (e.job_id = j.job_id AND e.salary < (j.MIN_SALARY + 1000));
    
-- 9. Выведите уникальные имена и фамилии сотрудников, названия стран, в которых они работают. Также выведите информацию о сотрудниках, о странах которых нет информации. А также выведите все страны, в которых нет сотрудников компании.
SELECT DISTINCT e.first_name, e.last_name, c.country_name
FROM HR.EMPLOYEES e
FULL OUTER JOIN HR.DEPARTMENTS d ON e.department_id = d.department_id
FULL OUTER JOIN HR.LOCATIONS l ON d.location_id = l.location_id
FULL OUTER JOIN HR.COUNTRIES c ON l.country_id = c.country_id;
    
-- 10. Выведите имена и фамилии всех сотрудников, а также названия стран, которые мы получаем при объединении работников со всеми странами без какой-либо логики.
SELECT 
    e.first_name,
    e.last_name,
    c.country_name
FROM HR.EMPLOYEES e
CROSS JOIN HR.COUNTRIES c;
    
-- 11. Решите задачу № 1, используя Oracle Join синтаксис.
SELECT r.region_name, COUNT(*) 
FROM 
    HR.employees e,
    HR.departments d,
    HR.locations l,
    HR.countries c,
    HR.regions r
WHERE
    e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND l.country_id = c.country_id
    AND c.region_id = r.region_id
GROUP BY r.region_name;
    
-- 12. Решите задачу № 5, используя Oracle Join синтаксис.
SELECT d.DEPARTMENT_NAME
FROM HR.DEPARTMENTS d, HR.EMPLOYEES e
WHERE 
    d.DEPARTMENT_ID = e.DEPARTMENT_ID (+)
    AND e.first_name IS NULL;