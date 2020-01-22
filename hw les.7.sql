use shop;

-- 1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select * from users u
where
id in (select user_id from orders)
group by id;



-- 2 Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT
id, name,
(SELECT name FROM catalogs WHERE id = catalog_id) AS 'catalog'
FROM
products;
