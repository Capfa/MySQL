use shop;

-- 1 ѕусть в таблице users пол€ created_at и updated_at оказались незаполненными. «аполните их текущими датой и временем.


update users set created_at = null;
update users set updated_at  = null;

update users set created_at = now() ;
update users set updated_at  = now() ;

-- 2 “аблица users была неудачно спроектирована. «аписи created_at и updated_at были заданы типом VARCHAR и в них долгое врем€ помещались значени€ в формате "20.10.2017 8:10". Ќеобходимо преобразовать пол€ к типу DATETIME, сохранив введеные ранее значени€.

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

-- 3 ¬ таблице складских запасов storehouses_products в поле value могут встречатьс€ самые разные цифры: 0, если товар закончилс€ и выше нул€, если на складе имеютс€ запасы. Ќеобходимо отсортировать записи таким образом, чтобы они выводились в пор€дке увеличени€ значени€ value. ќднако, нулевые запасы должны выводитьс€ в конце, после всех записей.

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


-- 1 ѕодсчитайте средний возраст пользователей в таблице users

select AVG(TIMESTAMPDIFF(YEAR, birthday_at ,NOW())) from users;

-- 2 ѕодсчитайте количество дней рождени€, которые приход€тс€ на каждый из дней недели. —ледует учесть, что необходимы дни недели текущего года, а не года рождени€.

select date_format(date(concat_ws('-',year(now()), month(birthday_at), day(birthday_at))), '%W') as day_name,
count(*) as total from users group by day_name ;