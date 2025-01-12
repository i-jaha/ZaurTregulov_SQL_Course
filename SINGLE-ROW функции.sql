-- 1. Получите список всех сотрудников, у которых длина имени больше 10 букв.
SELECT *
FROM HR.EMPLOYEES
WHERE LENGTH(first_name) > 10;

-- 2. Получите список всех сотрудников, зарплата которых кратна 1000.
SELECT *
FROM HR.EMPLOYEES
WHERE MOD(SALARY, 1000) = 0;

-- 3. Выведите телефонный номер и первое 3х значное число телефонного номера сотрудника, если его номер представлен в формате ХХХ.ХХХ.ХХХХ
SELECT 
    phone_number,
    SUBSTR(phone_number, 1, 3)
FROM HR.EMPLOYEES
WHERE phone_number LIKE '___.___.___';

-- 4. Получите список всех сотрудников, у которых последняя буква в имени равна 'm' и длина имени больше 5ти.
SELECT *
FROM HR.EMPLOYEES
WHERE 
    SUBSTR(first_name, -1) = 'm'
    AND LENGTH(first_name) > 5;

-- 5. Выведите дату следующей пятницы.
SELECT NEXT_DAY(SYSDATE, 'FRIDAY')
FROM dual;

-- 6. Получите список всех сотрудников, которые работают в компании больше 12 лет и 6ти месяцев (150 месяцев).
SELECT *
FROM HR.EMPLOYEES
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 150;

-- 7. Выведите телефонный номер, заменив в значении PHONE_NUMBER все '.' на '-'.
SELECT REPLACE(PHONE_NUMBER, '.', '-') AS PHONE_NUMBER
FROM HR.EMPLOYEES;

-- 8. Выведите имя, email, job_id для всех работников в формате: STEVEN sking Ad_Pres
SELECT 
    UPPER(first_name),
    LOWER(email),
    INITCAP(job_id)
FROM HR.EMPLOYEES;

-- 9. Выведите информацию о имени работника и его з/п, не используя символ || , в таком виде: Steven24000
SELECT 
    CONCAT(FIRST_NAME, SALARY)
FROM HR.EMPLOYEES;


-- 10. Выведите информацию о дате приёма сотрудника на работу, округлённой дате приёма на работу до месяца и первом дне года приёма на работу.
SELECT 
    employee_id,
    ROUND(hire_date, 'MM'),
    TRUNC(hire_date, 'YYYY')
FROM HR.EMPLOYEES;

-- 11. Выведите информацию о имени и фамилии всех работников. 
-- Имя должно состоять из 10 символов и если длина имени меньше 10, то дополняйте до 10 символов знаком $. 
-- Фамилия должна состоять из 15 символов и если длина фамилии меньше 15, то перед фамилией ставьте столько знаков ! сколько необходимо.
SELECT 
    first_name,
    INSTR(first_name, 'a', 1, 2)
FROM HR.EMPLOYEES;

-- 12. Выведите имя сотрудника и позицию второй буквы ‘a’ в его имени.
SELECT 
    first_name,
    INSTR(first_name, 'a', 1, 1)
FROM HR.EMPLOYEES;

-- 13. Выведите на экран текст '!!!HELLO!! MY FRIEND!!!!!!!!' и тот же текст, но без символа восклицательный знак в начале и конце текста.
SELECT 
    '!!!HELLO!! MY FRIEND!!!!!!!!' as txt,
    TRIM(BOTH '!' FROM txt)
FROM dual;


/*
14. Выведите информацию о:
    - з/п работника,
    - з/п умноженной на коэффициент 3.1415 ,
    - округлённый до целого значения вариант увеличенной з/п-ты,
    - целое количество тысяч из увеличенной з/п.
*/
SELECT 
    salary,
    salary * 3.1415,
    ROUND(salary * 3.1415, 0),
    TRUNC(salary * 3.1415, -3)/1000
FROM HR.EMPLOYEES;

/*
15. Выведите информацию о:
    - дате приёма сотрудника на работу,
    - дате, которая была через пол года, после принятия сотрудника на
    работу,
    - дате последнего дня в месяце принятия сотрудника на работу.
*/
SELECT 
    hire_date,
    ADD_MONTHS(hire_date, 6)
    LAST_DAY(hire_date)
FROM HR.EMPLOYEES;

SELECT *
FROM HR.EMPLOYEES;