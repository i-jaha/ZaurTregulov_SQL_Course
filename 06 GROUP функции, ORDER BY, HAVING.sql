/*
1. Получить репорт по department_id с минимальной и максимальной зарплатой, с самой ранней и самой поздней датой прихода на работу 
и с количеством сотрудников. Сортировать по количеству сотрудников (по убыванию).
*/
SELECT
    department_id,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    MIN(hire_date) AS early_date,
    MAX(hire_date) AS last_date,
    COUNT(*) AS count_emp
FROM HR.EMPLOYEES
GROUP BY department_id
ORDER BY count_emp DESC;

/*
2. Выведите информацию о первой букве имени сотрудника и количество имён, которые начинаются с этой буквы. 
Выводить строки для букв, где количество имён, начинающихся с неё больше 1. Сортировать по количеству.
*/
SELECT 
    SUBSTR(first_name, 1, 1) AS first_letter,
    COUNT(first_name) AS count_emp
FROM HR.EMPLOYEES
GROUP BY SUBSTR(first_name, 1, 1)
HAVING count_emp > 1
ORDER BY count_emp DESC;


/*
3. Выведите id департамента, з/п и количество сотрудников, которые работают в одном и том же департаменте и получают одинаковую зарплату.
*/
SELECT 
    department_id,
    salary,
    COUNT(*)
FROM HR.EMPLOYEES
GROUP BY department_id, salary;

/*
4. Выведите день недели и количество сотрудников, которых приняли на работу в этот день.
*/
SELECT 
    TO_CHAR(hire_date, 'Day') AS week_day,
    COUNT(employee_id) AS count_empl
FROM HR.EMPLOYEES
GROUP BY TO_CHAR(hire_date, 'Day');

/*
5. Выведите id департаментов, в которых работает больше 30 сотрудников и сумма их з/п-т больше 300000.
*/
SELECT department_id
FROM HR.EMPLOYEES
GROUP BY department_id
HAVING 
    COUNT(department_id) > 30
    AND SUM(salary) > 300000;

/*
6. Из таблицы countries вывести все region_id, для которых сумма всех букв их стран больше 50ти.
*/
SELECT region_id
FROM HR.COUNTRIES
GROUP BY region_id
HAVING SUM(LENGth(country_name)) > 50;

/*
7. Выведите информацию о job_id и округленную среднюю зарплату работников для каждого job_id.
*/
SELECT 
    job_id,
   ROUND(AVG(salary)) AS avg_salary
FROM HR.EMPLOYEES
GROUP BY job_id;

/*
8. Получить список id департаментов, в которых работают сотрудники нескольких (>1) job_id.
*/
SELECT department_id
FROM HR.EMPLOYEES
GROUP BY department_id
HAVING COUNT(DISTINCT job_id) > 1;

/*
9. Выведите информацию о department, job_id, максимальную и минимальную з/п для всех сочетаний department_id - job_id, где средняя з/п больше 10000.
*/
SELECT 
    department_id,
    job_id,
    MAX(salary) AS max_sal,
    MIN(salary) AS min_sal
FROM HR.EMPLOYEES
GROUP BY department_id, job_id
HAVING AVG(salary) > 10000;

/*
10. Получить список manager_id, у которых средняя зарплата всех его подчиненных, не имеющих комиссионные, находится в промежутке от 6000 до 9000.
*/
SELECT manager_id
FROM HR.EMPLOYEES
WHERE commission_pct IS NULL
GROUP BY manager_id
HAVING AVG(salary) BETWEEN 6000 AND 9000;

/*
11. Выведите округлённую до тысяч (не тысячных) максимальную зарплату среди всех средних зарплат по департаментам.
*/
SELECT ROUND(MAX(AVG(salary)), -3)
FROM HR.EMPLOYEES
GROUP BY department_id;