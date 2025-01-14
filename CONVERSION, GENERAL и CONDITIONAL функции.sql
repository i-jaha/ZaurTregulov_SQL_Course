-- 1. Используя функции, получите список всех сотрудников у которых в имени есть буква 'b' (без учета регистра).
SELECT *
FROM HR.EMPLOYEES
WHERE INSTR(LOWER(first_name), 'b') > 0;

-- 2. Используя функции, получите список всех сотрудников у которых в имени содержатся минимум 2 буквы 'a'.
SELECT *
FROM HR.EMPLOYEES
WHERE INSTR(LOWER(first_name), 'a', 1, 2);

-- 3. Получите первое слово из имени департамента, для тех департаментов, у которых название состоит больше, чем из одного слова.
SELECT 
    department_name,
    SUBSTR(department_name, 1, INSTR(department_name, ' ') - 1) AS first_word
FROM HR.DEPARTMENTS
WHERE INSTR(department_name, ' ') > 0;

-- 4. Получите имена сотрудников без первой и последней буквы в имени.
SELECT 
    first_name,
    SUBSTR(first_name, 2, LENGTH(first_name) - 2) AS short_name
FROM HR.EMPLOYEES;

-- 5. Получите список всех сотрудников, у которых в значении job_id после знака _ как минимум 3 символа, но при этом это значение после _ не равно 'CLERK'.
SELECT *
FROM HR.EMPLOYEES
WHERE
    SUBSTR(job_id, INSTR(job_id, '_')+1) > 3
    AND SUBSTR(job_id, INSTR(job_id, '_')+1) <> 'CLERK';


-- 6. Получите список всех сотрудников, которые пришли на работу в первый день любого месяца.
SELECT *
FROM HR.EMPLOYEES
WHERE TO_CHAR(hire_date, 'DD') = '01';

-- 7. Получите список всех сотрудников, которые пришли на работу в 2008ом году.
SELECT *
FROM HR.EMPLOYEES
WHERE TO_CHAR(hire_date, 'YYYY') = '2008';

-- 8. Покажите завтрашнюю дату в формате: Tomorrow is Second day of January
SELECT 
    TO_CHAR(SYSDATE+1, 'fm"Tomorrow is "Ddspth" day of "Month') AS info
FROM dual;

-- 9. Выведите имя сотрудника и дату его прихода на работу в формате: 21st of June, 2007
SELECT 
    first_name,
    TO_CHAR(hire_date, 'FMddth" of "Month, YYYY')
FROM HR.EMPLOYEES;

-- 10. Получите список работников с увеличенными зарплатами на 20%. Зарплату показать в формате: $28,800.00
SELECT 
    first_name,
    TO_CHAR(salary * 1.2, '$999,999.99') AS new_salary
FROM HR.EMPLOYEES;

-- 11. Выведите актуальную дату (нынешнюю), + секунда, + минута, + час, + день, + месяц, + год. (Всё это по отдельности прибавляется к актуальной дате).
SELECT 
    SYSDATE AS current_date,
    SYSDATE + 1/24/60/60 AS plus_one_second,
    SYSDATE + 1/24/60 AS plus_one_minute,
    SYSDATE + 1/24 AS plus_one_hour,
    SYSDATE + 1 AS plus_one_day,
    ADD_MONTHS(SYSDATE, 1) AS plus_one_month,
    ADD_MONTHS(SYSDATE, 12) AS plus_one_year
FROM dual;

-- 12. Выведите имя сотрудника, его з/п и новую з/п, которая равна старой плюс это значение текста «$12,345.55».
SELECT 
    first_name,
    salary,
    salary + TO_NUMBER('$12,345.55', '$99,999.99') AS new_salary
FROM HR.EMPLOYEES;

-- 13. Выведите имя сотрудника, день его трудоустройства, а также количество месяцев между днём его трудоустройства и датой, которую необходимо получить из текста «SEP, 18:45:00 18 2009».
SELECT 
    first_name,
    hire_date,
    TRUNC(MONTHS_BETWEEN(hire_date, TO_DATE('SEP, 18:45:00 18 2009', 'MON, HH24:MI:SS DD YYYY')), 0) AS months_worked
FROM HR.EMPLOYEES;

-- 14. Выведите имя сотрудника, его з/п, а также полную з/п (salary + commission_pct(%)) в формате: $24,000.00.
SELECT 
    first_name,
    salary,
    TO_CHAR(salary + salary * NVL(commission_pct, 0), '$99,999.99') AS full_salary
FROM HR.EMPLOYEES;


-- 15. Выведите имя сотрудника, его фамилию, а также выражение «different length», если длина имени не равна длине фамилии или выражение «same length», если длина имени равна длине фамилии. Не используйте conditional functions.
SELECT 
    first_name,
    last_name,
    NVL2(NULLIF(LENGTH(first_name), LENGTH(last_name)), 'different length', 'same length') AS legth_names
FROM HR.EMPLOYEES;

-- 16. Выведите имя сотрудника, его комиссионные, а также информацию о наличии бонусов к зарплате – есть ли у него комиссионные (Yes/No).
SELECT 
    first_name,
    commission_pct,
    NVL2(commission_pct, 'Yes', 'No') AS bonus
FROM HR.EMPLOYEES;

-- 17. Выведите имя сотрудника и значение которое его будет характеризовать: 
-- значение комиссионных, если присутствует, если нет, то id его менеджера, если и оно отсутствует, то его з/п.
SELECT 
    first_name,
    COALESCE(commission_pct, manager_id, salary) AS new_value
FROM HR.EMPLOYEES;

-- 18. Выведите имя сотрудника, его з/п, а также уровень зарплаты каждого сотрудника: 
-- Меньше 5000 считается Low level, Больше или равно 5000 и меньше 10000 считается Normal level, Больше или равно 10000 считается High level.
SELECT 
    first_name,
    salary,
    CASE
        WHEN salary < 5000 THEN 'Low level'
        WHEN salary >= 5000 AND salary < 10000 THEN 'Normal level'
        WHEN salary >= 10000 THEN 'High level'
    END AS salary_level
FROM HR.EMPLOYEES;

-- 19. Для каждой страны показать регион, в котором она находится: 
-- 10- Europe, 20-America, 30-Asia, 40-Africa . Выполнить данное задание, не используя функционал JOIN. Используйте DECODE.
SELECT
	country_name,
	DECODE(region_id,
		10, 'Europe',
		20, 'America',
		30, 'Asia',
		40, 'Africa')
	AS region
FROM HR.COUNTRIES;

-- 20. Задачу №19 решите используя CASE.
SELECT
	country_name,
	CASE region_id
		WHEN 10 THEN 'Europe'
		WHEN 20 THEN 'America'
		WHEN 30 THEN 'Asia'
		WHEN 40 THEN 'Africa'
	END	AS region
FROM HR.COUNTRIES;

/*
21. Выведите имя сотрудника, его з/п, а также уровень того, насколько у сотрудника хорошие условия :
    1. BAD: з/п меньше 10000 и отсутствие комиссионных;
    2. NORMAL: з/п между 10000 и 15000 или, если присутствуют
    комиссионные;
    3. GOOD: з/п больше или равна 15000.
*/
SELECT 
    first_name,
    salary,
    CASE
        WHEN salary < 10000 AND commission_pct IS NULL THEN 'BAD'
        WHEN (salary BETWEEN 10000 AND 15000-1) OR commission_pct IS NOT NULL THEN 'NORMAL'
        WHEN salary >= 15000 THEN 'GOOD'
    END AS work_cond
FROM HR.EMPLOYEES;