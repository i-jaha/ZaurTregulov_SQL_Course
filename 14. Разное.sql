-- 1. Создать таблицу test200 со следующими столбцами: id, name1, name2, address1, address2. 1-ый должен быть типа integer, остальные - varchar2.
CREATE TABLE test200 (
    id INT, 
    name1 VARCHAR2(30), 
    name2 VARCHAR2(30), 
    address1 VARCHAR2(30), 
    address2 VARCHAR2(30)
);

-- 2. Напишите такой шаблон для изменения строк, который при каждом запуске будет спрашивать, значение какого столбца меняется, на какое значение меняется и для какого значения id меняется.
UPDATE test200  SET &col = &col_val WHERE id = &id_val

-- 3. Напишите select, в котором требуется вывести всю информацию из таблицы test200 для строк, у которых столбцы name1 и name2 равны одному и тому же значению, а также столбцы address1 и address2 тоже равны одному и тому же значению. Напишите такой шаблон для этого statement-а, который при запуске один раз спросит всего 2 значения – одно для первых 2х столбцов и второе для других 2х столбцов.
SELECT *
FROM test200
WHERE
    (LOWER(address1) LIKE '%&&addr_val%' AND LOWER(address2) LIKE '%&addr_val%')
    AND (LOWER(name1) LIKE '%&&name_val%' AND LOWER(name2) LIKE '%&name_val%');

-- 4. Напишите команду/ды, которая удаляет сессионные значения для наших переменных
UNDEFINE id_val;
UNDEFINE col;
UNDEFINE col_val;
UNDEFINE addr_val;
UNDEFINE name_val;