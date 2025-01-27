-- 1. Создать таблицу address со следующими столбцами: id, country, city. При создании таблицы создайте на inline уровне unique constraint с именем ad_id_un на столбец id.
CREATE TABLE address (
    id INT CONSTRAINT ad_id_un UNIQUE, 
    country VARCHAR2(30), 
    city VARCHAR2(30)
);

-- 2. Создать таблицу friends со следующими столбцами: id, name, email, address_id, birthday. При создании таблицы создайте на inline уровне foreign key constraint на столбец address_id, который ссылается на столбец id из таблицы address, используйте опцию «on delete set null». Также при создании таблицы создайте на table уровне check constraint для проверки того, что длина имени должна быть больше 3-х.
CREATE TABLE friends (
    id INT, 
    name VARCHAR2(30), 
    email VARCHAR2(30), 
    address_id INT REFERENCES address(id) ON DELETE SET NULL, 
    birthday DATE,
    CONSTRAINT check_name CHECK (LENGTH(name) > 3)
);

-- 3. Создайте уникальный индекс на столбец id из таблицы friends.
CREATE UNIQUE INDEX fr_id_un ON friends(id);

-- 4. С помощью функционала «add» команды «alter table» создайте constraint primary key с названием fr_id_pk на столбец id из таблицы friends.
ALTER TABLE friends
ADD CONSTRAINT fr_id_pk PRIMARY KEY (id);

-- 5. Создайте индекс с названием fr_email_in на столбец email из таблицы friends.
CREATE INDEX fr_email_in
ON friends(email);

-- 6. С помощью функционала «modify» команды «alter table» создайте constraint not null с названием fr_email_nn на столбец email из таблицы friends.
ALTER TABLE friends
MODIFY email VARCHAR2(30) CONSTRAINT fr_email_nn NOT NULL;

-- 7. Удалите таблицу friends.
DROP TABLE friends;

-- 8. Удалите таблицу address.
DROP TABLE address;