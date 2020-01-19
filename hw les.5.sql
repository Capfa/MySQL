use shop;

-- 1 ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.


update users set created_at = null;
update users set updated_at  = null;

update users set created_at = now() ;
update users set updated_at  = now() ;

-- 2 ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.

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

-- 3 � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. ������, ������� ������ ������ ���������� � �����, ����� ���� �������.

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


-- 1 ����������� ������� ������� ������������� � ������� users

select AVG(TIMESTAMPDIFF(YEAR, birthday_at ,NOW())) from users;

-- 2 ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.

select date_format(date(concat_ws('-',year(now()), month(birthday_at), day(birthday_at))), '%W') as day_name,
count(*) as total from users group by day_name ;