use vk

-- ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке

SELECT firstname FROM users  GROUP BY firstname;

-- iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = true). При необходимости предварительно добавить такое поле в таблицу profiles со значением по умолчанию = false (или 0)

alter TABLE profiles
ADD is_active CHAR(1) DEFAULT '0';

UPDATE profiles
SET 
	is_active  = '1'
WHERE
	DATEDIFF(current_date, birthday) > 6570 ; -- 18*365=6570
	
-- iv. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)

delete from messages
where current_date < created_at ;	