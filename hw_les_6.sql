use vk;
-- 1 Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
select (select  CONCAT(firstname, ' ', lastname) from users where id = most_active_id
) as most_active, all_messages from (
select most_active_id, count(*) as all_messages from (
select to_user_id AS most_active_id FROM messages WHERE from_user_id = 9
union all
select from_user_id FROM messages WHERE to_user_id = 9
)as A
group by most_active_id
) as result_table
group by most_active
order by all_messages desc
limit 1;

-- 2 Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

select count(*) as total_likes_4children from likes l where media_id in (select id from media where user_id in (select user_id from profiles where (birthday + interval 10 year) > now()));