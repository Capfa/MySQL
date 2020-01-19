use shop;

-- 1 Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.


update users set created_at = null;
update users set updated_at  = null;

update users set created_at = now() ;
update users set updated_at  = now() ;

-- 2 Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

alter table users  change created_at  created_at VARCHAR(255);
alter table users  change updated_at  updated_at VARCHAR(255);

insert into users (created_at,updated_at)  values
('12.10.2005 08:10','14.01.2010 09:14'),
('10.01.2019 06:10','12.01.2020 19:14'),
('01.05.2019 22:22','20.12.2019 02:00');

UPDATE users SET created_at = STR_TO_DATE(created_at,'%d.%m.%Y %k:%i');
UPDATE users SET updated_at = STR_TO_DATE(updated_at,'%d.%m.%Y %k:%i');

alter table users  change created_at  created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
alter table users  change updated_at  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- 3 В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

insert into storehouses_products (value) values
(25),
(14),
(0),
(1),
(3),
(0),
(9),
(0);

SELECT * FROM storehouses_products 
ORDER BY IF( value = 0, 1, 0 ) , value ;


-- 1 Подсчитайте средний возраст пользователей в таблице users

select AVG(TIMESTAMPDIFF(YEAR, birthday_at ,NOW())) from users;

-- 2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

select date_format(date(concat_ws('-',year(now()), month(birthday_at), day(birthday_at))), '%W') as day_name,
count(*) as total from users group by day_name ;